import 'package:flutter/material.dart';

import 'app_colors.dart';
class CommonWidgets {


  // region ConfirmationBox
  static void confirmationBox(
      BuildContext context,
      String title,
      String msg,
      submit,
      cancel, {
        String msg2 = "",
        String submitBtn = "OK",
        String cancelBtn = "CANCEL",
      }) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Column(children: [
            const SizedBox(height: 16),
            Text("$title", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
            SizedBox(height: 20.0),
            Text("$msg", style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black), textAlign: TextAlign.center),
            Visibility(
              visible: msg2.isNotEmpty,
              child: Text("$msg2", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black), textAlign: TextAlign.center),
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        child: Text(cancelBtn, style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w500)),
                        onPressed: cancel,
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30), side: const BorderSide(color: Colors.grey, width: 1))),
                      )),
                ),
                const SizedBox(width: 10),
                Expanded(
                    child: SizedBox(
                        height: 40,
                        child: ElevatedButton(
                            child: Text(submitBtn),
                            onPressed: submit,
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.primary,
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
                            )))),
              ],
            ),
          ]),
        ));
  }

// endregion
}
