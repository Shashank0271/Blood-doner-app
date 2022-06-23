import 'package:image_picker/image_picker.dart';

class ImageSelector {
  Future pickImagefromGallery() async {
    XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    return pickedImage;
  }

  Future pickImagefromCamera() async {
    XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    return pickedImage;
  }
}
