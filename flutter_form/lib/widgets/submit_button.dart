import 'package:flutter_form/consts/colors.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key, required this.title, required this.onPressed});

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              gradient: CustomColors.submitButtonBg,
            ),
            child: TextButton(
              onPressed: onPressed,
              child: Text(title,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            )));
  }
}
