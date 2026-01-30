class GetOpenTradesRequest {
  String login;
  String token;

  GetOpenTradesRequest({
    required this.login,
    required this.token,
  });

  Map<String, dynamic> toJson() => {
    "login": login,
    "token": token,
  };

}
