class PictureModel {
  final int id;
  final String name;
  final String fileType;
  final String? small;
  final String? thumbnail;
  final String original;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['name'] = name;
    json['small'] = small;
    json['thumbnail'] = thumbnail;
    json['original'] = original;
    json['fileType'] = fileType;
    json['createdAt'] = createdAt.toIso8601String();
    json['updatedAt'] = updatedAt.toIso8601String();

    return json;
  }

  PictureModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        fileType = json['fileType'],
        original = json['original'],
        small = json['small'],
        thumbnail = json['thumbnail'],
        createdAt = DateTime.parse(json['createdAt']),
        updatedAt = DateTime.parse(json['updatedAt']);
}
