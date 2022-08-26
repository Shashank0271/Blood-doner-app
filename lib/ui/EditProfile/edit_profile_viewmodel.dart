import 'package:blood_doner/services/authentication_service.dart';
import 'package:blood_doner/services/firestore_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../../app/app.locator.dart';

class EditProfileViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
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

  void makeNewUser({String? newuserName, String? newAge}) {
    _firestoreService.updateUser(
        uid: _authenticationService.firebaseUser!.uid,
        userModel: _authenticationService.user!
            .copyWith(userName: newuserName, age: newAge));
  }
}
