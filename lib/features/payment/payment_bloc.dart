import 'package:flutter/material.dart';
import 'package:shadowhire/features/details/details_screen.dart';
import 'package:shadowhire/model/question_response.dart';
import 'package:shadowhire/services/cache_storage/cache_storage_service.dart';
import 'package:shadowhire/services/cache_storage/storage_keys.dart';
import 'package:shadowhire/utils/common_methods.dart';

class PaymentBloc {
  // region Common Variables
  BuildContext context;
  QuestionResponse questionResponse;

  // endregion

  // region Services
  CacheStorageService cacheStorageService = CacheStorageService();

  // endregion

  // region | Constructor |
  PaymentBloc(this.context, this.questionResponse);

  // endregion

  // region Init
  void init() {}

  // endregion

  // region confirm
  void confirm() async {
    print(questionResponse.toJson());
    await cacheStorageService.save(StorageKeys.investigationDetails, questionResponse);
    openInvestigationDetails();
  }

  // endregion

  // region openInvestigationDetails
  void openInvestigationDetails() {
    var screen = const DetailsScreen();
    var route = CommonMethods.createRouteRTL(screen);
    Navigator.push(context, route);
  }

  // endregion

  // region Dispose
  void dispose() {}
// endregion
}
