import 'dart:ui';

import '../../core/assets/image_assets.dart';

enum Language {
  english(
    Locale('en', 'US'),
    ImageAssets.english,
    'English',
  ),
  indonesia(
    Locale('id', 'ID'),
    ImageAssets.indonesia,
    'Bahasa Indonesia',
  );

  const Language(this.value, this.image, this.text);

  final Locale value;
  final String image;
  final String text;
}
