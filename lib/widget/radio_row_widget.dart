import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:stream_radio_api/export_path.dart';

class RadioRowWidget extends StatelessWidget {
  final RadioModel radioModel;
  final bool isFavoriteOnly;

  const RadioRowWidget({Key key, this.radioModel, this.isFavoriteOnly})
      : super(key: key);

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
          _buildPlayStopIcon(context),
          _buildAppFavoriteIcon(context),
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

  Widget _buildPlayStopIcon(BuildContext context) {
    var playerProvider =
        Provider.of<PlayerProviderService>(context, listen: false);

    return IconButton(
        icon: Icon(Icons.play_circle_filled),
        onPressed: () {
          playerProvider.updatePlayerState(RadioPlayerState.PLAYING);
        });
  }

  Widget _buildAppFavoriteIcon(BuildContext context) {
    var playerProvider =
        Provider.of<PlayerProviderService>(context, listen: false);

    return IconButton(
        icon: radioModel.isBookmarked
            ? Icon(Icons.favorite)
            : Icon(Icons.favorite_border),
        color: HexColor("#9097A6"),
        onPressed: () {
          playerProvider.radioBookmarked(radioModel.id, radioModel.isBookmarked,
              isFavoriteOnly: isFavoriteOnly);
        });
  }
}
