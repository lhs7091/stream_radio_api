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
    var playerProvider =
        Provider.of<PlayerProviderService>(context, listen: false);
    final bool _isSelectedRadio =
        radioModel.id == playerProvider.currentRadio.id;

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
          _buildPlayStopIcon(context, _isSelectedRadio),
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

  Widget _buildPlayStopIcon(BuildContext context, bool isSelectedSong) {
    var playerProvider =
        Provider.of<PlayerProviderService>(context, listen: false);

    return IconButton(
        icon: _buildAudioButton(playerProvider, isSelectedSong),
        onPressed: () {
          playerProvider.updatePlayerState(RadioPlayerState.PLAYING);
          if (!playerProvider.isStopped() && isSelectedSong) {
            playerProvider.stopRadio();
          } else {
            if (!playerProvider.isLoading()) {
              playerProvider.initAudioPlayer();
              playerProvider.setAudioPlayer(radioModel);
              playerProvider.playRadio();
            }
          }
        });
  }

  Widget _buildAudioButton(PlayerProviderService model, _isSelectedSong) {
    if (_isSelectedSong) {
      if (model.isLoading()) {
        return Center(
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
          ),
        );
      }
      if (!model.isStopped()) {
        return Icon(Icons.stop);
      }
      if (model.isStopped()) {
        return Icon(Icons.play_circle_filled);
      }
    } else {
      return Icon(Icons.play_circle_filled);
    }
    return Container();
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
