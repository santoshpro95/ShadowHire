import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shadowhire/features/contact/contact_screen.dart';
import 'package:shadowhire/features/payment/payment_screen.dart';
import 'package:shadowhire/model/question_response.dart';
import 'package:shadowhire/services/cache_storage/cache_storage_service.dart';
import 'package:shadowhire/services/cache_storage/storage_keys.dart';
import 'package:shadowhire/utils/app_assets.dart';
import 'package:shadowhire/utils/common_methods.dart';

class HomeBloc {
  // region Common Variables
  BuildContext context;
  QuestionResponse questionResponse = QuestionResponse();
  int currentQuestion = 0;

  // endregion

  // region Services
  CacheStorageService cacheStorageService = CacheStorageService();

  // endregion

  // region Controller
  final loadingCtrl = StreamController<bool>.broadcast();
  final languageCtrl = ValueNotifier("English");

  // endregion

  // region | Constructor |
  HomeBloc(this.context);

  // endregion

  // region Init
  void init() async {
    await cacheStorageService.saveBoolean(StorageKeys.isOnboardingFinished, true);
    await loadQuestions();
  }

// endregion

  // region prevQuestion
  void prevQuestion() {
    if (currentQuestion == 0) return;
    currentQuestion--;
    if (!loadingCtrl.isClosed) loadingCtrl.sink.add(false);
  }

  // endregion

  // region nextQuestion
  void nextQuestion() {
    if (currentQuestion == questionResponse.questions!.length - 1) {
      openContact();
      return;
    }
    currentQuestion++;
    if (!loadingCtrl.isClosed) loadingCtrl.sink.add(false);
  }

  // endregion

  // region onSelectAns
  void onSelectAns(Questions questions, String ans) {
    questions.answer = ans;
    nextQuestion();
  }

  // endregion

  // region openContact
  void openContact() {
    var screen = ContactScreen(questionResponse: questionResponse);
    var route = CommonMethods.createRouteRTL(screen);
    Navigator.push(context, route);
  }

  // endregion

  // region languageSelection
  void languageSelection(String language) {
    languageCtrl.value = language;
    loadQuestions();
  }

  // endregion

  // region loadQuestions
  Future<void> loadQuestions() async {
    try {
      var jsonFile = AppAssets.englishQuestion;
      if (languageCtrl.value == "Hindi") jsonFile = AppAssets.hindiQuestion;
      var question = await CommonMethods.getJsonFile(jsonFile);
      questionResponse = QuestionResponse.fromJson(question);
      if (!loadingCtrl.isClosed) loadingCtrl.sink.add(false);
    } catch (exception) {
      print(exception);
    }
  }
// endregion
}
