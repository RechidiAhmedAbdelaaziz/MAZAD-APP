import 'package:flutter/cupertino.dart';
import 'package:mazad_app/core/localization/app_localization.dart';

extension LocalizationExtension on String {
  String tr(BuildContext context) =>
      AppLocalizations.of(context)?.translate(this) ?? this;

  void changeLanguage(BuildContext context, String langCode) {
    AppLocalizations.of(context)?.load();
  }
}
