// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:gourmet_mesa/app/core/styles/app_styles.dart';

class TituloPaginaComponente extends StatelessWidget {
  final String titulo_pagina;

  const TituloPaginaComponente({
    Key key,
    @required this.titulo_pagina,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
      child: SelectableText(
        titulo_pagina,
        style: Theme.of(context)
            .textTheme
            .headline5
            .copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
