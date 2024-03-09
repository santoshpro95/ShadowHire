import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shadowhire/features/details/details_bloc.dart';
import 'package:shadowhire/utils/app_assets.dart';
import 'package:shadowhire/utils/app_colors.dart';
import 'package:shadowhire/utils/app_strings.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  // region Bloc
  late DetailsBloc detailsBloc;

  // endregion

  // region Init
  @override
  void initState() {
    detailsBloc = DetailsBloc(context);
    detailsBloc.init();
    super.initState();
  }

  // endregion

  // region Dispose
  @override
  void dispose() {
    detailsBloc.dispose();
    super.dispose();
  }

  // endregion

  // region Build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0, backgroundColor: Colors.white, elevation: 0),
      body: body(),
    );
  }

// endregion

// region body
  Widget body() {
    return StreamBuilder<bool>(
        stream: detailsBloc.loadingCtrl.stream,
        initialData: true,
        builder: (context, snapshot) {
          if (snapshot.data!) return const Center(child: CircularProgressIndicator());
          return details();
        });
  }

// endregion

// region details
  Widget details() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Image.asset(AppAssets.logo, height: 70),
              ),
              const SizedBox(width: 10),
              const Text(
                AppStrings.details,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              )
            ],
          ),
          Expanded(
            child: ListView(
              children: [
                info(),
                const SizedBox(height: 10),
                Text(
                  "${detailsBloc.questionResponse.phoneNo!} | ${detailsBloc.questionResponse.emailId!}",
                  style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.primary, fontSize: 18),
                ),
                const SizedBox(height: 10),
                questionDetails(),
                closeInvestigation()
              ],
            ),
          ),
        ],
      ),
    );
  }

// endregion

  // region info
  Widget info() {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.primary.withOpacity(0.1)),
      child: const Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.info_outline, color: AppColors.primary),
            SizedBox(width: 10),
            Expanded(child: Text(AppStrings.contactMessage, style: TextStyle(color: AppColors.primary, fontSize: 16)))
          ],
        ),
      ),
    );
  }

  // endregion

  // region closeInvestigation
  Widget closeInvestigation() {
    return CupertinoButton(
      onPressed: () => detailsBloc.closeInvestigation(),
      padding: EdgeInsets.zero,
      child: Container(
        height: 45,
        margin: const EdgeInsets.only(bottom: 10),
        width: double.maxFinite,
        child: const Center(
            child: Text(
          AppStrings.closeInvestigation,
          style: TextStyle(color: AppColors.close, fontSize: 18, fontWeight: FontWeight.w600),
        )),
      ),
    );
  }

  // endregion

  // region status Item
  Widget statusItem(String image, String name, int status) {
    return Column(
      children: [
        SvgPicture.asset(image, width: 30, height: 30, color: detailsBloc.status >= status ? AppColors.primary : Colors.black45),
        const SizedBox(height: 5),
        Text(
          name,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: detailsBloc.status >= status ? AppColors.primary : Colors.black45),
        )
      ],
    );
  }

  // endregion

// region questionDetails
  Widget questionDetails() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  detailsBloc.questionResponse.questions![index].question!,
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                Text(
                  detailsBloc.questionResponse.questions![index].answer!,
                  style: const TextStyle(fontWeight: FontWeight.w500, color: AppColors.primary, fontSize: 16),
                ),
              ],
            ),
          );
        },
        itemCount: detailsBloc.questionResponse.questions!.length);
  }
// endregion
}
