import 'package:flutter/material.dart';
import 'package:flutter_paytm_integration/main.dart';

class CheckoutConfirmationPage extends StatefulWidget {
  final PaymentStatus paymentStatus;
  const CheckoutConfirmationPage({Key? key, required this.paymentStatus})
      : super(key: key);

  @override
  State<CheckoutConfirmationPage> createState() =>
      _CheckoutConfirmationPageState();
}

class _CheckoutConfirmationPageState extends State<CheckoutConfirmationPage> {
  late AssetImage successful;
  @override
  void initState() {
    successful = widget.paymentStatus == PaymentStatus.success
        ? const AssetImage("assets/images/success.gif")
        : const AssetImage("");
    super.initState();
  }

  @override
  void dispose() {
    successful.evict();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: successful,
            height: 150.0,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "Successful !!",
              style: TextStyle(
                fontSize: 20.0,
                color: Color(0xFF303030),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(vertical: 24),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFFFF8084),
                textStyle: const TextStyle(
                  color: Color(0xFFFFFFFF),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              // color: kPrimaryColor,
              // highlightColor: ,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
