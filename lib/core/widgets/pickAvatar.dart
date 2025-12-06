import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

Future<String?> pickAvatar(String source) async {
  final picker = ImagePicker();
  XFile? file;

  if (source == "camera") {
    file = await picker.pickImage(source: ImageSource.camera, imageQuality: 60);
  } else {
    file = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 60,
    );
  }

  if (file == null) return null;

  final dir = await getApplicationDocumentsDirectory();
  final saved = File(
    "${dir.path}/avatar_${DateTime.now().millisecondsSinceEpoch}.jpg",
  );

  await saved.writeAsBytes(await file.readAsBytes());

  return saved.path;
}
