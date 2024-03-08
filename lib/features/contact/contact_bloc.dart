import 'dart:async';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shadowhire/features/details/details_screen.dart';
import 'package:shadowhire/features/payment/payment_screen.dart';
import 'package:shadowhire/model/question_response.dart';
import 'package:shadowhire/services/cache_storage/cache_storage_service.dart';
import 'package:shadowhire/utils/app_constants.dart';
import 'package:shadowhire/utils/app_strings.dart';
import 'package:shadowhire/utils/common_methods.dart';
import 'package:shadowhire/utils/common_widgets.dart';

import '../../services/cache_storage/storage_keys.dart';

class ContactBloc {
  // region Common Variables
  BuildContext context;
  QuestionResponse questionResponse;
  String selectedCountryCode = "+91";
  String defaultCountryCode = "IN";

  // endregion

  // region Text Controller
  final fullNameCtrl = TextEditingController();
  final emailTextCtrl = TextEditingController();
  final phoneNumberTextCtrl = TextEditingController();

  // endregion

  // region Controller
  final validEmailCtrl = StreamController<bool>.broadcast();
  final loadingCtrl = StreamController<bool>.broadcast();

  // endregion

  // region | Constructor |
  ContactBloc(this.context, this.questionResponse);

  // endregion

  // region Init
  void init() {}

  // endregion

  // region next
  void next() {
    // validation
    if (fullNameCtrl.text.isEmpty || phoneNumberTextCtrl.text.isEmpty || emailTextCtrl.text.isEmpty) {
      return;
    }

    // get data
    questionResponse.name = fullNameCtrl.text;
    questionResponse.phoneNo = "$selectedCountryCode${phoneNumberTextCtrl.text}";
    questionResponse.emailId = emailTextCtrl.text;

    // open Payment
    openPayment();
  }

  // endregion

  // region openInvestigationDetails
  void openPayment() {
    var screen = PaymentScreen(questionResponse: questionResponse);
    var route = CommonMethods.createRouteRTL(screen);
    Navigator.push(context, route);
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
    loadingCtrl.close();
  }
// endregion
}
