import 'package:flutter/cupertino.dart';
import 'package:shadowhire/features/home/home_screen.dart';
import 'package:shadowhire/features/onboarding/onboarding_screen.dart';
import 'package:shadowhire/services/cache_storage/cache_storage_service.dart';
import 'package:shadowhire/services/cache_storage/storage_keys.dart';
import 'package:shadowhire/utils/common_methods.dart';

class SplashBloc {
  // region Common Methods
  BuildContext context;

  // endregion

  // region Services
  CacheStorageService cacheStorageService = CacheStorageService();

  // endregion

  // region | Constructor |
  SplashBloc(this.context);

  // endregion

  // region Init
  void init() async {
    // delay for 2 seconds
    await Future.delayed(const Duration(seconds: 1));

    // check onboarding
    var isOnboardingFinished = await cacheStorageService.getBoolean(StorageKeys.isOnboardingFinished);
    if (isOnboardingFinished) {
      openHomeScreen();
    } else {
      openOnboarding();
    }
  }

  // endregion

  // region openOnboarding
  void openOnboarding() async {
    var screen = const OnBoardingScreen();
    var route = CommonMethods.createRouteRTL(screen);
    Navigator.push(context, route);
  }

// endregion

  // region OpenHomeScreen
  void openHomeScreen() async {
    var screen = const HomeScreen();
    var route = CommonMethods.createRouteRTL(screen);
    Navigator.push(context, route);
  }
// endregion
}
