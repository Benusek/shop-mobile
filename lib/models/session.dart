class Session {
  final String accessToken;
  final String tokenType;
  Session({required this.accessToken, required this.tokenType});

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      accessToken: json['accessToken'],
      tokenType: json['tokenType']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'tokenType': tokenType
    };
  }
}