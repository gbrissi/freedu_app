class AuthorModel {
  final int id;
  final String name;
  final String? picture;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['name'] = name;
    json['picture'] = picture;

    return json;
  }

  AuthorModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        picture = json['picture'];
}
