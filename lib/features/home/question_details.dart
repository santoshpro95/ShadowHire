import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shadowhire/features/home/home_bloc.dart';
import 'package:shadowhire/utils/app_colors.dart';

Widget questionDetails(HomeBloc homeBloc) {
  var question = homeBloc.questionResponse.questions![homeBloc.currentQuestion];
  return Expanded(
      child: Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
      children: [
        Text(question.question!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => homeBloc.onSelectAns(question, question.options![index]),
                child: Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: AppColors.primary.withOpacity(0.2)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Text(
                      question.options![index],
                      style: const TextStyle(fontSize: 16, color: AppColors.primary, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              );
            },
            itemCount: question.options!.length,
          ),
        )
      ],
    ),
  ));
}
