import 'package:flutter/material.dart';
import 'package:flutter_form/consts/colors.dart';
import 'package:flutter_form/widgets/custom_input.dart';

Color getBorderColor(InputState state, {bool isFocused = false}) {
  Color color;
  switch (state) {
    case InputState.success:
      color = CustomColors.success;
      break;
    case InputState.error:
      color = CustomColors.error;
      break;
    case InputState.initial:
    default:
      color = isFocused ? CustomColors.borderColor : Colors.white;
  }
  return color;
}

Color getContentColor(InputState state, {bool isIcon = false}) {
  Color color;
  switch (state) {
    case InputState.success:
      color = CustomColors.success;
      break;
    case InputState.error:
      color = CustomColors.error;
      break;
    case InputState.initial:
    default:
      color = isIcon ? CustomColors.greyBlue : CustomColors.primaryText;
  }
  return color;
}
