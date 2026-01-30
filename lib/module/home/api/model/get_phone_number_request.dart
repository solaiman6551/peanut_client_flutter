class GetPhoneNumberRequest {
  String login;
  String token;

  GetPhoneNumberRequest({
    required this.login,
    required this.token,
  });

  Map<String, dynamic> toJson() => {
    "login": login,
    "token": token,
  };

}
