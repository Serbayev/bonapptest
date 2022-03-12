import 'package:flutter/material.dart';

class Assets {
  static final icons = Icons();
}

class Icons {
  static const _kFontFam = 'CustomIcon';
  static const String? _kFontPkg = null;
  final sortIcon = 'assets/icons/sort.svg';
  final IconData plus =
      const IconData(0xf067, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  final IconData minus =
      const IconData(0xf068, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}
