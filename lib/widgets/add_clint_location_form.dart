import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hero_location/l10n/app_localizations.dart';
import 'package:hero_location/services/firestore_service.dart';
import 'package:latlong2/latlong.dart';
import 'package:hero_location/core/utils/app_validator.dart';
import 'package:hero_location/widgets/custom_elevated_button.dart';
import 'package:hero_location/widgets/custom_text_form_field.dart';
import 'package:url_launcher/url_launcher.dart';

class AddClintLocationForm extends StatefulWidget {
  const AddClintLocationForm({super.key});

  @override
  State<AddClintLocationForm> createState() => _AddClintLocationFormState();
}

class _AddClintLocationFormState extends State<AddClintLocationForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  LatLng? currentLocation;
  bool isLocationFetched = false;
  bool isFetchingLocation = false;
  bool isSavingClient = false;

  void showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> fetchCurrentLocation() async {
    if (isLocationFetched) return;

    setState(() => isFetchingLocation = true);

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showSnackBar(AppLocalizations.of(context)!.locationServicesDisabled);
      setState(() => isFetchingLocation = false);
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showSnackBar(AppLocalizations.of(context)!.locationPermissionDenied);
        setState(() => isFetchingLocation = false);
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showSnackBar(
        AppLocalizations.of(context)!.locationPermissionPermanentlyDenied,
      );
      setState(() => isFetchingLocation = false);
      return;
    }

    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.best,
      distanceFilter: 10,
    );

    Position pos = await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );

    setState(() {
      currentLocation = LatLng(pos.latitude, pos.longitude);
      isLocationFetched = true;
      isFetchingLocation = false;
    });
  }

  Future<void> openGoogleMaps() async {
    if (currentLocation != null) {
      final url = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=${currentLocation!.latitude},${currentLocation!.longitude}',
      );
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        showSnackBar(AppLocalizations.of(context)!.couldNotOpenGoogleMaps);
      }
    }
  }

  Future<void> addClient() async {
    if (!formKey.currentState!.validate()) {
      setState(() => autovalidateMode = AutovalidateMode.always);
      return;
    }

    if (currentLocation == null) {
      showSnackBar(AppLocalizations.of(context)!.pleaseGetCurrentLocationFirst);
      return;
    }

    setState(() => isSavingClient = true);

    try {
      await FirestoreService.addCustomer(
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
        address: addressController.text.trim(),
        location: GeoPoint(
          currentLocation!.latitude,
          currentLocation!.longitude,
        ),
        agentId: FirebaseAuth.instance.currentUser!.uid,
      );
      // FirebaseFirestore.instance.collection('customers').add({
      //   'name': nameController.text.trim(),
      //   'phone': phoneController.text.trim(),
      //   'address': addressController.text.trim(),
      //   'location': GeoPoint(
      //     currentLocation!.latitude,
      //     currentLocation!.longitude,
      //   ),
      //   'agentId': FirebaseAuth.instance.currentUser!.email,
      // 'createdAt': FieldValue.serverTimestamp(),
      // });
      Navigator.pop(context);
      showSnackBar(AppLocalizations.of(context)!.clientAddedSuccessfully);

      // تفريغ الفورم
      nameController.clear();
      phoneController.clear();
      addressController.clear();
      setState(() {
        currentLocation = null;
        isLocationFetched = false;
      });
    } catch (e) {
      showSnackBar("Error: $e");
    } finally {
      setState(() => isSavingClient = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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
                      onTap: (tapPosition, point) => openGoogleMaps(),
                      initialCenter: currentLocation!,
                      initialZoom: 16.0,
                      interactionOptions: InteractionOptions(
                        flags: InteractiveFlag.none,
                      ),
                      // غير قابل للسحب
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
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 40,
                            ),
                            width: 80,
                            height: 80,
                            point: currentLocation!,
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
                      AppLocalizations.of(context)!.getCurrentLocation,
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
            ),
          ),
          const SizedBox(height: 20),
          Text(AppLocalizations.of(context)!.name),
          const SizedBox(height: 8),
          CustomTextFormField(
            hintText: AppLocalizations.of(context)!.clientName,
            labelText: AppLocalizations.of(context)!.name,
            keyboardType: TextInputType.name,
            controller: nameController,
            validator: (value) => AppValidator.validateName(context, value),
          ),
          const SizedBox(height: 10),
          Text(AppLocalizations.of(context)!.phoneNumber),
          const SizedBox(height: 8),
          CustomTextFormField(
            hintText: AppLocalizations.of(context)!.clientPhone,
            labelText: AppLocalizations.of(context)!.phoneNumber,
            keyboardType: TextInputType.phone,
            controller: phoneController,
            validator: (value) => AppValidator.validatePhone(context, value),
          ),
          const SizedBox(height: 10),
          Text(AppLocalizations.of(context)!.phoneNumber),
          const SizedBox(height: 8),
          CustomTextFormField(
            hintText: AppLocalizations.of(context)!.clientAddress,
            labelText: AppLocalizations.of(context)!.address,
            keyboardType: TextInputType.streetAddress,
            controller: addressController,
            validator: (value) => AppValidator.validateAddress(context, value),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: CustomElevatedButton(
              onPressed: isSavingClient ? null : addClient,
              child: isSavingClient
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(
                      AppLocalizations.of(context)!.addClient,
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
