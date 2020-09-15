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

  fetchAllRadios() async {
    _radiosFetcher = await DBDownLoadService.fetchLocalDB();
    notifyListeners();
  }

  void updatePlayerState(RadioPlayerState state) {
    _playerState = state;
    notifyListeners();
  }
}
