class LoginRequest {
  String loginId;
  String password;

  LoginRequest({
    required this.loginId,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    "login": loginId,
    "password": password,
  };

}
