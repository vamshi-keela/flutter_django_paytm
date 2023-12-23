import 'dart:convert';

TransactionStatusApiModel transactionStatusApiModelFromJson(String str) =>
    TransactionStatusApiModel.fromJson(json.decode(str));

String transactionStatusApiModelToJson(TransactionStatusApiModel data) =>
    json.encode(data.toJson());

class TransactionStatusApiModel {
  TransactionStatusApiModel({
    required this.txnToken,
    required this.amount,
    required this.mid,
    required this.orderId,
  });

  String txnToken;
  String amount;
  String mid;
  String orderId;

  factory TransactionStatusApiModel.fromJson(Map<String, dynamic> json) =>
      TransactionStatusApiModel(
        txnToken: json["txnToken"],
        amount: json["amount"],
        mid: json["mid"],
        orderId: json["orderId"],
      );

  Map<String, dynamic> toJson() => {
        "txnToken": txnToken,
        "amount": amount,
        "mid": mid,
        "orderId": orderId,
      };
}
