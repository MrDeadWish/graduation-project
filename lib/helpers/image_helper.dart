import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

getImage(ImageSource source) async {
  try {
    final XFile? image = await ImagePicker().pickImage(source: source);
    return image;
  } on PlatformException {
    return null;
  }
}

copyImage(XFile file, String name) async {
  try {
    Directory appDir = await getApplicationDocumentsDirectory();
    final File file0 = File(file.path);
    final File newFile = await file0.copy('${appDir.path}/$name');
    return newFile;
  } catch (e) {
    return null;
  }
}
