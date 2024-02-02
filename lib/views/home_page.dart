import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controller/favorite_controller.dart';
import '../data_source/news_data.dart';

class HomePage extends StatelessWidget {
  final News news = News(); // Instantiate your News class

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('BSI News'),
          centerTitle: true,
          bottom: const TabBar(tabs: <Widget>[
            Tab(
              text: 'News',
            ),
            Tab(
              text: 'Favourite',
            )
          ]),
        ),
        body: TabBarView(
          children: [
            buildNewsTab(),
            buildFavoritesTab(),
          ],
        ),
      ),
    );
  }

  //NewsTab Content
  Widget buildNewsTab() {
    return FutureBuilder<void>(
      future: news.getNews(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error fetching news: ${snapshot.error}'));
        } else {
          // Use the fetched news data to build your UI
          return ListView.builder(
            itemCount: news.dataSave.length,
            itemBuilder: (context, index) {
              var article = news.dataSave[index];
              print('CEK TITLE : ${article.title}');
              return Card(
                child: ListTile(
                  onTap: () {
                    print('MASUK FUNGSI LAUNCH ${_launchUrl}');
                    _launchUrl(
                        Uri.parse(article.url ?? '')
                    );
                  },
                  title: Image.network(
                    article.urlToImage,
                    height: 200,
                  ),
                  subtitle: Text(article.title),

                  trailing: IconButton(
                    icon: Icon(
                      // article.isFavorites
                      //     ? Icons.favorite
                      //     : Icons.favorite_border,
                      Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      // article.isFavorites = !article.isFavorites;
                      // Get.forceAppUpdate();
                    },
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }


  // Favorites Tab Content
  Widget buildFavoritesTab() {
    return GetBuilder<FavoritesController>(
      builder: (controller) {
        return ListView.builder(
          itemCount: controller.favorites.length,
          itemBuilder: (context, index) {
            var favorite = controller.favorites[index];
            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                title: Text(favorite.title),
                subtitle: Text(favorite.description),
                // Add more widgets to display other article details
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _launchUrl(Uri url) async {
    print('URL SUDAH MASUK ${url}');
    if (!await launchUrl(url)){
      throw Exception('Could not launch');
    }
  }
}

