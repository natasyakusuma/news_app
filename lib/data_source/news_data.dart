import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/article_model.dart';

class News {
  List<ArticleModel> dataSave = [];

  Future<void> getNews() async {
    try {
      final response = await http.get(
          Uri.parse('https://newsapi.org/v2/everything?q=keyword&apiKey=383663fb7fb743f490f785addecc7869'));
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
