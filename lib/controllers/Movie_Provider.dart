import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:movieapp/models/Movie.dart';
import 'package:movieapp/resources/URLResources.dart';
import 'package:http/http.dart' as http;

class MovieProvider with ChangeNotifier {
  List<Movie> allmoviedata=[];
  List<Movie> allmoviedSerchdata=[];
  bool isloading = false;

  movielist() async {
    final queryParameters = {'api_key': URLResources.apiKey};

    isloading = true;
    Uri url = Uri.parse(URLResources.movieUrl).replace(queryParameters: queryParameters);
    var response = await http.get(url);
    print("url :: $url");
    print("response :${response.request}");
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body.toString());
      allmoviedata = json["results"].map<Movie>((obj) => Movie.fromJson(obj)).toList();
      isloading = false;
      notifyListeners();
    } else {
      print("error");
    }
  }

  searchmovie(String _searchController) async{
    final queryParameters = {'api_key': URLResources.apiKey,
    'query':_searchController};
    Uri url = Uri.parse(URLResources.searchMovie).replace(queryParameters: queryParameters);
    var response = await http.get(url);
    print("url :: $url");
    print("response :${response.body}");
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body.toString());
      allmoviedSerchdata = json["results"].map<Movie>((obj) => Movie.fromJson(obj)).toList();
      isloading = false;
      notifyListeners();
    } else {
      print("error");
    }
  }
}
