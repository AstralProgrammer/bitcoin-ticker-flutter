import 'package:http/http.dart' as http;

class HttpHelper {
  Future<http.Response> get({domain, path, params}) async {
    var url = Uri.https(domain, path, params);
    print(url);
    return await http.get(url);
  }
}
