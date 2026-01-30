class GetPhoneNumberResponse {
  final String? phoneNumber;

  GetPhoneNumberResponse({this.phoneNumber});

  factory GetPhoneNumberResponse.fromJson(dynamic json) {
    if (json is String) {
      return GetPhoneNumberResponse(phoneNumber: json);
    }

    return GetPhoneNumberResponse(phoneNumber: null);
  }
}
