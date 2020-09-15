import 'package:flutter/material.dart';
import 'package:stream_radio_api/export_path.dart';

class RadioListWidget extends StatelessWidget {
  final RadioModel radioModel;

  const RadioListWidget({Key key, this.radioModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
        future: DBDownLoadService.fetchLocalDB(),
        builder:
            (BuildContext context, AsyncSnapshot<List<RadioModel>> snapshot) {
          if (snapshot.hasData) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
                child: ListView(
                  children: [
                    ListView.separated(
                      itemCount: snapshot.data.length,
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return RadioRowScreen(
                          radioModel: snapshot.data[index],
                        );
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
          return CircularProgressIndicator();
        });
  }
}
