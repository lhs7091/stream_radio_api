import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
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

  AudioPlayer _audioPlayer;
  RadioModel _radioDetails;

  RadioModel get currentRadio => _radioDetails;

  RadioPlayerState _playerState = RadioPlayerState.STOPPED;

  getAudioPlayer() => _audioPlayer;
  getCurrentPlayer() => _radioDetails;

  StreamSubscription _positionSubScription;

  playerProvider() {
    //_radiosFetcher = List<RadioModel>();
  }

  void initStreams() {
    _radiosFetcher = List<RadioModel>();
    if (_radioDetails == null) {
      _radioDetails = RadioModel(id: 0);
    }
  }

  void initAudioPlugin() {
    if (_playerState == RadioPlayerState.STOPPED) {
      _audioPlayer = new AudioPlayer();
    } else {
      _audioPlayer = getAudioPlayer();
    }
  }

  setAudioPlayer(RadioModel radioModel) async {
    _radioDetails = radioModel;
  }

  initAudioPlayer() async {
    updatePlayerState(RadioPlayerState.LOADING);
    _positionSubScription =
        _audioPlayer.onAudioPositionChanged.listen((Duration p) {
      if (_playerState == RadioPlayerState.LOADING && p.inMilliseconds > 0) {
        updatePlayerState(RadioPlayerState.PLAYING);
      }
      notifyListeners();
    });

    _audioPlayer.onPlayerStateChanged.listen((AudioPlayerState state) {
      if (state == AudioPlayerState.STOPPED ||
          state == AudioPlayerState.COMPLETED) {
        updatePlayerState(RadioPlayerState.STOPPED);
        notifyListeners();
      }
    });
  }

  playRadio() async {
    print("playRadio() ${currentRadio.radioURL}");
    await _audioPlayer.play(currentRadio.radioURL, stayAwake: true);
  }

  stopRadio() async {
    if (_audioPlayer != null) {
      _positionSubScription?.cancel();
      updatePlayerState(RadioPlayerState.STOPPED);
      await _audioPlayer.stop();
    }
  }

  bool isPlaying() {
    return getPlayerState() == RadioPlayerState.PLAYING;
  }

  bool isLoading() {
    return getPlayerState() == RadioPlayerState.LOADING;
  }

  bool isStopped() {
    return getPlayerState() == RadioPlayerState.STOPPED;
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
