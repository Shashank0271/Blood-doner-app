import 'package:blood_doner/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../services/authentication_service.dart';

class GoogleSignInButtonWidgetModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  void googleSignIn() async {
    // await _authenticationService
    //     .signInWithGoogle()
    //     .then((value) => _navigationService.navigateTo(Routes.homeView));
  }
}
