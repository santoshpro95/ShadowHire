import 'dart:async';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:shadowhire/features/home/home_screen.dart';
import 'package:shadowhire/model/intro_model.dart';
import 'package:shadowhire/utils/app_assets.dart';
import 'package:shadowhire/utils/app_strings.dart';
import 'package:shadowhire/utils/common_methods.dart';
import 'package:flutter/material.dart';

class OnBoardingBloc {
  // region Common variable
  BuildContext context;
  final carouselController = CarouselController();

  // end region

  // region controller
  final pageController = StreamController<int>.broadcast();

  // endregion

  // region Constructor
  OnBoardingBloc({required this.context});

  // end region

  // region init
  void init(){

  }
  // endregion

  // region changePage
  void changePage(int index) {
    pageController.sink.add(index);
  }

  // endregion

  // region on Next
  void onNext(int position) {
    if (position == (imagesData.length - 1)) {
      openAppSetup();
    } else {
      carouselController.nextPage();
    }
  }

  // endregion

  // region openAppSetup
  void openAppSetup() {
    var screen = const HomeScreen();
    var route = CommonMethods.createRouteRTL(screen);
    Navigator.push(context, route);
  }

  // endregion

  // region onBoarding data
  List<IntroPage> imagesData = [
    IntroPage(image: AppAssets.onBoarding_1, title: AppStrings.onBoarding_1),
    IntroPage(image: AppAssets.onBoarding_2, title: AppStrings.onBoarding_2),
    IntroPage(image: AppAssets.onBoarding_3, title: AppStrings.onBoarding_3)
  ];

// endregion

// region dispose
  void dispose() {
    pageController.close();
  }
// endregion
}
