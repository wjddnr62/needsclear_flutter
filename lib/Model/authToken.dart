class AuthToken {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final String scope;
  final String jti;

  AuthToken(
      {this.accessToken, this.tokenType, this.expiresIn, this.scope, this.jti});

  factory AuthToken.fromJson(Map<dynamic, dynamic> data) {
    return AuthToken(
        accessToken: data['access_token'],
        tokenType: data['token_type'],
        expiresIn: data['expires_in'],
        scope: data['scope'],
        jti: data['jti']);
  }
}
