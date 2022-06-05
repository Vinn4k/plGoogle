import 'package:flutter/material.dart';

class FormWidget {
  Widget form(
      {required TextEditingController controller, required String label}) {
    return TextFormField(
      controller: controller,
      cursorColor: const Color(0xff87d039),
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2.0),
        ),
        focusedBorder:const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff23BDFC), width: 2.0),
        ),
        focusColor: Colors.white,
        label: Text(label),
        fillColor: Colors.white,
        labelStyle: const TextStyle(color: Colors.white),

      ),
      style: const TextStyle(color: Colors.white),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Insira sua Id';
        }
        return null;
      },
    );
  }
}
