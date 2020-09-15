import 'package:stream_radio_api/export_path.dart';

class DBDownLoadService {
  static Future<bool> isLocalDBAvailable() async {
    await DB.init();
    List<Map<String, dynamic>> _results = await DB.query(RadioModel.table);
    return _results.length == 0 ? false : true;
  }

  static Future<RadioAPIModel> fetchAllRadios() async {
    final serviceResponse =
        await WebService().getData(Config.api_URL, new RadioAPIModel());
    return serviceResponse;
  }

  static Future<List<RadioModel>> fetchLocalDB() async {
    if (!await isLocalDBAvailable()) {
      // HTTP call to fetch data
      RadioAPIModel radioAPIModel = await fetchAllRadios();

      if (radioAPIModel.data.length > 0) {
        await DB.init();

        // save in local DB
        radioAPIModel.data.forEach((element) {
          DB.insert(RadioModel.table, element);
        });
      }
    }

    List<Map<String, dynamic>> _results = await DB.query(RadioModel.table);
    List<RadioModel> radioModel = new List<RadioModel>();
    radioModel = _results.map((e) => RadioModel.fromMap(e)).toList();

    return radioModel;
  }
}
