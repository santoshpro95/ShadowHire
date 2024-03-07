import 'package:flutter/material.dart';
import 'package:shadowhire/model/question_response.dart';

class PaymentBloc {
  // region Common Variables
  BuildContext context;
  QuestionResponse questionResponse;

  // endregion

  // region | Constructor |
  PaymentBloc(this.context, this.questionResponse);

  // endregion

  // region Init
  void init() {}

  // endregion

  // region confirm
  void confirm() {
    print(questionResponse.toJson());
  }

  // endregion

  // region Dispose
  void dispose() {}
// endregion
}
