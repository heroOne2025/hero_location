import 'package:flutter/material.dart';
import 'package:hero_location/l10n/app_localizations.dart';

class AppValidator {
  static String? validateName(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.pleaseEnterYourName;
    } else if (value.trim().length < 3) {
      return AppLocalizations.of(context)!.nameMustBeAtLeast3Characters;
    } else if (!RegExp(r'^[\p{L}\s]+$', unicode: true).hasMatch(value.trim())) {
      return AppLocalizations.of(context)!.nameCanOnlyContainLetters;
    }
    return null;
  }

  static String? validateEmail(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.pleaseEnterYourEmail;
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return AppLocalizations.of(context)!.enterValidEmail;
    }
    return null;
  }

  static String? validatePassword(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.pleaseEnterYourPassword;
    } else if (value.length < 8) {
      return AppLocalizations.of(context)!.passwordMustBe8Characters;
    } else if (!RegExp(
      r'^(?=.*[A-Z])(?=.*\d)[A-Za-z\d@$!%*?&]+$',
    ).hasMatch(value)) {
      return AppLocalizations.of(context)!.passwordMustContainUppercase;
    }
    return null;
  }

  static String? validateConfirmPassword(
    BuildContext context,
    String? value,
    String originalPassword,
  ) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.pleaseConfirmYourPassword;
    } else if (value != originalPassword) {
      return AppLocalizations.of(context)!.passwordsDoNotMatch;
    }
    return null;
  }

  static String? validatePhone(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.pleaseEnterPhoneNumber;
    } else if (!RegExp(r'^\+?\d{10,15}$').hasMatch(value)) {
      return AppLocalizations.of(context)!.enterValidPhoneNumber;
    }
    return null;
  }

  static String? validateAddress(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.pleaseEnterAddress;
    } else if (value.trim().length < 5) {
      return AppLocalizations.of(context)!.addressMustBe5Characters;
    } else if (!RegExp(
      r'^[\p{L}0-9\s,.\-\/]+$',
      unicode: true,
    ).hasMatch(value.trim())) {
      return AppLocalizations.of(context)!.addressContainsInvalidCharacters;
    }
    return null;
  }
}
