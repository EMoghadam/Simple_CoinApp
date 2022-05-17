import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClass {
  late String url =
      "https://rest.coinapi.io/v1/exchangerate/$oneParameter/$twoParameter?apikey=$Apikey";
  String Apikey = "5EE2E38D-A179-49A8-94C5-6F49A10465EB";
  late String ?oneParameter;
  late String ?twoParameter;

  Future getResultChange(
      {required String oneParameter, required String twoParameter}) async {
    this.oneParameter = oneParameter;
    this.twoParameter = twoParameter;
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      print("================>>>>>>>>>${oneParameter}");
      print("================>>>>>>>>>${twoParameter}");
      print("================>>>>>>>>>${data["rate"]}");

      return data["rate"];

    } else {
      print("================>>>>>>>>>${response.statusCode}");
    }
  }
}
