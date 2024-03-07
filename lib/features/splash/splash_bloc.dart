import 'package:flutter/cupertino.dart';
import 'package:shadowhire/features/home/home_screen.dart';
import 'package:shadowhire/features/onboarding/onboarding_screen.dart';
import 'package:shadowhire/utils/common_methods.dart';

class SplashBloc {
  // region Common Methods
  BuildContext context;

  // endregion

  // region | Constructor |
  SplashBloc(this.context);

  // endregion

  // region Init
  void init() {
    // open Home Screen
    openHomeScreen();
  }

  // endregion

  // region OpenHomeScreen
  void openHomeScreen() async {
    // delay for 2 seconds
    await Future.delayed(const Duration(seconds: 2));

    // region open home screen
    var screen = const OnBoardingScreen();
    var route = CommonMethods.createRouteRTL(screen);
    if (!context.mounted) return;
    Navigator.push(context, route);
    // endregion
  }
// endregion
}
