import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:news_app/model/article_model.dart';

class FavoritesController extends GetxController{
  final RxList<ArticleModel> favorites = <ArticleModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  Future<void> loadFavorites()async {
    final box = await Hive.openBox('favorites');
    favorites.assignAll(box.values.toList().cast<ArticleModel>());
  }

  Future<void>addFavorite(ArticleModel article) async{
    final box = await Hive.openBox('favorites');
    if (!favorites.contains(article)){
      favorites.add(article);
      await box.add(article);
    }
  }
}