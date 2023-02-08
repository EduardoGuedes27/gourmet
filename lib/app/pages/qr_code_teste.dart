import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: QrImage(
          data: "https://gourmet-vix.web.app/#/homepage?id=123",
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
    );
  }
}
