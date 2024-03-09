import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shadowhire/features/home/question_details.dart';
import 'package:shadowhire/features/home/question_indicators.dart';
import 'package:shadowhire/utils/app_assets.dart';
import 'package:shadowhire/utils/app_colors.dart';
import 'package:shadowhire/utils/app_strings.dart';
import 'home_bloc.dart';
import 'language_selection.dart';

// region HomeScreen
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}
// endregion

class _HomeScreenState extends State<HomeScreen> {
  // region Bloc
  late HomeBloc homeBloc;

  // endregion

  // region Init
  @override
  void initState() {
    homeBloc = HomeBloc(context);
    homeBloc.init();
    super.initState();
  }

  // endregion

  // endregion build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0, backgroundColor: Colors.white, elevation: 0),
      body: body(),
    );
  }

  // endregion

  // region Body
  Widget body() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Hero(
                    tag: "logo",
                    child: Image.asset(AppAssets.logo, height: 70),
                  ),
                ),
              ),
              changeLanguage(homeBloc)
            ],
          ),
        ),
        Expanded(
          child: StreamBuilder<bool>(
              stream: homeBloc.loadingCtrl.stream,
              initialData: true,
              builder: (context, snapshot) {
                if (snapshot.data!) return const Center(child: CircularProgressIndicator());
                return showQuestions();
              }),
        ),
      ],
    );
  }

// endregion

// region showQuestions
  Widget showQuestions() {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1)),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Center(child: Text(AppStrings.message, textAlign: TextAlign.center, style: TextStyle(fontSize: 22))),
              ),
              const SizedBox(height: 20),
              questionIndicators(homeBloc),
            ],
          ),
        ),
        questionDetails(homeBloc),
        reason(),
        prevBtn()
      ],
    );
  }

// endregion

  // region reason
  Widget reason() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.primary.withOpacity(0.1)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.info_outline, color: AppColors.primary),
            const SizedBox(width: 10),
            Expanded(
                child: Text(
              homeBloc.questionResponse.questions![homeBloc.currentQuestion].reason!,
              style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w500),
            )),
          ],
        ),
      ),
    );
  }

  // endregion

  // region prevBtn
  Widget prevBtn() {
    return Container(
      alignment: Alignment.centerLeft,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: homeBloc.currentQuestion == 0 ? null : () => homeBloc.prevQuestion(),
        child: Container(
          height: 45,
          alignment: Alignment.centerLeft,
          width: 100,
          margin: const EdgeInsets.all(30),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: homeBloc.currentQuestion == 0 ? AppColors.primary.withOpacity(0.3) : AppColors.primary),
          child: const Center(
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
      ),
    );
  }

// endregion
}
