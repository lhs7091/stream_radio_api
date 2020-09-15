import 'package:flutter/material.dart';
import 'package:stream_radio_api/export_path.dart';

class NowPlayScreen extends StatelessWidget {
  final String radioTitle;
  final String radioImageUrl;

  const NowPlayScreen({Key key, this.radioTitle, this.radioImageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: new HexColor("#182545")),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NowPlayingWidget(
                  title: this.radioTitle, imageUrl: this.radioImageUrl),
            ],
          ),
        ),
      ),
    );
  }
}
