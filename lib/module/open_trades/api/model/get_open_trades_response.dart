class GetOpenTradesResponse {
  final List<OpenTradesItem>? openTradesItem;

  GetOpenTradesResponse({this.openTradesItem});

  factory GetOpenTradesResponse.fromJson(List<dynamic> json) {
    return GetOpenTradesResponse(
      openTradesItem: json.map((e) => OpenTradesItem.fromJson(e)).toList(),
    );
  }
}


class OpenTradesItem {
  final double? currentPrice;
  final String? comment;
  final int? digits;
  final int? login;
  final double? openPrice;
  final String? openTime;
  final double? profit;
  final double? sl;
  final double? swaps;
  final String? symbol;
  final double? tp;
  final int? ticket;
  final int? type;
  final double? volume;

  OpenTradesItem({
    this.currentPrice,
    this.comment,
    this.digits,
    this.login,
    this.openPrice,
    this.openTime,
    this.profit,
    this.sl,
    this.swaps,
    this.symbol,
    this.tp,
    this.ticket,
    this.type,
    this.volume,
  });

  factory OpenTradesItem.fromJson(Map<String, dynamic> json) {
    return OpenTradesItem(
      currentPrice: (json['currentPrice'] as num?)?.toDouble(),
      comment: json['comment'],
      digits: json['digits'],
      login: json['login'],
      openPrice: (json['openPrice'] as num?)?.toDouble(),
      openTime: json['openTime'],
      profit: (json['profit'] as num?)?.toDouble(),
      sl: (json['sl'] as num?)?.toDouble(),
      swaps: (json['swaps'] as num?)?.toDouble(),
      symbol: json['symbol'],
      tp: (json['tp'] as num?)?.toDouble(),
      ticket: json['ticket'],
      type: json['type'],
      volume: (json['volume'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'currentPrice': currentPrice,
    'comment': comment,
    'digits': digits,
    'login': login,
    'openPrice': openPrice,
    'openTime': openTime,
    'profit': profit,
    'sl': sl,
    'swaps': swaps,
    'symbol': symbol,
    'tp': tp,
    'ticket': ticket,
    'type': type,
    'volume': volume,
  };
}
