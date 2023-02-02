import 'package:flutter/material.dart';
import 'package:gourmet_mesa/app/styles/cores_style.dart';
import 'package:gourmet_mesa/app/styles/texto_styles.dart';

class AppStyles {
  ButtonStyle get botaoPrimario => ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        backgroundColor: PaletaCores.corPrimaria,
        textStyle: TextoStyles().textoBotao,
      );
}
