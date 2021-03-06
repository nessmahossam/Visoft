import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:viisoft/constants.dart';
import 'package:viisoft/screens/project_status.dart';
import 'package:viisoft/widgets/projectInfo.dart';

class PaymentScreen extends StatefulWidget {
  static String namedRoute = '/paymentScreen';
  String devId, projName, price, deveName, desc, projImg;

  PaymentScreen(
      {this.devId,
      this.projName,
      this.price,
      this.deveName,
      this.desc,
      this.projImg});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Credit Card Details',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          backgroundColor: Color(0xfffcfcfe),
          primaryColorLight: Color(0xff84b4c1),
          accentColor: Color(0xff84b4c1),
          primaryColor: Color(0xff2f9f9f),
          tabBarTheme: TabBarTheme(labelColor: Color(0xff2f9f9f))),
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text('Verify Payment'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
                obscureCardNumber: true,
                obscureCardCvv: true,
                cardBgColor: Color(0xff2f9f9f),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CreditCardForm(
                        formKey: formKey,
                        obscureCvv: true,
                        obscureNumber: true,
                        themeColor: Color(0xff2f9f9f),
                        cardNumberDecoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                            borderSide: BorderSide(color: Color(0xff2f9f9f)),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          )),
                          labelText: 'Card Number',
                          hintText: 'XXXX XXXX XXXX XXXX',
                        ),
                        expiryDateDecoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                              borderSide: BorderSide(color: Color(0xff2f9f9f))),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          )),
                          labelText: 'Expired Date',
                          hintText: 'XX/XX',
                        ),
                        cvvCodeDecoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                              borderSide: BorderSide(color: Color(0xff2f9f9f))),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          )),
                          labelText: 'CVV',
                          hintText: 'XXX',
                        ),
                        cardHolderDecoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                            borderSide: BorderSide(color: Color(0xff2f9f9f)),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                              borderSide: BorderSide(color: Color(0xff2f9f9f))),
                          labelText: 'Card Holder',
                        ),
                        onCreditCardModelChange: onCreditCardModelChange,
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                          width: 200.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                              color: Color(0xff2f9f9f),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 15.0,
                                    offset: Offset(0.0, 5.0)),
                              ],
                              borderRadius: BorderRadius.circular(30.0)),
                          child: FlatButton(
                            child: Text(
                              "Save",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 15.0,
                              ),
                            ),
                            onPressed: () {
                              // if (formKey.currentState.validate()) {
                              //   print('valid!');
                              // } else {
                              //   print('invalid!');
                              // }

                              FirebaseFirestore.instance
                                  .collection("Users")
                                  .doc(FirebaseAuth.instance.currentUser.uid)
                                  .collection("Payment")
                                  .doc(cardNumber)
                                  .set({
                                'cardHolder': cardHolderName,
                                'credit number': cardNumber,
                                'cvv': cvvCode,
                                'earned': '0',
                                'expDate': expiryDate,
                                'spent': '0'
                              });

                              //To save at client's collection
                              // FirebaseFirestore.instance
                              //     .collection("Users")
                              //     .doc(FirebaseAuth.instance.currentUser.uid)
                              //     .collection("OngoingProjects")
                              //     .doc(widget.projName)
                              //     .set({
                              //   'clientId':
                              //       FirebaseAuth.instance.currentUser.uid,
                              //   'devName': widget.deveName,
                              //   'projName': widget.projName,
                              //   'price': widget.price,
                              //   'desc': widget.desc,
                              //   'projImg': widget.projImg
                              // });

                              // //To save at developer's collections
                              // FirebaseFirestore.instance
                              //     .collection("Users")
                              //     .doc(widget.devId)
                              //     .collection("OngoingProjects")
                              //     .doc(widget.projName)
                              //     .set({
                              //   'clientId':
                              //       FirebaseAuth.instance.currentUser.uid,
                              //   'devName': widget.deveName,
                              //   'projName': widget.projName,
                              //   'price': widget.price,
                              //   'desc': widget.desc,
                              //   'projImg': widget.projImg
                              // });

                              Navigator.pop(context);
                            },
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
