import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_radio_api/export_path.dart';

class NowPlayingWidget extends StatefulWidget {
  final String title;
  final String radioURL;

  const NowPlayingWidget({Key key, this.title, this.radioURL})
      : super(key: key);

  @override
  _NowPlayingWidgetState createState() => _NowPlayingWidgetState();
}

class _NowPlayingWidgetState extends State<NowPlayingWidget> {
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 10.0),
      child: ListTile(
        title: new Text(
          widget.title,
          style: new TextStyle(
            fontWeight: FontWeight.bold,
            color: HexColor("#ffffff"),
          ),
        ),
        subtitle: new Text(
          "Now Playing",
          textScaleFactor: 0.8,
          style: new TextStyle(
            color: HexColor("#ffffff"),
          ),
        ),
        leading: _image(widget.radioURL, size: 50.0),
        trailing: Wrap(
          spacing: -10.0,
          children: [
            _buildStopIcon(context),
            _buildShareIcon(),
          ],
        ),
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

  Widget _buildStopIcon(BuildContext context) {
    var playerProvider =
        Provider.of<PlayerProviderService>(context, listen: false);

    return IconButton(
        icon: Icon(Icons.stop),
        onPressed: () {
          playerProvider.updatePlayerState(RadioPlayerState.STOPPED);
        });
  }

  Widget _buildShareIcon() {
    return IconButton(
        icon: Icon(Icons.share),
        color: HexColor("#9097A6"),
        onPressed: () {
          return null;
        });
  }
}
