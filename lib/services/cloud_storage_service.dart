import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';

import '../app/app.logger.dart';

class CloudStorageService {
  Logger logger = getLogger('CloudStorageService');

  Future<CloudStorageResult> uploadImage({
    required File imageToUpload,
    required String title,
  }) async {
    String imageFileName = title;
    try {
      TaskSnapshot snapshot = await FirebaseStorage.instance
          .ref()
          .child(imageFileName)
          .putFile(imageToUpload);
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return CloudStorageResult(
        imageUrl: downloadUrl,
        imageFileName: imageFileName,
      );
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  Future deleteImage({required String imageFileName}) async {
    final Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(imageFileName);
    try {
      await firebaseStorageRef.delete();
      return true;
    } catch (e) {
      logger.e(e.toString()); 
      rethrow;
    }
  }
}

class CloudStorageResult {
  final String imageUrl;
  final String imageFileName;

  CloudStorageResult({required this.imageUrl, required this.imageFileName});
}
