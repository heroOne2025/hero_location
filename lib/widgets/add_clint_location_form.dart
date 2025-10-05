import 'package:flutter/material.dart';
import 'package:hero_location/core/utils/app_validator.dart';
import 'package:hero_location/widgets/custom_elevated_button.dart';
import 'package:hero_location/widgets/custom_text_form_field.dart';

class AddClintLocationForm extends StatefulWidget {
  const AddClintLocationForm({super.key});

  @override
  State<AddClintLocationForm> createState() => _AddClintLocationFormState();
}

class _AddClintLocationFormState extends State<AddClintLocationForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.all(30),
            height: 175,
            width: 100,
            color: Colors.grey[400],
            child: const Center(
              child: Icon(Icons.map, size: 50, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: CustomElevatedButton(
              textOnButton: 'Get Current Location',
              onPressed: () {},
            ),
          ),
          const SizedBox(height: 20),
          Text('name'),
          SizedBox(height: 8),
          CustomTextFormField(
            hintText: "Clint Name",
            labelText: 'name',
            keyboardType: TextInputType.name,
            controller: nameController,
            validator: (value) => AppValidator.validateName(value),
          ),
          SizedBox(height: 10),
          Text('phone'),
          SizedBox(height: 8),
          CustomTextFormField(
            hintText: "Clint Phone",
            labelText: 'phone',
            keyboardType: TextInputType.phone,
            controller: phoneController,
            validator: (value) => AppValidator.validatePhone(value),
          ),
          SizedBox(height: 10),
          Text('address'),
          SizedBox(height: 8),
          CustomTextFormField(
            hintText: "Clint Address",
            labelText: 'address',
            keyboardType: TextInputType.streetAddress,
            validator: (value) => AppValidator.validateAddress(value),
            controller: adressController,
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: CustomElevatedButton(
              textOnButton: 'Add Clint',
              onPressed: () {
                if (formKey.currentState!.validate()) {
                } else {
                  setState(() {
                    autovalidateMode = AutovalidateMode.always;
                  });
                }
              },
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
