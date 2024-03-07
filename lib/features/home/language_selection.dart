import 'package:flutter/material.dart';
import 'package:shadowhire/features/home/home_bloc.dart';
import 'package:shadowhire/utils/app_colors.dart';

// region change Language
Widget changeLanguage(HomeBloc homeBloc) {
  return Row(
    children: [
      PopupMenuButton<String>(
        onSelected: (value) => homeBloc.languageSelection(value),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ValueListenableBuilder<String>(
                  valueListenable: homeBloc.languageCtrl,
                  builder: (context, value, _) {
                    return Text(
                      value,
                      style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700, fontSize: 20),
                    );
                  }),
              const Icon(Icons.arrow_drop_down, color: AppColors.primary),
            ],
          ),
        ),
        itemBuilder: (context) {
          return <PopupMenuEntry<String>>[
            const PopupMenuItem(
                value: "English",
                child: Text(
                  "English",
                  style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700, fontSize: 18),
                )),
            const PopupMenuItem(
                value: "Hindi",
                child: Text(
                  "Hindi",
                  style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700, fontSize: 18),
                ))
          ];
        },
      ),
    ],
  );
}

// endregion
