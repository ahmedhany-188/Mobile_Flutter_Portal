import 'package:flutter/material.dart';
class InputTextField extends StatelessWidget {
  const InputTextField({Key? key, required this.hintText,
    required this.icon, required this.enabled,
    required this.initialValue}) : super(key: key);
  final String hintText;
  final Icon icon;
  final bool enabled;
  final String initialValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: TextFormField(
        initialValue: initialValue,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[800]),
          labelText: hintText,
          fillColor: Colors.white70,
          prefixIcon:  icon,
          enabled: enabled,



        ),

      ),
    );
  }
}