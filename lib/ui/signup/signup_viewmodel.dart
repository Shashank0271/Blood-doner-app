import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:blood_doner/services/authentication_service.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.locator.dart';

class SignupViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Future<void> createAccount() async {
    if (!EmailValidator.validate(emailController.text)) {
      _snackbarService.showSnackbar(message: 'enter a valid email !');
      emailController.clear();
      passwordController.clear();
      notifyListeners();
    } else {
      setBusy(true);
      await _authenticationService.signUpWithEmail(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      setBusy(false);
    }
  }
}
