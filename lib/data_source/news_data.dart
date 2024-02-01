import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/article_model.dart';

class News {
  List<ArticleModel> dataSave = [];

  Future<void> getNews() async {
    try {
      final response = await http.get(
          'https://newsapi.org/v2/everything?q=keyword&apiKey=4b397c0b925c48649a61b00c6ab69622' as Uri);
      var jsonData = jsonDecode(response.body);

      if (jsonData['status'] == 'ok') {
        jsonData['articles'].forEach((element) {
          if (element['urlToImage'] != null && element['description'] != null) {
            //initialize model
            ArticleModel articleModel = ArticleModel(
              title: element['title'],
              urlToImage: element['urlToImage'],
              description: element['description'],
              url: element['url'],
            );

            dataSave.add(articleModel);
          }
        });
      }
    } catch (error) {
      // Handle errors here, for example, print the error message
      print('ERROR AT FETCHING: $error');
    }
  }

}
