import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hero_location/core/utils/app_colors.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hero_location/widgets/custom_elevated_button.dart';
import 'package:hero_location/widgets/custom_text_form_field.dart';
import 'package:hero_location/core/utils/app_validator.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientDetailsScreen extends StatefulWidget {
  static const String routeName = 'ClientDetailsScreen';
  final String clientId;

  const ClientDetailsScreen({super.key, required this.clientId});

  @override
  State<ClientDetailsScreen> createState() => _ClientDetailsScreenState();
}

class _ClientDetailsScreenState extends State<ClientDetailsScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  LatLng? currentLocation;
  bool isLocationFetched = false;
  bool isFetchingLocation = false;
  bool isSavingClient = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadClientData();
    });
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> loadClientData() async {
    setState(() => isLoading = true);
    try {
      final agentId = FirebaseAuth.instance.currentUser!.uid;

      final doc = await FirebaseFirestore.instance
          .collection('users') // 👈 تم التغيير من 'agents' إلى 'users'
          .doc(agentId)
          .collection('customers')
          .doc(widget.clientId)
          .get();

      print('Client data: ${doc.data()}'); // 👈 للتحقق من الداتا

      if (doc.exists) {
        final data = doc.data()!;
        nameController.text = data['name'] ?? '';
        phoneController.text = data['phone'] ?? '';
        addressController.text = data['address'] ?? '';

        if (data['location'] != null) {
          final geoPoint = data['location'] as GeoPoint;
          currentLocation = LatLng(geoPoint.latitude, geoPoint.longitude);
          isLocationFetched = true; // 👈 تحديث حالة اللوكيشن
        }
      } else {
        showSnackBar('Client not found');
      }
    } catch (e) {
      showSnackBar('Error loading client data: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> fetchCurrentLocation() async {
    setState(() => isFetchingLocation = true);

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showSnackBar("Location services are disabled");
      setState(() => isFetchingLocation = false);
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showSnackBar("Location permission denied");
        setState(() => isFetchingLocation = false);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      showSnackBar("Location permission permanently denied");
      setState(() => isFetchingLocation = false);
      return;
    }

    final pos = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 10,
      ),
    );

    setState(() {
      currentLocation = LatLng(pos.latitude, pos.longitude);
      isLocationFetched = true;
      isFetchingLocation = false;
    });
  }

  Future<void> saveClientData() async {
    if (!formKey.currentState!.validate()) {
      setState(() => autovalidateMode = AutovalidateMode.always);
      return;
    }

    setState(() => isSavingClient = true);
    try {
      final agentId = FirebaseAuth.instance.currentUser!.uid;

      await FirebaseFirestore.instance
          .collection('users') // 👈 تم التغيير من 'agents' إلى 'users'
          .doc(agentId)
          .collection('customers')
          .doc(widget.clientId)
          .update({
            'name': nameController.text.trim(),
            'phone': phoneController.text.trim(),
            'address': addressController.text.trim(),
            if (currentLocation != null)
              'location': GeoPoint(
                currentLocation!.latitude,
                currentLocation!.longitude,
              ),
            'updatedAt': FieldValue.serverTimestamp(), // 👈 إضافة لتحديث الوقت
          });

      showSnackBar("Client updated successfully");
      Navigator.pop(context, true);
    } catch (e) {
      showSnackBar("Error updating client: $e");
    } finally {
      setState(() => isSavingClient = false);
    }
  }

  Future<void> openGoogleMaps() async {
    if (currentLocation == null) {
      showSnackBar("No location available");
      return;
    }

    final url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${currentLocation!.latitude},${currentLocation!.longitude}',
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      showSnackBar("Could not open Google Maps");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Client Details", style: GoogleFonts.poppins()),
        backgroundColor: AppColors.primryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: const EdgeInsets.all(30),
                height: 175,
                color: Colors.grey[400],
                child: currentLocation == null
                    ? const Center(
                        child: Icon(Icons.map, size: 50, color: Colors.white),
                      )
                    : FlutterMap(
                        options: MapOptions(
                          onTap: (tap, point) => openGoogleMaps(),
                          initialCenter: currentLocation!,
                          initialZoom: 16,
                          interactionOptions: const InteractionOptions(
                            flags: InteractiveFlag.none,
                          ),
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://api.maptiler.com/maps/openstreetmap/{z}/{x}/{y}.jpg?key=pP5dm4nw5yGr5Yosmn2z',
                            userAgentPackageName: 'com.example.hero_location',
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                width: 80,
                                height: 80,
                                point: currentLocation!,
                                child: const Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                  size: 40,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: CustomElevatedButton(
                  onPressed: isFetchingLocation ? null : fetchCurrentLocation,
                  child: isFetchingLocation
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          'Update Location',
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Name'),
              const SizedBox(height: 8),
              CustomTextFormField(
                hintText: "Client Name",
                labelText: 'name',
                keyboardType: TextInputType.name,
                controller: nameController,
                validator: AppValidator.validateName,
              ),
              const SizedBox(height: 10),
              const Text('Phone'),
              const SizedBox(height: 8),
              CustomTextFormField(
                hintText: "Client Phone",
                labelText: 'phone',
                keyboardType: TextInputType.phone,
                controller: phoneController,
                validator: AppValidator.validatePhone,
              ),
              const SizedBox(height: 10),
              const Text('Address'),
              const SizedBox(height: 8),
              CustomTextFormField(
                hintText: "Client Address",
                labelText: 'address',
                keyboardType: TextInputType.streetAddress,
                controller: addressController,
                validator: AppValidator.validateAddress,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: CustomElevatedButton(
                  onPressed: isSavingClient ? null : saveClientData,
                  child: isSavingClient
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          'Save',
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
