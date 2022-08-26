import 'dart:io';

import 'package:blood_doner/services/authentication_service.dart';
import 'package:blood_doner/services/cloud_storage_service.dart';
import 'package:blood_doner/services/firestore_service.dart';
import 'package:blood_doner/services/image_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';

class EditProfileViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();
  final CloudStorageService _cloudStorageService =
      locator<CloudStorageService>();
  final ImageSelector _imageSelector = locator<ImageSelector>();

  TextEditingController usernameController = TextEditingController();
  XFile? pickedImage;

  String get getUserImageUrl {
    return _authenticationService.user!.imageUrl;
  }

  String get getUserName {
    return _authenticationService.user!.userName;
  }

  String get getUserAge {
    return _authenticationService.user!.age;
  }

  void selectImage() async {
    SheetResponse? sheetResponse = await _bottomSheetService.showBottomSheet(
      title: 'upload image from :',
      confirmButtonTitle: 'Gallery',
      cancelButtonTitle: 'Camera',
    );
    if (sheetResponse != null) {
      if (sheetResponse.confirmed) {
        pickedImage = await _imageSelector.pickImagefromGallery();
      } else {
        pickedImage = await _imageSelector.pickImagefromCamera();
      }
    }
    notifyListeners();
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
    if (pickedImage != null) {
      await _cloudStorageService.deleteImage(
          imageFileName: _authenticationService.firebaseUser!.uid);
      await _cloudStorageService.uploadImage(
          imageToUpload: File(pickedImage!.path),
          title: _authenticationService.firebaseUser!.uid);
      imageCache.clear();
      imageCache.clearLiveImages();
    }
    await _authenticationService.populateUser(
        userId: _authenticationService.firebaseUser!.uid);
    setBusy(false);
  }
}
