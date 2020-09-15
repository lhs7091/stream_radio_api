import 'package:flutter/material.dart';

import 'package:stream_radio_api/export_path.dart';

class RadioRowWidget extends StatelessWidget {
  final RadioModel radioModel;

  const RadioRowWidget({Key key, this.radioModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: new Text(
        radioModel.radioName,
        style: new TextStyle(
          fontWeight: FontWeight.bold,
          color: HexColor("#182545"),
        ),
      ),
      leading: _image(radioModel.radioPic),
      subtitle: new Text(radioModel.radioDesc, maxLines: 2),
      trailing: Wrap(
        spacing: -10.0,
        runSpacing: 0.0,
        children: [
          _buildPlayStopIcon(),
          _buildAppFavoriteIcon(),
        ],
      ),
    );
  }

  Widget _image(url, {size}) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.network(url),
      ),
      height: size == null ? 55.0 : size,
      width: size == null ? 55.0 : size,
      decoration: BoxDecoration(
          color: HexColor("#FFE5EC"),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 3),
            ),
          ]),
    );
  }

  Widget _buildPlayStopIcon() {
    return IconButton(
        icon: Icon(Icons.play_circle_filled),
        onPressed: () {
          return null;
        });
  }

  Widget _buildAppFavoriteIcon() {
    return IconButton(
        icon: Icon(Icons.favorite_border),
        color: HexColor("#9097A6"),
        onPressed: () {
          return null;
        });
  }
}
