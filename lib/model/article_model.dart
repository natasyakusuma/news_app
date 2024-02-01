import 'package:hive/hive.dart';

part 'article_model.g.dart';

@HiveType(typeId: 0)
class ArticleModel {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  String url;

  @HiveField(3)
  String urlToImage;

  ArticleModel({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
  });
}
