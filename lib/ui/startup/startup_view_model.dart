import 'package:blood_doner/app/app.router.dart';
import 'package:blood_doner/services/authentication_service.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:blood_doner/app/app.logger.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';

class StartUpViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final Logger _log = getLogger('StartUpViewModel');
  void initialise() {
    _log.v(_authenticationService.isUserSignedIn);
    if (_authenticationService.isUserSignedIn) {
      _navigationService.navigateTo(Routes.homeView);
    } else {
      _navigationService.navigateTo(Routes.loginView);
    }
  }
}
