import 'package:flutter/material.dart';
import 'package:shadowhire/features/home/home_bloc.dart';
import 'package:shadowhire/utils/app_colors.dart';

Widget questionIndicators(HomeBloc homeBloc) {
  return Center(
    child: SizedBox(
      height: 5,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 500),
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                  color:index <= homeBloc.currentQuestion? AppColors.primary: Colors.transparent,
                  border: Border.all(width: 1, color: AppColors.primary)),
              width: 25);
        },
        itemCount: homeBloc.questionResponse.questions!.length,
      ),
    ),
  );
}
