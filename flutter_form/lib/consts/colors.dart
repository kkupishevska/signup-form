import 'package:flutter/material.dart';

class CustomColors {
  static const Color primaryText = Color(0xFF4A4E71);
  
  static const Color greyBlue = Color(0xFF6F91BC);
  static const Color borderColor = Color(0xFF6F91BC);

  static const Color error = Color(0xFFFF8080);
  static const Color success = Color(0xFF27B274);

  static const LinearGradient submitButtonBg = LinearGradient(
    colors: [Color(0xFF70C3FF), Color(0xFF4B65FF)],
    end: Alignment.bottomRight,
    begin: Alignment.topLeft,
  );

  static const LinearGradient signinContainerBg = LinearGradient(
    colors: [Color(0xFFF4F9FF), Color(0xFFE0EDFB)],
    end: Alignment.bottomCenter,
    begin: Alignment.topCenter,
  );
}
