import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  void initState() {
    var playerProvider =
        Provider.of<PlayerProviderService>(context, listen: false);
    playerProvider.fetchAllRadios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          AppLogoWidget(),
          SearchBar(),
          RadioListWidget(radioModel: radioModel),
          _nowPlaying(),
          // NowPlayScreen(
          //   radioTitle: radioModel.radioName,
          //   radioImageUrl: radioModel.radioPic,
          // )
        ],
      ),
    );
  }

  Widget _nowPlaying() {
    var playerProvider =
        Provider.of<PlayerProviderService>(context, listen: true);

    return Visibility(
        visible: playerProvider.getPlayerState() == RadioPlayerState.PLAYING,
        child: NowPlayScreen(
          radioTitle: "Current Radio Playing",
          radioImageUrl: "http://isharpeners.com/sc_logo.png",
        ));
  }
}
