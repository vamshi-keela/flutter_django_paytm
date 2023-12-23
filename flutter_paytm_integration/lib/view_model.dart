import 'package:flutter/material.dart';
import 'package:flutter_paytm_integration/transaction_status_api_model.dart';
import 'package:http/http.dart' as http;

class ViewModel extends ChangeNotifier {
  String? txnToken;
  String? amount;
  String? mid;
  String? orderId;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  getTxnToken(String amount, String serverUrl) async {
    try {
      _isLoading = true;
      notifyListeners();
      var url = Uri.parse(serverUrl);
      var response = await http.post(url, body: {'amount': amount});
      if (response.statusCode == 200) {
        var data = transactionStatusApiModelFromJson(response.body);
        txnToken = data.txnToken;
        this.amount = data.amount;
        mid = data.mid;
        orderId = data.orderId;
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }
}
