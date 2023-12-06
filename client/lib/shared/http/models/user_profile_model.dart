import 'package:client/shared/http/models/picture_model.dart';

class UserProfileModel {
  final int id;
  final String name;
  final String? email;
  final String? description;
  final PictureModel? picture;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['name'] = name;
    json['picture'] = picture;
    json['description'] = description;
    json['email'] = email;

    return json;
  }

  UserProfileModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        description = json['description'],
        email = json['email'],
        name = json['name'],
        picture = json['picture'] != null
            ? PictureModel.fromJson(json['picture'])
            : null;
}
