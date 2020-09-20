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

  static Future<List<RadioModel>> fetchLocalDB(
      {String searchQuery = "", bool isFavoriteOnly = false}) async {
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
    String rawQuery = "";

    if (!isFavoriteOnly) {
      rawQuery =
          "select radios.id, radioName, radioURL, radioDesc, radioWebsite, radioPic, isFavourite "
          "from radios left join radios_bookmarks on radios_bookmarks.id = radios.id ";
      if (searchQuery.trim() != "") {
        rawQuery = rawQuery +
            " WHERE radioName LIKE '%$searchQuery%' OR radioDesc LIKE '%$searchQuery%'";
      }
    } else {
      rawQuery =
          "select radios.id, radioName, radioURL, radioDesc, radioWebsite, radioPic, isFavourite "
          "from radios left join radios_bookmarks on radios_bookmarks.id = radios.id "
          "where isFavourite = 1 ";
      if (searchQuery.trim() != "") {
        rawQuery = rawQuery +
            " and radioName LIKE '%$searchQuery%' OR radioDesc LIKE '%$searchQuery%'";
      }
    }

    List<Map<String, dynamic>> _results = await DB.rawQuery(rawQuery);

    List<RadioModel> radioModel = new List<RadioModel>();
    radioModel = _results.map((item) => RadioModel.fromMap(item)).toList();

    return radioModel;
  }
}
