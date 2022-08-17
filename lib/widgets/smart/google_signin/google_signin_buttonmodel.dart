import 'package:blood_doner/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import '../../../services/authentication_service.dart';

class GoogleSignInButtonWidgetModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  void googleSignIn() async {
    await _authenticationService.signInWithGoogle();
  }
}
