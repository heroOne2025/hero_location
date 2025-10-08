class AppValidator {
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your name';
    } else if (value.trim().length < 3) {
      return 'Name must be at least 3 characters long';
    } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return 'Name can only contain letters';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters';
    } else if (!RegExp(
      r'^(?=.*[A-Z])(?=.*\d)[A-Za-z\d@$!%*?&]+$',
    ).hasMatch(value)) {
      return 'Password must contain at least\n one uppercase letter and one number';
    }
    return null;
  }

  static String? validateConfirmPassword(
    String? value,
    String originalPassword,
  ) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    } else if (value != originalPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    } else if (!RegExp(r'^\+?\d{10,15}$').hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  static String? validateAddress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter the address';
    } else if (value.trim().length < 5) {
      return 'Address must be at least 5 characters long';
    } else if (!RegExp(
      r'^[\p{L}0-9\s,.\-\/]+$',
      unicode: true,
    ).hasMatch(value.trim())) {
      return 'Address contains invalid characters';
    }
    return null;
  }
}
