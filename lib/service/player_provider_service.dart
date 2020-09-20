import 'package:flutter/material.dart';
import 'package:stream_radio_api/export_path.dart';

enum RadioPlayerState {
  LOADING,
  STOPPED,
  PLAYING,
  PAUSED,
  COMPLETED,
}

class PlayerProviderService with ChangeNotifier {
  List<RadioModel> _radiosFetcher;
  List<RadioModel> get allRadio => _radiosFetcher;
  int get totalRecords => _radiosFetcher != null ? _radiosFetcher.length : 0;
  getPlayerState() => _playerState;

  RadioPlayerState _playerState = RadioPlayerState.STOPPED;
  playerProvider() {
    _radiosFetcher = List<RadioModel>();
  }

  fetchAllRadios({String searchQuery = "", bool isFavoriteOnly = false}) async {
    _radiosFetcher = await DBDownLoadService.fetchLocalDB(
        searchQuery: searchQuery, isFavoriteOnly: isFavoriteOnly);
    notifyListeners();
  }

  Future<void> radioBookmarked(int radioId, bool isFavorite,
      {bool isFavoriteOnly = false}) async {
    var isFavoriteVal = isFavorite ? 0 : 1;
    await DB.init();
    await DB.rawInsert(
        "insert or replace into radios_bookmarks (id, isFavourite) values ($radioId, $isFavoriteVal)");
    fetchAllRadios(isFavoriteOnly: isFavoriteOnly);
  }

  void updatePlayerState(RadioPlayerState state) {
    _playerState = state;
    notifyListeners();
  }
}
