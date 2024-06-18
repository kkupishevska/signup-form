bool validatePassword(String? value) {
  return value != null &&
      value.length >= 8 &&
      value.length <= 64 &&
      !value.contains(' ') &&
      RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])').hasMatch(value);
}

bool validateEmail(String value) {
  if (value.isEmpty) return false;

  return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
}
