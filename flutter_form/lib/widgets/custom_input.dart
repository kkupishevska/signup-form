import 'package:flutter_form/consts/colors.dart';
import 'package:flutter_form/helpers/input_helpers.dart';
import 'package:flutter/material.dart';

enum FieldType {
  password,
  email,
}

enum InputState {
  initial,
  success,
  error,
}

class TextInputField extends StatefulWidget {
  const TextInputField({
    this.inputState = InputState.initial,
    required this.controller,
    required this.fieldType,
    required this.onChanged,
    required this.hintText,
    super.key
  });

  factory TextInputField.email({
    InputState inputState = InputState.initial,
    required TextEditingController controller,
    required ValueChanged<String> onChanged,
  }) {
    return TextInputField(
      hintText: 'Enter your email',
      fieldType: FieldType.email,
      inputState: inputState,
      controller: controller,
      onChanged: onChanged,
    );
  }

  factory TextInputField.password({
    InputState inputState = InputState.initial,
    required TextEditingController controller,
    required ValueChanged<String> onChanged,
  }) {
    return TextInputField(
      hintText: 'Create your password',
      fieldType: FieldType.password,
      controller: controller,
      inputState: inputState,
      onChanged: onChanged,
    );
  }

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final InputState inputState;
  final FieldType fieldType;
  final String hintText;

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.fieldType == FieldType.password;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: getContentColor(widget.inputState)),
      controller: widget.controller,
      onChanged: widget.onChanged,
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        errorStyle: const TextStyle(color: CustomColors.error, fontSize: 14),
        enabledBorder: outlineInputBorder(widget.inputState, false),
        focusedBorder: outlineInputBorder(widget.inputState, true),
        focusColor: CustomColors.borderColor,
        focusedErrorBorder: errorInputBorder(),
        errorBorder: errorInputBorder(),
        fillColor: Colors.white,
        hintText: widget.hintText,
        filled: true,
        suffixIcon: widget.fieldType == FieldType.password
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                  color: getContentColor(widget.inputState, isIcon: true),
                ),
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
              )
            : null,
        hintStyle: const TextStyle(
          color: CustomColors.primaryText,
        ),
      ),
    );
  }

  OutlineInputBorder outlineInputBorder(InputState inputState, bool isFocused) {
    return OutlineInputBorder(
      borderSide: BorderSide(
          color: getBorderColor(inputState, isFocused: isFocused), width: 1),
      borderRadius: BorderRadius.circular(10.0),
    );
  }

  OutlineInputBorder errorInputBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: CustomColors.error),
      borderRadius: BorderRadius.circular(10.0),
    );
  }
}
