import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper({required this.url});
  String url = "";
  Future getweather() async {
    http.Response res = await http.get(Uri.parse(url));
    var resData = res.body;
    if (res.statusCode == 200) {
      return jsonDecode(resData);
    } else {
      print(res.statusCode);
    }
  }
}
