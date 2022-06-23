import 'package:blood_doner/app/app.locator.dart';
import 'package:blood_doner/app/app.router.dart';
import 'package:blood_doner/services/authentication_service.dart';
import 'package:blood_doner/services/firestore_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';


class HomeViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  TextEditingController nameController = TextEditingController();
  void triggerSignout() {
    //TODO : show conformation dialog
    _authenticationService.signOut();
    _navigationService.clearStackAndShow(Routes.signupView);
  }

  void triggerDialog() {}
}
