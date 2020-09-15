import 'package:flutter/material.dart';
import 'package:stream_radio_api/export_path.dart';

class RadioScreen extends StatefulWidget {
  @override
  _RadioScreenState createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
  RadioModel radioModel = new RadioModel(
    id: 1,
    radioName: "Test Radio 1",
    radioDesc: "Test Radio Desc",
    radioPic: "http://isharpeners.com/sc_logo.png",
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          AppLogoWidget(),
          SearchBar(),
          RadioListWidget(radioModel: radioModel),
          // NowPlayScreen(
          //   radioTitle: "Current Radio Playing",
          //   radioImageUrl: radioModel.radioPic,
          // )
        ],
      ),
    );
  }
}
