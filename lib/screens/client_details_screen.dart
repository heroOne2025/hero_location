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

  String? currentUserRole;
  Timestamp? createdAt;
  bool isEditable = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.wait([loadCurrentUserRole(), loadClientData()]);
      _updateEditableStatus(); // 👈 تحديث نهائي بعد الاثنين
    });
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> loadCurrentUserRole() async {
    try {
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .get();
      if (doc.exists) {
        currentUserRole = doc.data()!['role'] ?? 'agent';
      }
    } catch (e) {
      showSnackBar('Error loading user role: $e');
    }
  }

  void _updateEditableStatus() {
    if (currentUserRole == 'admin') {
      isEditable = true; // 👈 Admin دائمًا يعدل
    } else if (currentUserRole == 'agent' && createdAt != null) {
      final now = DateTime.now();
      final creationTime = createdAt!.toDate();
      final difference = now.difference(creationTime);
      isEditable =
          difference < const Duration(hours: 12); // 👈 Agent خلال 12 ساعة بس
    } else {
      isEditable = false;
    }
    setState(() {});
  }

  Future<void> loadClientData() async {
    setState(() => isLoading = true);
    try {
      final agentId = FirebaseAuth.instance.currentUser!.uid;

      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(agentId)
          .collection('customers')
          .doc(widget.clientId)
          .get();

      if (doc.exists) {
        final data = doc.data()!;
        nameController.text = data['name'] ?? '';
        phoneController.text = data['phone'] ?? '';
        addressController.text = data['address'] ?? '';

        createdAt = data['createdAt']; // 👈 جلب وقت الإضافة

        if (data['location'] != null) {
          final geoPoint = data['location'] as GeoPoint;
          currentLocation = LatLng(geoPoint.latitude, geoPoint.longitude);
          isLocationFetched = true;
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
    if (!isEditable) return; // 👈 منع لو مش editable

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
    if (!isEditable) {
      showSnackBar('You do not have permission to edit');
      return;
    }

    if (!formKey.currentState!.validate()) {
      setState(() => autovalidateMode = AutovalidateMode.always);
      return;
    }

    setState(() => isSavingClient = true);
    try {
      final agentId = FirebaseAuth.instance.currentUser!.uid;

      await FirebaseFirestore.instance
          .collection('users')
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
            'updatedAt': FieldValue.serverTimestamp(),
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
                          onTap: currentLocation != null
                              ? (tap, point) => openGoogleMaps()
                              : null, // 👈 يفتح للكل لو في لوكيشن
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
              if (isEditable)
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
                validator: isEditable ? AppValidator.validateName : null,
                enabled: isEditable, // 👈 تعطيل لو مش editable
              ),
              const SizedBox(height: 10),
              const Text('Phone'),
              const SizedBox(height: 8),
              CustomTextFormField(
                hintText: "Client Phone",
                labelText: 'phone',
                keyboardType: TextInputType.phone,
                controller: phoneController,
                validator: isEditable ? AppValidator.validatePhone : null,
                enabled: isEditable,
              ),
              const SizedBox(height: 10),
              const Text('Address'),
              const SizedBox(height: 8),
              CustomTextFormField(
                hintText: "Client Address",
                labelText: 'address',
                keyboardType: TextInputType.streetAddress,
                controller: addressController,
                validator: isEditable ? AppValidator.validateAddress : null,
                enabled: isEditable,
              ),
              const SizedBox(height: 20),
              if (isEditable)
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
              if (!isEditable)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    currentUserRole == 'admin'
                        ? 'View only mode: Only admins can edit client details.'
                        : 'View only mode: Only admins or within 12 hours of creation can edit.',
                    style: GoogleFonts.poppins(
                      color: Colors.orange,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
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
