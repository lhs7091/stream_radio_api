import 'package:flutter/material.dart';
import 'package:stream_radio_api/export_path.dart';

class RadioRowScreen extends StatefulWidget {
  final RadioModel radioModel;
  final bool isFavoriteOnly;

  RadioRowScreen({
    Key key,
    this.radioModel,
    this.isFavoriteOnly,
  }) : super(key: key);

  @override
  _RadioRowScreenState createState() => _RadioRowScreenState();
}

class _RadioRowScreenState extends State<RadioRowScreen> {
  @override
  Widget build(BuildContext context) {
    print("_RadioRowScreenState ${this.widget.radioModel.radioURL}");
    print("_RadioRowScreenState ${this.widget.radioModel.radioName}");
    return RadioRowWidget(
        radioModel: this.widget.radioModel,
        isFavoriteOnly: this.widget.isFavoriteOnly);
  }
}
