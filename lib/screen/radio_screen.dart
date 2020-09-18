import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_radio_api/export_path.dart';

class RadioScreen extends StatefulWidget {
  @override
  _RadioScreenState createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
  final _searchQuery = new TextEditingController();
  Timer _debounce;

  @override
  void initState() {
    var playerProvider =
        Provider.of<PlayerProviderService>(context, listen: false);
    playerProvider.fetchAllRadios();

    super.initState();
    print('initState()');

    _searchQuery.addListener(() {
      var radioProvider =
          Provider.of<PlayerProviderService>(context, listen: false);
      if (_debounce?.isActive ?? false) _debounce.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        radioProvider.fetchAllRadios(searchQuery: _searchQuery.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          AppLogoWidget(),
          _searchBar(),
          RadioListWidget(),
          _nowPlaying(),
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

  Widget _searchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.search),
          Flexible(
            child: TextField(
              controller: _searchQuery,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(5.0),
                hintText: 'Search Radio',
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
