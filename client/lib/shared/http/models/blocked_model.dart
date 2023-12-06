class BlockedModel {
  final int id;
  final DateTime expiresAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['expiresAt'] = expiresAt.toIso8601String();
    json['createdAt'] = createdAt.toIso8601String();
    json['updatedAt'] = updatedAt.toIso8601String();

    return json;
  }

  BlockedModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        expiresAt = DateTime.parse(json['expiresAt']),
        createdAt = DateTime.parse(json['createdAt']),
        updatedAt = DateTime.parse(json['updatedAt']);
}
