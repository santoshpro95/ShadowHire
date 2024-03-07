import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shadowhire/features/home/home_screen.dart';
import 'package:shadowhire/model/question_response.dart';
import 'package:shadowhire/services/cache_storage/cache_storage_service.dart';
import 'package:shadowhire/services/cache_storage/storage_keys.dart';
import 'package:shadowhire/utils/app_strings.dart';
import 'package:shadowhire/utils/common_methods.dart';
import 'package:shadowhire/utils/common_widgets.dart';

class DetailsBloc {
  // region Common Variables
  BuildContext context;
  int status = 0;
  QuestionResponse questionResponse = QuestionResponse();

  // endregion

  // region Services
  CacheStorageService cacheStorageService = CacheStorageService();

  // endregion

  // region Controller
  final loadingCtrl = StreamController<bool>.broadcast();

  // endregion

  // region | Constructor |
  DetailsBloc(this.context);

  // endregion

  // region Init
  void init() {
    getDetails();
  }

  // endregion

  // region getDetails
  void getDetails() async {
    try {
      var response = await cacheStorageService.get(StorageKeys.investigationDetails);
      questionResponse = QuestionResponse.fromJson(response);
      if (!loadingCtrl.isClosed) loadingCtrl.sink.add(false);
    } catch (exception) {
      print(exception);
    }
  }

  // endregion

  // region closeInvestigation
  void closeInvestigation() {
    CommonWidgets.confirmationBox(context, AppStrings.closeInvestigation, AppStrings.closeInvestigationMsg, close, () => Navigator.pop(context));
  }

  // endregion

  // region close
  Future<void> close() async {
    await cacheStorageService.removeItem(StorageKeys.investigationDetails);
    openHomeScreen();
  }

  // endregion

  // region openHome
  void openHomeScreen() {
    var screen = const HomeScreen();
    var route = CommonMethods.createRouteRTL(screen);
    Navigator.push(context, route);
  }

  // endregion

  // region Dispose
  void dispose() {}
// endregion
}
