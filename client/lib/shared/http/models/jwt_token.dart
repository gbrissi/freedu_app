class JwtToken {
  final String accessToken;
  final String refreshToken;

  JwtToken({
    required this.accessToken,
    required this.refreshToken,
  });

  JwtToken.fromJson(Map<String, dynamic> json)
      : accessToken = json['accessToken'],
        refreshToken = json['refreshToken'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['accessToken'] = accessToken;
    json['refreshToken'] = refreshToken;
    return json;
  }
}
