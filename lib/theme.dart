import 'package:flutter/material.dart';

Color themeColor = const Color(0xff4675C0);

InputDecoration authInputDecoration(String label, bool err, String errText) =>
    InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      errorText: err ? errText : null,
      label: Text(label),
      labelStyle: TextStyle(
        color: themeColor,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: themeColor,
          width: 2,
        ),
      ),
    );

InputDecoration passwordInputDecoration(String label, bool err, String errText,
        bool isShow, VoidCallback onTap) =>
    InputDecoration(
      suffixIcon: IconButton(
        onPressed: onTap,
        icon: Icon(
          isShow ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          color: const Color(0xff1D1B20),
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      errorText: err ? errText : null,
      label: Text(label),
      labelStyle: TextStyle(
        color: themeColor,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: themeColor,
          width: 2,
        ),
      ),
    );

InputDecoration messInputDecoration(String hint) => InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: themeColor,
          width: 2,
        ),
      ),
    );
