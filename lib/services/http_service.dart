import 'package:http/http.dart' as http;

class HttpService {
  static Future<dynamic> get(String url, Map<String, String> params) async {
    String queryString = Uri(queryParameters: params).query;
    var response = await http.get(url + '?' + queryString);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }
}
