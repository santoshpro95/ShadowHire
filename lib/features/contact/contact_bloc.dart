import 'dart:async';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:shadowhire/features/payment/payment_screen.dart';
import 'package:shadowhire/model/question_response.dart';
import 'package:shadowhire/utils/common_methods.dart';

class ContactBloc {
  // region Common Variables
  BuildContext context;
  QuestionResponse questionResponse;
  String selectedCountryCode = "+91";
  String defaultCountryCode = "IN";

  // endregion

  // region Text Controller
  final emailTextCtrl = TextEditingController();
  final phoneNumberTextCtrl = TextEditingController();

  // endregion

  // region Controller
  final validEmailCtrl = StreamController<bool>.broadcast();

  // endregion

  // region | Constructor |
  ContactBloc(this.context, this.questionResponse);

  // endregion

  // region Init
  void init() {}

  // endregion

  // region openPayment
  void openPayment() {
    questionResponse.phoneNo = "$selectedCountryCode${phoneNumberTextCtrl.text}";
    questionResponse.emailId = emailTextCtrl.text;

    var screen = PaymentScreen(questionResponse: questionResponse);
    var route = CommonMethods.createRouteRTL(screen);
    Navigator.push(context, route);
  }

  // endregion

  // region onCountryChange
  void onCountryChange(CountryCode countryCode) async {
    selectedCountryCode = countryCode.dialCode!;
  }

  // endregion

  // region onChangeText
  void onChangeText(String text) {
    final bool isValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(text);
    if (!validEmailCtrl.isClosed) validEmailCtrl.sink.add(isValid);
  }

  // endregion

  // region Dispose
  void dispose() {
    validEmailCtrl.close();
  }
// endregion
}
