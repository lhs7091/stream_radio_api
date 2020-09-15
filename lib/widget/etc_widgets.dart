import 'package:flutter/material.dart';
import 'package:stream_radio_api/export_path.dart';

class AppLogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: HexColor("#182545"),
      height: 40.0,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: Text(
            "Radio App",
            style: TextStyle(fontSize: 15.0, color: HexColor("#ffffff")),
          ),
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
