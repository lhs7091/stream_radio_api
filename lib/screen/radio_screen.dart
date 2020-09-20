import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_radio_api/export_path.dart';

class RadioScreen extends StatefulWidget {
  final bool isFavoriteOnly;

  const RadioScreen({Key key, this.isFavoriteOnly}) : super(key: key);

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
    playerProvider.fetchAllRadios(isFavoriteOnly: this.widget.isFavoriteOnly);

    super.initState();
    print('initState()');

    _searchQuery.addListener(() {
      var radioProvider =
          Provider.of<PlayerProviderService>(context, listen: false);
      if (_debounce?.isActive ?? false) _debounce.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        radioProvider.fetchAllRadios(
            searchQuery: _searchQuery.text,
            isFavoriteOnly: this.widget.isFavoriteOnly);
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
          _radioListWidget(),
          _nowPlaying(),
        ],
      ),
    );
  }

  Widget _radioListWidget() {
    return Consumer<PlayerProviderService>(
        builder: (BuildContext context, radioModel, child) {
      if (radioModel.totalRecords > 0) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
            child: ListView(
              children: [
                ListView.separated(
                  itemCount: radioModel.totalRecords,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return RadioRowScreen(
                        radioModel: radioModel.allRadio[index],
                        isFavoriteOnly: this.widget.isFavoriteOnly);
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                ),
              ],
            ),
          ),
        );
      }
      if (radioModel.totalRecords == 0) {
        return new Expanded(
          child: _noData(),
        );
      }
      return CircularProgressIndicator();
    });
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

  Widget _noData() {
    String noDataText = "";
    bool showTextMessage = false;

    if (this.widget.isFavoriteOnly ||
        (this.widget.isFavoriteOnly && _searchQuery.text.isNotEmpty)) {
      noDataText = "No Favorites";
      showTextMessage = true;
    } else if (_searchQuery.text.isNotEmpty) {
      noDataText = "No Radio Found";
      showTextMessage = true;
    }
    return Column(
      children: [
        Expanded(
          child: Center(
              child: showTextMessage
                  ? new Text(noDataText)
                  : CircularProgressIndicator()),
        ),
      ],
    );
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
