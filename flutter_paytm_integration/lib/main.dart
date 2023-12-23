import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paytm_integration/checkout_page.dart';
import 'package:flutter_paytm_integration/view_model.dart';
import 'package:provider/provider.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paytm Integration with flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ViewModel _viewModel;

  @override
  void initState() {
    _viewModel = ViewModel();
    super.initState();
  }

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _viewModel,
      child: Consumer<ViewModel>(
        builder: (context, model, child) {
          return Scaffold(
            body: model.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            label: Text("Enter amount"),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        OutlinedButton(
                            onPressed: () async {
                              await model.getTxnToken(_controller.text,
                                  "https://3c-2402-e280-2149-699-90f-434d-22ec-a98a.ngrok-free.app/startPayment/"); //localhost url
                              await invokeAllInOneSdk();
                            },
                            child: const Text("Submit"))
                      ],
                    )),
          );
        },
      ),
    );
  }

  invokeAllInOneSdk() async {
    var result;
    String mid = _viewModel.mid!;
    String orderId = _viewModel.orderId!;
    String amount = _viewModel.amount!;
    String txnToken = _viewModel.txnToken!;
    try {
      await AllInOneSdk.startTransaction(
              mid,
              orderId,
              amount,
              txnToken,
              "https://securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID=$orderId",
              true,
              true)
          .then((value) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const CheckoutConfirmationPage(
            paymentStatus: PaymentStatus.success,
          );
        }));
      }).catchError((onError) {
        if (onError is PlatformException) {
          setState(() {
            result = onError.message ?? " \n  ${onError.details}";
          });
        } else {
          setState(() {
            result = onError.toString();
          });
        }
      });
    } catch (err) {
      result = err;
    }
  }
}

enum PaymentStatus { success, failed }
