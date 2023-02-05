import 'dart:convert';
import 'package:covid/model/service/appurl.dart';
import 'package:http/http.dart' as http;
import '../covid_model.dart';

class ServicePlace {

  Future<CovidModel> getAll() async {
    final response = await http.get(Uri.parse(AppUrl.mainUrl));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200) {
      return CovidModel.fromJson(data);
    } else {
      throw Exception("Failed to load");
    }
  }

  Future<List<dynamic>> getCountry() async {
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesUrl));

    if(response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      return data;
    } else {
      throw Exception("Failed to load");
    }
  }

}