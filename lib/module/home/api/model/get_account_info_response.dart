class GetAccountInfoResponse {
  final Map<String, dynamic>? extensionData;
  final String? address;
  final double? balance;
  final String? city;
  final String? country;
  final int? currency;
  final int? currentTradesCount;
  final double? currentTradesVolume;
  final double? equity;
  final double? freeMargin;
  final bool? isAnyOpenTrades;
  final bool? isSwapFree;
  final int? leverage;
  final String? name;
  final String? phone;
  final int? totalTradesCount;
  final double? totalTradesVolume;
  final int? type;
  final int? verificationLevel;
  final String? zipCode;

  GetAccountInfoResponse({
    this.extensionData,
    this.address,
    this.balance,
    this.city,
    this.country,
    this.currency,
    this.currentTradesCount,
    this.currentTradesVolume,
    this.equity,
    this.freeMargin,
    this.isAnyOpenTrades,
    this.isSwapFree,
    this.leverage,
    this.name,
    this.phone,
    this.totalTradesCount,
    this.totalTradesVolume,
    this.type,
    this.verificationLevel,
    this.zipCode,
  });

  factory GetAccountInfoResponse.fromJson(Map<String, dynamic> json) => GetAccountInfoResponse(
    extensionData: json["extensionData"] != null
        ? Map<String, dynamic>.from(json["extensionData"])
        : null,
    address: json["address"],
    balance: (json["balance"] as num?)?.toDouble(),
    city: json["city"],
    country: json["country"],
    currency: json["currency"],
    currentTradesCount: json["currentTradesCount"],
    currentTradesVolume:
    (json["currentTradesVolume"] as num?)?.toDouble(),
    equity: (json["equity"] as num?)?.toDouble(),
    freeMargin: (json["freeMargin"] as num?)?.toDouble(),
    isAnyOpenTrades: json["isAnyOpenTrades"],
    isSwapFree: json["isSwapFree"],
    leverage: json["leverage"],
    name: json["name"],
    phone: json["phone"],
    totalTradesCount: json["totalTradesCount"],
    totalTradesVolume:
    (json["totalTradesVolume"] as num?)?.toDouble(),
    type: json["type"],
    verificationLevel: json["verificationLevel"],
    zipCode: json["zipCode"],
  );

  Map<String, dynamic> toJson() => {
    "extensionData": extensionData,
    "address": address,
    "balance": balance,
    "city": city,
    "country": country,
    "currency": currency,
    "currentTradesCount": currentTradesCount,
    "currentTradesVolume": currentTradesVolume,
    "equity": equity,
    "freeMargin": freeMargin,
    "isAnyOpenTrades": isAnyOpenTrades,
    "isSwapFree": isSwapFree,
    "leverage": leverage,
    "name": name,
    "phone": phone,
    "totalTradesCount": totalTradesCount,
    "totalTradesVolume": totalTradesVolume,
    "type": type,
    "verificationLevel": verificationLevel,
    "zipCode": zipCode,
  };
}
