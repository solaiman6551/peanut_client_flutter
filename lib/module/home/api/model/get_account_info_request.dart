class GetAccountInfoRequest {
  String login;
  String token;

  GetAccountInfoRequest({
    required this.login,
    required this.token,
  });

  Map<String, dynamic> toJson() => {
    "login": login,
    "token": token,
  };

}
