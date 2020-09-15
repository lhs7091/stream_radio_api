import 'package:flutter/material.dart';
import 'package:stream_radio_api/export_path.dart';

class RadioRowScreen extends StatefulWidget {
  final RadioModel radioModel;

  RadioRowScreen({
    Key key,
    this.radioModel,
  }) : super(key: key);

  @override
  _RadioRowScreenState createState() => _RadioRowScreenState();
}

class _RadioRowScreenState extends State<RadioRowScreen> {
  @override
  Widget build(BuildContext context) {
    return RadioRowWidget(radioModel: this.widget.radioModel);
  }
}
