//used to fetch api data
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/models/categories_model.dart';
import 'package:news/models/news_channel_headline_model.dart';

class NewsRepository {
  Future<NewsChannelHeadlineModel> fetchNewChannelHeadlineApi() async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=6deca060abe040c7a1878d55394cc20c';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelHeadlineModel.fromJson(body);
    }
    throw Exception('error');
  }

  Future<CatgoriesNewsModel> fetchCategoryNewsApi(String category) async {
    String url =
        'https://newsapi.org/v2/everything?q=${category}&apiKey=6deca060abe040c7a1878d55394cc20c';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CatgoriesNewsModel.fromJson(body);
    }
    throw Exception('error');
  }
}
