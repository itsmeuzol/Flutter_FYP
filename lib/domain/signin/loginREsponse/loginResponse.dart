class LoginResponse {
  JWTToken? jwtToken;

  LoginResponse({this.jwtToken});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      jwtToken: JWTToken.fromJson(json["jwt_token"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "jwt_token": jwtToken?.toJson(),
      };
}

class JWTToken {
  String? refresh;
  String? access;

  JWTToken({this.refresh, this.access});

  factory JWTToken.fromJson(Map<String, dynamic> json) {
    return JWTToken(
      refresh: json["refresh"],
      access: json["access"],
    );
  }

  Map<String, dynamic> toJson() => {
        "refresh": refresh,
        "access": access,
      };
}
