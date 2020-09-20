import 'package:flutter/material.dart';
import 'package:stream_radio_api/export_path.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new RadioScreen(
      isFavoriteOnly: true,
    );
  }
}
