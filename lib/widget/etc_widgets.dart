import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stream_radio_api/export_path.dart';

class AppLogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: HexColor("#182545"),
      height: 40.0,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: Text(
            "Radio App",
            style: TextStyle(fontSize: 15.0, color: HexColor("#ffffff")),
          ),
        ),
      ),
    );
  }
}
