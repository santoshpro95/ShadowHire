import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shadowhire/features/payment/payment_bloc.dart';
import 'package:shadowhire/model/question_response.dart';
import 'package:shadowhire/utils/app_assets.dart';
import 'package:shadowhire/utils/app_colors.dart';
import 'package:shadowhire/utils/app_constants.dart';
import 'package:shadowhire/utils/app_strings.dart';

class PaymentScreen extends StatefulWidget {
  final QuestionResponse questionResponse;

  const PaymentScreen({super.key, required this.questionResponse});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  // region Bloc
  late PaymentBloc paymentBloc;

  // endregion

  // region Init
  @override
  void initState() {
    paymentBloc = PaymentBloc(context, widget.questionResponse);
    paymentBloc.init();
    super.initState();
  }

  // endregion

  // region Dispose
  @override
  void dispose() {
    paymentBloc.dispose();
    super.dispose();
  }

  // endregion

  // region body
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text(AppStrings.payment)),
      body: body(),
    );
  }

  // endregion

  // region body
  Widget body() {
    return Stack(
      children: [
        Opacity(opacity: 0.5, child: Image.asset(AppAssets.background, height: 200, width: double.maxFinite, fit: BoxFit.cover)),
        Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [qrCode(), info(), verify(), confirm()],
          ),
        ),
      ],
    );
  }

// endregion

  // region confirm
  Widget confirm() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: CupertinoButton(
        onPressed: () => paymentBloc.confirm(),
        child: Container(
          height: 45,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: AppColors.primary),
          child: const Center(child: Text(AppStrings.confirm, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500))),
        ),
      ),
    );
  }

  // endregion

  // region info
  Widget info() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.primary.withOpacity(0.1)),
      child: const Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.info_outline, color: AppColors.primary),
            SizedBox(width: 10),
            Expanded(child: Text(AppStrings.paymentMsg, style: TextStyle(color: AppColors.primary, fontSize: 16)))
          ],
        ),
      ),
    );
  }

  // endregion

  // region verify
  Widget verify() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.primary.withOpacity(0.1)),
      child: const Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.info_outline, color: AppColors.primary),
            SizedBox(width: 10),
            Expanded(child: Text(AppStrings.verifyPayment, style: TextStyle(color: AppColors.primary, fontSize: 16)))
          ],
        ),
      ),
    );
  }

  // endregion

// region QrCode
  Widget qrCode() {
    return Container(
      height: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(width: 3, color: AppColors.primary)),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: QrImageView(
                        data: "${AppConstants.paymentUrl}${paymentBloc.questionResponse.phoneNo}",
                        version: QrVersions.auto,
                        size: MediaQuery.of(context).size.width,
                        gapless: false)),
              ),
            ),
          ),
          const Text(AppStrings.amount, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.primary)),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
// endregion
}
