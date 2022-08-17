import 'dart:io';

import 'package:blood_doner/app/app.logger.dart';
import 'package:blood_doner/services/cloud_storage_service.dart';
import 'package:blood_doner/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../models/UserModel.dart';
import '../../services/authentication_service.dart';
import '../../services/image_selector.dart';

class CompleteProfileViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final ImageSelector _imageSelector = locator<ImageSelector>();
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();
  final CloudStorageService _cloudStorageService =
      locator<CloudStorageService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();

  final Logger _log = getLogger('CompleteProfileViewModel');
  final bgList = [
    const DropdownMenuItem(
      value: "A+",
      child: Center(child: Text('A+')),
    ),
    const DropdownMenuItem(
      value: "A-",
      child: Center(child: Text('A-')),
    ),
    const DropdownMenuItem(
      value: "B+",
      child: Center(child: Text('B+')),
    ),
    const DropdownMenuItem(
      value: "B-",
      child: Center(child: Text('B-')),
    ),
    const DropdownMenuItem(
      value: "AB+",
      child: Center(child: Text('AB+')),
    ),
    const DropdownMenuItem(
      value: "AB-",
      child: Center(child: Text('AB-')),
    ),
    const DropdownMenuItem(
      value: "O+",
      child: Center(child: Text('O+')),
    ),
    const DropdownMenuItem(
      value: "O-",
      child: Center(child: Text('O-')),
    ),
  ];
  final roleList = [
    const DropdownMenuItem(
      value: "Doner",
      child: Center(
        child: Text('Doner'),
      ),
    ),
    const DropdownMenuItem(
      value: 'Patient',
      child: Center(
        child: Text('Patient'),
      ),
    ),
  ];
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  String selectedRole = "Doner";
  String selectedBloodgroup = "A+";
  XFile? pickedImage;

  void onChangedBloodgroup(String? newBloodgroup) {
    selectedBloodgroup = newBloodgroup ?? selectedBloodgroup;
    notifyListeners();
  }

  void onChangedPurpose(String? newRole) {
    selectedRole = newRole ?? selectedRole;
    notifyListeners();
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

  void createUserinDb() async {
    if (nameController.text.isEmpty ||
        ageController.text.isEmpty ||
        pickedImage == null) {
      _snackbarService.showSnackbar(message: 'please enter all the fields');
      return;
    }
    setBusy(true);
    try {
      CloudStorageResult cloudStorageResult =
          await _cloudStorageService.uploadImage(
              imageToUpload: File(pickedImage!.path),
              title: _authenticationService.firebaseUser!.uid);

      final user = UserModel(
          userName: nameController.text.trim(),
          email: _authenticationService.firebaseUser!.email!,
          bloodGroup: selectedBloodgroup,
          age: ageController.text.trim(),
          role: selectedRole,
          imageUrl: cloudStorageResult.imageUrl,
          imageFileName: cloudStorageResult.imageFileName);

      await _firestoreService.createNewUserEntry(
          uid: _authenticationService.firebaseUser!.uid, user: user);
      await _authenticationService.populateUser(
          userId: _authenticationService.firebaseUser!.uid);
      _snackbarService.showSnackbar(message: 'Log-in successful');
    } catch (e) {
      _snackbarService.showSnackbar(message: 'Some error occurred');
      _log.e(e.toString());
    }
    setBusy(false);
  }
}
