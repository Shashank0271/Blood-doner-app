import 'dart:io';

import 'package:blood_doner/app/app.logger.dart';
import 'package:blood_doner/app/app.router.dart';
import 'package:blood_doner/services/cloud_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:email_validator/email_validator.dart';

import '../../app/app.locator.dart';
import '../../services/authentication_service.dart';
import '../../services/image_selector.dart';

class SignupViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final ImageSelector _imageSelector = locator<ImageSelector>();
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();
  final CloudStorageService _cloudStorageService =
      locator<CloudStorageService>();

  final Logger _log = getLogger('SignupViewModel');
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
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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

  void createUserUsingEmail() async {
    if (nameController.text.isEmpty ||
        ageController.text.isEmpty ||
        passwordController.text.isEmpty ||
        emailController.text.isEmpty ||
        pickedImage == null) {
      _snackbarService.showSnackbar(message: 'please enter all the fields');
      return;
    } else if (!EmailValidator.validate(emailController.text)) {
      _snackbarService.showSnackbar(message: 'enter a valid email !');
      emailController.clear();
      notifyListeners();
      return;
    }
    setBusy(true);
    try {
      CloudStorageResult cloudStorageResult =
          await _cloudStorageService.uploadImage(
              imageToUpload: File(pickedImage!.path),
              title: emailController.text);

      await _authenticationService.signUpWithEmail(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        age: ageController.text,
        bloodGroup: selectedBloodgroup,
        role: selectedRole,
        imageFileName: cloudStorageResult.imageFileName,
        imageUrl: cloudStorageResult.imageUrl,
      );
      _navigationService.clearStackAndShow(Routes.homeView);
      _snackbarService.showSnackbar(message: 'Log-in successful');
    } catch (e) {
      _log.e(e.toString());
    }
    setBusy(false);
  }
}
