import 'package:flutter/material.dart';
import 'package:hero_location/widgets/custom_elevated_button.dart';
import 'package:hero_location/widgets/custom_text_form_field.dart';

class AddClintLocationForm extends StatelessWidget {
  const AddClintLocationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
        ),
        SizedBox(height: 10),
        Text('phone'),
        SizedBox(height: 8),
        CustomTextFormField(
          hintText: "Clint Phone",
          labelText: 'phone',
          keyboardType: TextInputType.phone,
        ),
        SizedBox(height: 10),
        Text('address'),
        SizedBox(height: 8),
        CustomTextFormField(
          hintText: "Clint Address",
          labelText: 'address',
          keyboardType: TextInputType.streetAddress,
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          child: CustomElevatedButton(
            textOnButton: 'Add Clint',
            onPressed: () {},
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
