import 'package:flutter/material.dart';
import 'package:shadowhire/features/splash/splash_bloc.dart';
import 'package:shadowhire/utils/app_assets.dart';

// region SplashScreen
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}
// endregion

class _SplashScreenState extends State<SplashScreen> {
  // region Bloc
  late SplashBloc splashBloc;

  // endregion

  // region Init
  @override
  void initState() {
    splashBloc = SplashBloc(context);
    splashBloc.init();
    super.initState();
  }

  // endregion

  // region Build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: body(),
    );
  }

  // endregion

  // region body
  Widget body() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Hero(tag: "logo", child: Image.asset(AppAssets.logo)),
      ),
    );
  }
// endregion
}
