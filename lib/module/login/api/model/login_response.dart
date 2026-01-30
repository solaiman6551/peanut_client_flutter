class LoginResponse {
  final bool? result;
  final String? token;
  final Map<String, dynamic>? extensionData;

  LoginResponse({
    this.result,
    this.token,
    this.extensionData,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    result: json["result"],
    token: json["token"],
    extensionData: json["extensionData"] != null
        ? Map<String, dynamic>.from(json["extensionData"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "token": token,
    "extensionData": extensionData,
  };
}
