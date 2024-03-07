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
        children: [phoneNumber(), emailId(), nextBtn()],
      ),
    );
  }

// endregion

  // region nextBtn
  Widget nextBtn() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: StreamBuilder<bool>(
          stream: contactBloc.validEmailCtrl.stream,
          initialData: false,
          builder: (context, snapshot) {
            return CupertinoButton(
              onPressed: snapshot.data! ? () => contactBloc.openPayment() : null,
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50), color: snapshot.data! ? AppColors.primary : AppColors.primary.withOpacity(0.3)),
                child: const Center(child: Text(AppStrings.next, style: TextStyle(color: Colors.white))),
              ),
            );
          }),
    );
  }

  // endregion

  // region emailId
  Widget emailId() {
    return Container(
      margin: const EdgeInsets.only(top: 15),
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
          onChanged: (text) => contactBloc.onChangeText(text),
          controller: contactBloc.emailTextCtrl,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(hintText: AppStrings.enterEmail, labelText: AppStrings.enterEmail, border: InputBorder.none),
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
              onChanged: (countryCode) => contactBloc.onCountryChange(countryCode),
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
