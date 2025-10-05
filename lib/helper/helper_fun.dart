import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hero_location/helper/show_snack_bar.dart';

/// Handles login errors
void loginCheck(FirebaseAuthException e, BuildContext context) {
  switch (e.code) {
    case 'user-not-found':
      showSnackBar(context, 'No user found for that email.');
      log('No user found for that email.');
      break;

    case 'wrong-password':
      showSnackBar(context, 'Wrong password provided for that user.');
      log('Wrong password provided for that user.');
      break;

    case 'invalid-email':
      showSnackBar(context, 'The email address is not valid.');
      log('Invalid email address.');
      break;

    case 'user-disabled':
      showSnackBar(context, 'This account has been disabled.');
      log('User account disabled.');
      break;

    case 'too-many-requests':
      showSnackBar(context, 'Too many login attempts. Please try again later.');
      log('Too many login attempts.');
      break;

    default:
      showSnackBar(context, e.message ?? 'An unknown error occurred.');
      log(e.message ?? 'Unknown FirebaseAuth error');
  }
}

/// Handles sign-up errors
void signUpCheck(FirebaseAuthException e, BuildContext context) {
  switch (e.code) {
    case 'weak-password':
      showSnackBar(context, 'Password provided is too weak.');
      log('The password provided is too weak.');
      break;

    case 'email-already-in-use':
      showSnackBar(context, 'The account already exists for that email.');
      log('The account already exists for that email.');
      break;

    case 'invalid-email':
      showSnackBar(context, 'The email address is not valid.');
      log('Invalid email address.');
      break;

    case 'operation-not-allowed':
      showSnackBar(context, 'Email/password accounts are not enabled.');
      log('Operation not allowed.');
      break;

    default:
      showSnackBar(context, e.message ?? 'An unknown error occurred.');
      log(e.message ?? 'Unknown FirebaseAuth error');
  }
}
