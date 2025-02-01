import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  final String label;
  final TextInputType keyboardType;
  final TextEditingController controller;

  const CustomFormField(
      {super.key,
      required this.label,
      required this.keyboardType,
      required this.controller});

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: const TextStyle(color: Colors.blueAccent),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.indigo,
          ),
        ),
      ),
    );
  }
}
