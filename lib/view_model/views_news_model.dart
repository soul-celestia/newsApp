import 'package:news/models/categories_model.dart';
import 'package:news/models/news_channel_headline_model.dart';
import 'package:news/repository/news_repository.dart';

class NewsViewModel {
  final _rep = NewsRepository();
  Future<NewsChannelHeadlineModel> fetchNewChannelHeadlineApi() async {
    final response = await _rep.fetchNewChannelHeadlineApi();
    return response;
  }
  Future<CatgoriesNewsModel> fetchCategoryNewsApi(String category) async {
    final response = await _rep.fetchCategoryNewsApi(category);
    return response;
  }
}
