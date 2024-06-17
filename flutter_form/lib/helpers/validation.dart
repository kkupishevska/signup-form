String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  }
  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
    return 'Please enter a valid email address';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your password';
  }
  if (value.length < 8 || value.length > 64) {
    return 'Password must be between 8 and 64 characters';
  }
  if (!RegExp(r'^(?=.*[A-Z])(?=.*[0-9])').hasMatch(value)) {
    return 'Password must contain at least one uppercase letter and one number';
  }
  return null;
}
