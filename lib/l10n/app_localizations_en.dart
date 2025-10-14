// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get name => 'Name';

  @override
  String get pleaseEnterYourName => 'Please enter your name';

  @override
  String get nameMustBeAtLeast3Characters =>
      'Name must be at least 3 characters long';

  @override
  String get nameCanOnlyContainLetters =>
      'Name can only contain letters and spaces';

  @override
  String get pleaseEnterYourEmail => 'Please enter your email';

  @override
  String get enterValidEmail => 'Enter a valid email';

  @override
  String get pleaseEnterYourPassword => 'Please enter your password';

  @override
  String get passwordMustBe8Characters =>
      'Password must be at least 8 characters';

  @override
  String get passwordMustContainUppercase =>
      'Password must contain\nat least one uppercase letter and one number';

  @override
  String get pleaseConfirmYourPassword => 'Please confirm your password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get pleaseEnterPhoneNumber => 'Please enter your phone number';

  @override
  String get enterValidPhoneNumber => 'Enter a valid phone number';

  @override
  String get pleaseEnterAddress => 'Please enter the address';

  @override
  String get addressMustBe5Characters =>
      'Address must be at least 5 characters long';

  @override
  String get addressContainsInvalidCharacters =>
      'Address contains invalid characters';

  @override
  String get addClientLocation => 'Add Client Location';

  @override
  String get customers => 'Customers';

  @override
  String get english => 'English';

  @override
  String get appLanguage => 'App Language';

  @override
  String get chooseYourLanguage => 'Choose your language';

  @override
  String get arabic => 'Arabic';

  @override
  String get noUserSignedIn => 'No user is signed in';

  @override
  String get passwordChangedSuccessfully => 'Password changed successfully';

  @override
  String get errorChangingPassword => 'Error changing password';

  @override
  String get oldPasswordIncorrect => 'Old password is incorrect';

  @override
  String get newPasswordTooWeak => 'New password is too weak';

  @override
  String get changePassword => 'Change Password';

  @override
  String get oldPassword => 'Old Password';

  @override
  String get newPassword => 'New Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get clientNotFound => 'Client not found';

  @override
  String get errorLoadingClient => 'Error loading client data';

  @override
  String get locationServicesDisabled => 'Location services are disabled';

  @override
  String get locationPermissionDenied => 'Location permission denied';

  @override
  String get locationPermissionPermanentlyDenied =>
      'Location permission permanently denied';

  @override
  String get noLocationAvailable => 'No location available';

  @override
  String get couldNotOpenGoogleMaps => 'Could not open Google Maps';

  @override
  String get clientDetails => 'Client Details';

  @override
  String get updateLocation => 'Update Location';

  @override
  String get save => 'Save';

  @override
  String get password => 'Password';

  @override
  String get viewOnlyAdmins =>
      'View only mode: Only admins can edit client details.';

  @override
  String get viewOnlyAdminsOr12Hours =>
      'View only mode: Only admins or within 12 hours of creation can edit.';

  @override
  String get userNotFound => 'User not found';

  @override
  String get errorLoadingUserData => 'Error loading user data';

  @override
  String get profileUpdatedSuccessfully => 'Profile updated successfully';

  @override
  String get errorUpdatingProfile => 'Error updating profile';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get welcome => 'Welcome';

  @override
  String get email => 'Email';

  @override
  String get phoneNumber => 'Phone';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get forgetYourPassword => 'Forget Your Password?';

  @override
  String get send => 'Send';

  @override
  String get passwordResetEmailSent => 'Password reset email sent.';

  @override
  String get noUserFoundForThatEmail => 'No user found for that email.';

  @override
  String get home => 'Home';

  @override
  String get settings => 'Settings';

  @override
  String get login => 'Login';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get signUp => 'Sign Up';

  @override
  String get createAccount => 'Create an account';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get somethingWentWrong => 'Something went wrong';

  @override
  String get logout => 'Logout';

  @override
  String get areYouSureLogout => 'Are you sure you want to logout?';

  @override
  String get cancel => 'Cancel';

  @override
  String get yes => 'Yes';

  @override
  String get getCurrentLocation => 'Get Current Location';

  @override
  String get clientAddedSuccessfully => 'Client added successfully';

  @override
  String get errorOccured => 'An error occurred';

  @override
  String get searchAgents => 'Search agents by name or phone...';

  @override
  String get searchClients => 'Search clients by name or phone...';

  @override
  String get noClientsYet => 'No clients yet';

  @override
  String get loginSuccessful => 'Login successful';

  @override
  String get wrongPassword => 'Wrong password provided.';

  @override
  String get invalidEmailFormat => 'Invalid email format.';

  @override
  String get userDisabled => 'This user account has been disabled.';

  @override
  String get unexpectedError => 'Unexpected error occurred';

  @override
  String get signUpSuccessful => 'Sign-up successful';

  @override
  String get weakPassword => 'The password provided is too weak.';

  @override
  String get emailAlreadyInUse => 'An account already exists for that email.';

  @override
  String get enterYourName => 'Enter your Name';

  @override
  String get enterYourEmail => 'Enter your Email';

  @override
  String get enterPhoneNumber => 'Enter phone number';

  @override
  String get enterYourPassword => 'Enter your password';

  @override
  String get forgetPassword => 'Forget Password?';

  @override
  String get anErrorOccurred => 'An error occurred';

  @override
  String get invalidCredential => 'Invalid email or password.';

  @override
  String get unknownError => 'An unexpected error occurred. Please try again.';

  @override
  String get clientDeletedSuccessfully => 'Client deleted successfully';

  @override
  String get undo => 'Undo';

  @override
  String get clientRestored => 'Client restored';

  @override
  String get errorRestoringClient => 'Error restoring client';

  @override
  String get errorDeletingClient => 'Error deleting client';

  @override
  String get clientUpdatedSuccessfully => 'Client updated successfully';

  @override
  String get pleaseGetCurrentLocationFirst =>
      'Please get current location first';

  @override
  String get clientName => 'Client Name';

  @override
  String get clientPhone => 'Client Phone';

  @override
  String get clientAddress => 'Client Address';

  @override
  String get address => 'Address';

  @override
  String get addClient => 'Add Client';

  @override
  String get noPermissionToEdit => 'You do not have permission to edit';
}
