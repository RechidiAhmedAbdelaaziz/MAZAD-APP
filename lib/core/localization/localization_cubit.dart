import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalizationCubit extends Cubit<Locale?> {
  LocalizationCubit() : super(null);

  void changeLanguage(String langCode) => emit(Locale(langCode));
}
