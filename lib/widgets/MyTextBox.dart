import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
 final int? maxLines;
 final FormFieldValidator validator;
  const CustomTextField({Key? key,required this.controller, required this.hintText,this.maxLines, required this.validator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
    validator: (value) {

    },
      maxLines: maxLines,
      controller: controller,
      decoration:  InputDecoration(

        border: const OutlineInputBorder(),
        errorStyle: const TextStyle(fontSize: 20.0),
        hintText: hintText,
        fillColor: Colors.grey,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
      ),
    );
  }
}
