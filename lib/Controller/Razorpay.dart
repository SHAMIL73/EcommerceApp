import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;

class razorpay {
  Razorpay _razorpay = Razorpay();
  bool paymentSuccessful = false;
  Razorpay getRazorpay() {
    return _razorpay;
  }

  handles(context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
          (response) => _handlePaymentsSuccess(context, response));
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
          (response) => _handlePaymentError(context, response));
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
          (response) => _handleExternalWallet(context, response));
    });
  }

  _handlePaymentsSuccess(context, PaymentSuccessResponse response) {
    // Do something when payment succeeds

    print(response);
    verifySignature(
      context: context,
      signature: response.signature,
      paymentId: response.paymentId,
      orderId: response.orderId,
    );
  }

  void _handlePaymentError(context, PaymentFailureResponse response) {
    print(response);
    // Do something when payment fails
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      SnackBar(
        content: Text(response.message ?? ''),
      ),
    );
  }

  void _handleExternalWallet(context, ExternalWalletResponse response) {
    print(response);
    // Do something when an external wallet is selected
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      SnackBar(
        content: Text(response.walletName ?? ''),
      ),
    );
  }

// create order
  void createOrder(context, price) async {

    String username = "rzp_test_aoB6mzESMgzVTu";
    String password = "VoI8LrKtrg5JZZKC4Prjb9tG";
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    Map<String, dynamic> body = {
      "amount": price * 100,
      "currency": "INR",
      "receipt": "rcptid_11"
    };
    var res = await http.post(
      Uri.https(
          "api.razorpay.com", "v1/orders"), //https://api.razorpay.com/v1/orders
      headers: <String, String>{
        "Content-Type": "application/json",
        'authorization': basicAuth,
      },
      body: jsonEncode(body),
    );

    if (res.statusCode == 200) {
      openGateway(context, jsonDecode(res.body)['id']);
    }
    print(res.body);
    // Provider.of<APIprovider>(context, listen: false).loading();
  }

  openGateway(context, String orderId) {
    var options = {
      'key': 'rzp_test_aoB6mzESMgzVTu',
      'amount': 100, //in the smallest currency sub-unit.
      'name': 'Acme Corp.',
      'order_id': orderId, // Generate order_id using Orders API
      'description': 'Fine T-Shirt',
      'timeout': 60 * 5, // in seconds // 5 minutes
      'prefill': {
        'contact': '9207606286',
        'email': 'swafvanma@gmail.com',
      }
    };
    _razorpay.open(options);
  }

  verifySignature({
    context,
    String? signature,
    String? paymentId,
    String? orderId,
  }) async {
    Map<String, dynamic> body = {
      'razorpay_signature': signature,
      'razorpay_payment_id': paymentId,
      'razorpay_order_id': orderId,
    };

    var parts = [];
    body.forEach((key, value) {
      parts.add('${Uri.encodeQueryComponent(key)}='
          '${Uri.encodeQueryComponent(value)}');
    });
    // var formData = parts.join('&');

    // var res = await http.post(
    //   Uri.https(
    //     "10.0.2.2", // my ip address , localhost
    //     "razorpay_signature_verify.php",
    //   ),
    //   headers: {
    //     "Content-Type": "application/x-www-form-urlencoded", // urlencoded
    //   },
    //   body: formData,
    // );

    // print(res.body);
    // if (res.statusCode == 200) {
    //   ScaffoldMessenger.of(context as BuildContext).showSnackBar(
    //     SnackBar(
    //       content: Text(res.body),
    //     ),
    //   );
    // }
  }
}