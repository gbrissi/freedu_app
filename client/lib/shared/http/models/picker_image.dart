import 'dart:typed_data';

import 'package:client/shared/http/models/picture_model.dart';
import 'package:file_picker/file_picker.dart';

class ImageData {
  final String? url;
  final Uint8List? bytes;

  ImageData.fromBytes(Uint8List value)
      : bytes = value,
        url = null;
  ImageData.fromNetwork(String value)
      : url = value,
        bytes = null;
}

class PickerImage {
  final String name;
  final String fileType;
  final ImageData data;

  PickerImage({
    required this.name,
    required this.fileType,
    required this.data,
  });

  PickerImage.fromPlatformFile(PlatformFile file)
      : name = file.name,
        fileType = "image",
        data = ImageData.fromBytes(file.bytes!);

  PickerImage.fromPictureModel(PictureModel picture)
      : data = ImageData.fromNetwork(picture.original),
        fileType = picture.fileType,
        name = picture.name;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['name'] = name;
    json['fileType'] = fileType;
    json['data'] = data;

    return json;
  }
}
