// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:gourmet_mesa/app/styles/cores_style.dart';

class TextoStyles {
  TextStyle get textoLigth => const TextStyle(fontWeight: FontWeight.w300);

  TextStyle get textoRegular => TextStyle(fontWeight: FontWeight.normal);

  TextStyle get textoBold => const TextStyle(fontWeight: FontWeight.bold);

  TextStyle get textoBotao => textoBold.copyWith(
        fontSize: 14,
        color: PaletaCores.corTextoBotao,
      );
}
