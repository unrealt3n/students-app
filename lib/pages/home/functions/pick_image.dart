import 'package:image_picker/image_picker.dart';

Future<XFile?> selectImage() async {
    return await ImagePicker().pickImage(source: ImageSource.gallery);
  }