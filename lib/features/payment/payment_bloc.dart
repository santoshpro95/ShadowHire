import 'package:flutter/material.dart';
import 'package:shadowhire/model/question_response.dart';
import 'package:shadowhire/services/cache_storage/cache_storage_service.dart';
import 'package:shadowhire/services/cache_storage/storage_keys.dart';

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
  void confirm() async{
    print(questionResponse.toJson());
    await cacheStorageService.save(StorageKeys.investigationDetails, questionResponse);
    openInvestigationDetails();
  }

  // endregion

  // region openInvestigationDetails
  void openInvestigationDetails(){


  }
  // endregion

  // region Dispose
  void dispose() {}
// endregion
}
