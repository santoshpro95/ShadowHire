import 'dart:io';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shadowhire/features/contact/contact_bloc.dart';
import 'package:shadowhire/model/question_response.dart';
import 'package:shadowhire/utils/app_colors.dart';
import 'package:shadowhire/utils/app_strings.dart';

class ContactScreen extends StatefulWidget {
  final QuestionResponse questionResponse;

  const ContactScreen({super.key, required this.questionResponse});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  // region Bloc
  late ContactBloc contactBloc;

  // endregion

  // region Init
  @override
  void initState() {
    contactBloc = ContactBloc(context, widget.questionResponse);
    contactBloc.init();
    super.initState();
  }

  // endregion

  // region Dispose
  @override
  void dispose() {
    contactBloc.dispose();
    super.dispose();
  }

  // endregion

  // region build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.contactDetails),
      ),
      backgroundColor: Colors.white,
      body: body(),
    );
  }

  // endregion

  // region body
  Widget body() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [fullName(), emailId(), phoneNumber(), info(), nextBtn()],
      ),
    );
  }

// endregion

  // region nextBtn
  Widget nextBtn() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: StreamBuilder<bool>(
          stream: contactBloc.loadingCtrl.stream,
          initialData: false,
          builder: (context, snapshot) {
            if (snapshot.data!) return const Center(child: CircularProgressIndicator());
            return CupertinoButton(
              onPressed: () => contactBloc.next(),
              child: Container(
                height: 45,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: AppColors.primary),
                child: const Center(child: Text(AppStrings.next, style: TextStyle(color: Colors.white))),
              ),
            );
          }),
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
            Expanded(child: Text(AppStrings.contactMsg, style: TextStyle(color: AppColors.primary, fontSize: 16)))
          ],
        ),
      ),
    );
  }

  // endregion

  // region emailId
  Widget emailId() {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 0.5, offset: Offset(0, 1))],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: StreamBuilder<bool>(
            stream: contactBloc.validEmailCtrl.stream,
            initialData: true,
            builder: (context, snapshot) {
              return TextField(
                autofocus: true,
                style: const TextStyle(fontSize: 18, letterSpacing: 1),
                onChanged: (text) => contactBloc.onChangeText(text),
                controller: contactBloc.emailTextCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: AppStrings.enterEmail,
                    errorText: snapshot.data! ? null : AppStrings.enterValidEmail,
                    counterText: "",
                    labelText: AppStrings.enterEmail,
                    border: InputBorder.none),
              );
            }),
      ),
    );
  }

  // endregion

  // region fullName
  Widget fullName() {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 0.5, offset: Offset(0, 1))],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextField(
          autofocus: true,
          style: const TextStyle(fontSize: 18, letterSpacing: 1),
          controller: contactBloc.fullNameCtrl,
          keyboardType: TextInputType.name,
          decoration: const InputDecoration(hintText: AppStrings.enterName, labelText: AppStrings.enterName, border: InputBorder.none),
        ),
      ),
    );
  }

  // endregion

  // region phoneNumber
  Widget phoneNumber() {
    return Wrap(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 0.5, offset: Offset(0, 1))],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              countryCode(),
              Expanded(
                child: TextField(
                  style: const TextStyle(fontSize: 18, letterSpacing: 1),
                  maxLength: 14,
                  autofocus: true,
                  controller: contactBloc.phoneNumberTextCtrl,
                  keyboardType: Platform.isAndroid ? TextInputType.phone : const TextInputType.numberWithOptions(signed: false, decimal: false),
                  decoration: const InputDecoration(hintText: AppStrings.enterNumber, border: InputBorder.none, counterText: ""),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // endregion

  // region countryCode
  Widget countryCode() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CountryCodePicker(
              onChanged: (countryCode) => contactBloc.selectedCountryCode = countryCode.dialCode!,
              initialSelection: contactBloc.defaultCountryCode,
              showCountryOnly: false,
              emptySearchBuilder: (d) => const Center(child: Text(AppStrings.noCountryFound)),
              searchDecoration: const InputDecoration(hintText: AppStrings.searchCode),
              showOnlyCountryWhenClosed: false,
              alignLeft: false),
          Container(height: 30, width: 0.5, color: Colors.grey),
        ],
      ),
    );
  }

// endregion
}
