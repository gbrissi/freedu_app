class JwtPayload {
  final int id;
  final String username;
  final DateTime issuedAt;
  final DateTime expiresIn;

  bool get isExpired =>
      DateTime.now().millisecondsSinceEpoch > expiresIn.millisecondsSinceEpoch;

  JwtPayload.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        issuedAt = _setDateTime(json['iat']),
        expiresIn = _setDateTime(json['exp']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['username'] = username;
    json['iat'] = issuedAt;
    json['exp'] = expiresIn;

    return json;
  }
}

DateTime _setDateTime(int seconds) =>
    DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
