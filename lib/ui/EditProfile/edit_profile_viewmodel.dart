import 'package:blood_doner/services/authentication_service.dart';
import 'package:blood_doner/services/firestore_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';

class EditProfileViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  TextEditingController usernameController = TextEditingController();
  String get getUserImageUrl {
    return _authenticationService.user!.imageUrl;
  }

  String get getUserName {
    return _authenticationService.user!.userName;
  }

  String get getUserAge {
    return _authenticationService.user!.age;
  }

  Future<void> updateUserProfile({String? newuserName, String? newAge}) async {
    if ((newAge != null && int.parse(newAge) <= 0) ||
        (newuserName != null && newuserName.isEmpty)) {
      _snackbarService.showSnackbar(message: 'Please enter valid details');
      return;
    }
    setBusy(true);
    await _firestoreService.updateUser(
        uid: _authenticationService.firebaseUser!.uid,
        userModel: _authenticationService.user!
            .copyWith(userName: newuserName, age: newAge));
    await _authenticationService.populateUser(
        userId: _authenticationService.firebaseUser!.uid);
    setBusy(false);
  }
}
