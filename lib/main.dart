// Copyright 2024 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pay/pay.dart';
import 'package:payment_method/payment_configurations.dart';
import 'payment_configurations.dart' as payment_configurations;
import 'dart:io' show Platform;

void main() {
  runApp(const PayMaterialApp());
}

const _paymentItems = [
  PaymentItem(
    label: 'Total',
    amount: '99.99',
    status: PaymentItemStatus.final_price,
  )
];

class PayMaterialApp extends StatelessWidget {
  const PayMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Pay for Flutter Demo',
      localizationsDelegates: [
        ...GlobalMaterialLocalizations.delegates,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''),
        Locale('es', ''),
        Locale('de', ''),
      ],
      home: PaySampleApp(),
    );
  }
}

class PaySampleApp extends StatefulWidget {
  const PaySampleApp({super.key});

  @override
  State<PaySampleApp> createState() => _PaySampleAppState();
}

class _PaySampleAppState extends State<PaySampleApp> {
  GooglePayButton? googlePayButton;
  ApplePayButton? applePayButton;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    applePayButton = ApplePayButton(
      paymentConfiguration:
          PaymentConfiguration.fromJsonString(defaultApplePay),
      paymentItems: const [
        PaymentItem(
            amount: "0.1",
            label: "Item1",
            status: PaymentItemStatus.final_price),
      ],
      style: ApplePayButtonStyle.black,
      width: double.infinity,
      type: ApplePayButtonType.buy,
      margin: const EdgeInsets.all(15.0),
      onPaymentResult: onApplePayResult,
      loadingIndicator: const Center(
        child: CircularProgressIndicator(),
      ),
    );
    googlePayButton = GooglePayButton(
      paymentConfiguration:
          PaymentConfiguration.fromJsonString(defaultGooglePay),
      paymentItems: const [
        PaymentItem(
            amount: "0.1", //add aamount
            label: "Item1", //item Name
            status: PaymentItemStatus.final_price),
      ],
      width: double.infinity,
      type: GooglePayButtonType.pay,
      margin: const EdgeInsets.all(15.0),
      onPaymentResult: onGooglePayResult,
      loadingIndicator: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('T-shirt Shop'),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Platform.isIOS ? applePayButton : googlePayButton,
          ),
        ));
  }

  void onApplePayResult(paymentResult) {}

  void onGooglePayResult(paymentResult) {
    if (kDebugMode) {
      print("myResult $paymentResult");
    }
  }
}
