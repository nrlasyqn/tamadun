
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:provider/provider.dart';
import 'package:tamadun/payment/payment.provider.dart';
import 'package:tamadun/payment/receipt.screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../auth/user.provider.dart';
import '../screens/home_page.dart';
import '../services/stripe.service.dart';


class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _phone = TextEditingController();
  final _email = TextEditingController();

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> checkout(BuildContext context, String phone, cardNumber,
      expiryDate, cardHolderName, cvvCode, email) async {
    try {
      dynamic customer;
      dynamic paymentIntent;
      dynamic paymentMethod;
      var custId = Provider.of<PaymentProvider>(context, listen: false).cid;
      if (Provider.of<PaymentProvider>(context, listen: false).cid == null) {
        customer = await StripeService.createCustomer(
            cardHolderName, '+6$phone', email, cardHolderName);
        setState(() {});
        custId = customer['id'];
        Provider.of<PaymentProvider>(context, listen: false).setCid(custId);
      } else {
        customer = await StripeService.getCustomer(custId);
      }

      paymentMethod = await StripeService.createCardPaymentMethod(
          number: cardNumber,
          expMonth: expiryDate.substring(0, 2),
          expYear: '20${expiryDate.substring(3)}',
          cvc: cvvCode);
      setState(() {});
      var paymentMethodID = paymentMethod['id'];
      var id = Provider.of<PaymentProvider>(context, listen: false).pid;
      if (Provider.of<PaymentProvider>(context, listen: false).pid == null) {
        paymentIntent = await StripeService.createPaymentIntent('5000', 'MYR');

        setState(() {});
        id = paymentIntent!['id'];
        Provider.of<PaymentProvider>(context, listen: false).setPid(id);
      } else {
        setState(() {});
        paymentIntent = await StripeService.getIntent(id!);
      }
      await showDialog(
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Subscribe To Ummah Empire',
              ),
              content: ListTile(
                  title: Text('Name : ' + customer!['name']),
                  subtitle: Text(
                      'Amount : RM ${paymentIntent!['amount'].toString().substring(0, 2)}')),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    dynamic paymentConfirm;
                    setState(() {});
                    paymentConfirm = await StripeService.confirmPayment(
                        paymentIntent!['id'], paymentMethodID);
                    if (paymentConfirm['error'] != null) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              'Payment Fail. ${paymentConfirm['error']['message']}')));
                      Navigator.pop(context);
                    } else {
                      if (paymentConfirm['status'] == 'succeeded') {
                        //updateRole();
                        //saveReceipt();
                        Provider.of<AppUser>(context, listen: false)
                            .updateData(
                            paymentConfirm['charges']['data']
                                .last['receipt_url'],
                            paymentConfirm['status']);
                        Provider.of<AppUser>(context, listen: false)
                            .updateRole(
                            paymentConfirm['charges']['data']
                                .last['receipt_url'],
                            id,
                            custId);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                            Text('Payment ${paymentConfirm['status']}')));
                        Navigator.pop(context);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                              (Route<dynamic> route) => false,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(paymentConfirm['status'])));
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: Text('Confirm Payment'),
                )
              ],
            );
          },
          context: context);
    } catch (e) {
      await showDialog(
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text('Payment Fail. $e'),
            );
          },
          context: context);
    }
  }

  Future saveReceipt() async{
    var id = Provider.of<PaymentProvider>(context, listen: false).pid;
    var receipt = Provider.of<PaymentProvider>(context, listen: false).receipt;
    FirebaseFirestore db = FirebaseFirestore.instance;
    db
        .collection("Users")
        .doc(AppUser.instance.user!.uid)
        .set({
      "receipt-url": receipt,
      "payment-id" : id,
      "payment-date" :DateTime.now(),
    },
        SetOptions(merge: true));
  }

  //todo: update user role after success making payment
  // void updateRole() {
  //   FirebaseFirestore db = FirebaseFirestore.instance;
  //   db
  //       .collection("Users")
  //       .doc(AppUser.instance.user!.uid)
  //       .set({"role": "premium"}, SetOptions(merge: true));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Payment Page",
          style: TextStyle(
            fontFamily: "MontserratBold",
            color: Colors.black,
          ),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
            });
          },

        ),
      ),
      resizeToAvoidBottomInset: true,
      body: Consumer<PaymentProvider>(builder: (context, app, _) {
        return Container(
          decoration: const BoxDecoration(
            border: Border(),
          ),
          child: app.receipt == null
              ? Column(
            children: [
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
                obscureCardNumber: true,
                obscureCardCvv: true,
                onCreditCardWidgetChange: (creditCardBrand) {},
              ),
              Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CreditCardForm(
                          cardNumber: cardNumber,
                          expiryDate: expiryDate,
                          cardHolderName: cardHolderName,
                          cvvCode: cvvCode,
                          onCreditCardModelChange: onCreditCardModelChange,
                          themeColor: Theme.of(context).primaryColor,
                          formKey: formKey,
                          cardNumberDecoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('Number'),
                              hintText: 'xxxx xxxx xxxx xxxx'),
                          expiryDateDecoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('Expired Date'),
                              hintText: 'xx/xx'),
                          cvvCodeDecoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('CVV'),
                              hintText: 'xxx'),
                          cardHolderDecoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Card Holder'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              label: Text('Phone Number'),
                              border: OutlineInputBorder(),
                            ),
                            validator: (e) {
                              if (e!.isEmpty) {
                                return 'Phone number cannot be null';
                              }
                            },
                            controller: _phone,
                            keyboardType:
                            const TextInputType.numberWithOptions(
                                decimal: false),
                          ),
                        ),
                        //EMAIL
                        // Padding(
                        //   padding: const EdgeInsets.all(16.0),
                        //   child: TextFormField(
                        //     decoration: const InputDecoration(
                        //       label: Text('Email'),
                        //       border: OutlineInputBorder(),
                        //     ),
                        //     validator: (e) {
                        //       if (e!.isEmpty) {
                        //         return 'Email cannot be null';
                        //       }
                        //     },
                        //     controller: _email,
                        //     keyboardType:
                        //     const TextInputType.numberWithOptions(
                        //         decimal: false),
                        //   ),
                        // ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              primary: const Color(0xff1b447b)),
                          child: Container(
                            margin: const EdgeInsets.all(8.0),
                            child: const Text(
                              'validate',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'halter',
                                fontSize: 14,
                                package: 'flutter_credit_card',
                              ),
                            ),
                          ),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              ///todo:replace email with user email
                              await checkout(
                                  context,
                                  _phone.text,
                                  cardNumber,
                                  expiryDate,
                                  cardHolderName,
                                  cvvCode,
                                  _email.text);
                              print('valid');
                            } else {
                              print('inValid');
                            }
                          },
                        )
                      ],
                    ),
                  )),
            ],
          )
              : Column(
            children: [
              Flexible(
                child: ListView(
                  children: [
                    ListTile(
                        title: const Text('Payment ID'),
                        subtitle: Text(app.pid)),
                    ListTile(
                        title: const Text('Payment Status'),
                        subtitle: Text(app.status!)),
                    ListTile(
                        title: const Text('Payment Amount'),
                        subtitle: Text(app.price)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.orange),
                          onPressed: () async {
                            if (!kIsWeb) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ReceiptScreen(app.receipt!)));
                            } else {
                              launchUrl(Uri.parse(app.receipt!));
                            }
                          },
                          child: const Text('Get Receipt')),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}