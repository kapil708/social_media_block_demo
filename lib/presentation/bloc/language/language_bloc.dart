import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_block_demo/data/data_sources/local_data_source.dart';
import 'package:social_media_block_demo/injection_container.dart';

import '../../../core/language/language.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(const LanguageState()) {
    on<ChangeLanguage>(onChangeLanguage);
    on<GetLanguage>(onGetLanguage);
  }

  onChangeLanguage(ChangeLanguage event, Emitter<LanguageState> emit) async {
    await locator.get<LocalDataSource>().cacheLanguage(event.selectedLanguage.value.languageCode);
    emit(state.copyWith(selectedLanguage: event.selectedLanguage));
  }

  onGetLanguage(GetLanguage event, Emitter<LanguageState> emit) async {
    final selectedLanguage = locator.get<LocalDataSource>().getLanguage();
    emit(state.copyWith(
      selectedLanguage: selectedLanguage != null ? Language.values.where((item) => item.value.languageCode == selectedLanguage).first : Language.english,
    ));
  }
}
