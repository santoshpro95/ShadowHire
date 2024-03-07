import 'package:carousel_slider/carousel_slider.dart';
import 'package:shadowhire/model/intro_model.dart';
import 'package:shadowhire/utils/app_assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shadowhire/utils/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'onboarding_bloc.dart';

// region OnBoardingScreen
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}
// endregion

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  // region bloc
  late OnBoardingBloc onBoardingBloc;

  // end region

  // region init
  @override
  void initState() {
    super.initState();
    onBoardingBloc = OnBoardingBloc(context: context);
    onBoardingBloc.init();
  }

  // endregion

  // region Dispose
  @override
  void dispose() {
    onBoardingBloc.dispose();
    super.dispose();
  }

  // endregion

// region Build
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: body(),
        appBar: AppBar(toolbarHeight: 0, backgroundColor: Colors.white, elevation: 0),
      ),
    );
  }

  // endregion

  // region body
  Widget body() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Hero(tag: "logo", child: Image.asset(AppAssets.logo, height: 170)),
            const SizedBox(height: 40),
            Expanded(flex: 6, child: sliderImages()),
            const SizedBox(height: 40),
            bottomView(),
          ],
        ),
      ),
    );
  }

  // endregion

  // region sliderImages
  Widget sliderImages() {
    return CarouselSlider(
        carouselController: onBoardingBloc.carouselController,
        options: CarouselOptions(
          viewportFraction: 1,
          autoPlay: false,
          height: double.maxFinite,
          enableInfiniteScroll: false,
          onPageChanged: (index, reason) => onBoardingBloc.changePage(index),
        ),
        items: onBoardingBloc.imagesData.map((page) {
          return Builder(
            builder: (BuildContext context) => imageWithTextView(page),
          );
        }).toList());
  }

  // endregion

  // region imageWithTextView
  Widget imageWithTextView(IntroPage page) {
    return Column(
      children: [
        Expanded(child: Image.asset(page.image)),
        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            page.title,
            style: const TextStyle(color: Colors.black54, fontSize: 22, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 80),
      ],
    );
  }

  // endregion

  // region bottomView
  Widget bottomView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [indicator(), nextButton()],
    );
  }

  // endregion

  // region indicator
  Widget indicator() {
    return StreamBuilder<int>(
        stream: onBoardingBloc.pageController.stream,
        initialData: 0,
        builder: (context, snapShot) {
          return AnimatedSmoothIndicator(
            activeIndex: snapShot.data!,
            count: onBoardingBloc.imagesData.length,
            effect: const ExpandingDotsEffect(
                dotColor: AppColors.primary, activeDotColor: AppColors.primary, dotHeight: 13, dotWidth: 13, expansionFactor: 3, spacing: 20),
          );
        });
  }

  // endregion

  // region nextButton
  Widget nextButton() {
    return StreamBuilder<int>(
      stream: onBoardingBloc.pageController.stream,
      initialData: 0,
      builder: (context, snapshot) {
        return CupertinoButton(
          onPressed: () => onBoardingBloc.onNext(snapshot.data!),
          padding: EdgeInsets.zero,
          child: Container(
            decoration: const BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.all(Radius.circular(30))),
            height: 50,
            width: 100,
            alignment: Alignment.center,
            child: const Text("Next", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
          ),
        );
      },
    );
  }
// endregion
}
