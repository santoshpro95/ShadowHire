import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:shadowhire/features/details/details_screen.dart';
import 'package:shadowhire/model/question_response.dart';
import 'package:shadowhire/services/cache_storage/cache_storage_service.dart';
import 'package:shadowhire/services/cache_storage/storage_keys.dart';
import 'package:shadowhire/utils/app_constants.dart';
import 'package:shadowhire/utils/app_strings.dart';
import 'package:shadowhire/utils/common_methods.dart';
import 'package:shadowhire/utils/common_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentBloc {
  // region Common Variables
  BuildContext context;
  QuestionResponse questionResponse;
  String username = 'santosh95.educational@gmail.com';
  String password = "adazxscwomgndzsi";

  // endregion

  // region Services
  CacheStorageService cacheStorageService = CacheStorageService();

  // endregion

  // region Controller
  final loadingCtrl = StreamController<bool>.broadcast();

  // endregion

  // region | Constructor |
  PaymentBloc(this.context, this.questionResponse);

  // endregion

  // region Init
  void init() {}

  // endregion

  // region open Payment
  void openPayment() async {
    try {
      var url = "${AppConstants.paymentUrl}${questionResponse.phoneNo}";
      await launchUrl(Uri.parse(url));
    } catch (exception) {
      if (!context.mounted) return;
      CommonWidgets.infoDialog(context, AppStrings.noPhonePay);
      print(exception);
    }
  }

  // endregion

  // region sendMail
  Future<void> sendEmail() async {
    if (!loadingCtrl.isClosed) loadingCtrl.sink.add(true);
    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, username)
      ..recipients.add(username)
      ..subject = 'Shadow Hire'
      ..text = prettyJson(questionResponse.toJson());

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: $sendReport');

      // save details
      await cacheStorageService.save(StorageKeys.investigationDetails, questionResponse);

      //  openInvestigationDetails
      openInvestigationDetails();
    } catch (e) {
      print('Error occurred while sending email: $e');
    } finally {
      if (!loadingCtrl.isClosed) loadingCtrl.sink.add(false);
    }
  }

  // endregion

  // region openInvestigationDetails
  void openInvestigationDetails() {
    var screen = const DetailsScreen();
    var route = CommonMethods.createRouteRTL(screen);
    Navigator.push(context, route);
  }

  // endregion

  // region prettyJson
  String prettyJson(dynamic json) {
    var spaces = ' ' * 4;
    var encoder = JsonEncoder.withIndent(spaces);
    return encoder.convert(json);
  }

  // endregion

  // region Dispose
  void dispose() {}
// endregion
}
