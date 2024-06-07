import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kanban_tracker/presentation/common/colors/app_colors.dart';

extension BuildContextExtensions on BuildContext {
  AppLocalizations get strings => AppLocalizations.of(this)!;

  void showToast({
    required final String message,
  }) {
    Fluttertoast.showToast(
      msg: message,
      textColor: AppColors.dark,
      backgroundColor: AppColors.toastBackground,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 2,
      gravity: ToastGravity.BOTTOM,
    );
  }
}
