import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsmvc/constants/strings.dart';
import 'package:newsmvc/models/newsinfo.dart';

// ignore: camel_case_types
class API_Manager {
  Future<NewsModel> getNews() async {
    var client = http.Client();
    var newsModel;

    try {
      print("hi");
      var response = await http.get("https://newsapi.org/v2/top-headlines?country=in&category=sports&apiKey=dc9a30994bd5431488d9a5bab6644ffd");
      print("ress");
      if (response.statusCode == 200) {
        print('succ');
        var jsonString = response.body;
        print(response.body);
        var jsonMap = json.decode(jsonString);

        newsModel = NewsModel.fromJson(jsonMap);
      }
    } catch (Exception) {
      print("hh");
      return newsModel;
    }

    return newsModel;
  }
}