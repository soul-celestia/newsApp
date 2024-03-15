import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:news/bookmark.dart';
import 'package:news/models/news_channel_headline_model.dart';
import 'package:news/view/category.dart';
import 'package:news/view/news_detail.dart';
import 'package:news/view_model/views_news_model.dart';

import '../models/categories_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList { bbcNews, aryNews, independent, reuters, cnn, alJazeera }

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  FilterList? selectedmenu;
  final format = DateFormat('MMMM dd, yyyy');
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CategoryScreen()));
              },
              icon: Image.asset(
                'images/category_icon.png',
                height: 30,
                width: 30,
              )),
          title: Text("News",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24)),
          actions: [
            PopupMenuButton<FilterList>(
                initialValue: selectedmenu,
                icon: Icon(Icons.more_vert, color: Colors.black),
                onSelected: (FilterList item) {},
                itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
                      PopupMenuItem<FilterList>(
                          value: FilterList.bbcNews, child: Text('BBC News')),
                      PopupMenuItem<FilterList>(
                          value: FilterList.aryNews, child: Text('Ary News')),
                      PopupMenuItem<FilterList>(
                          value: FilterList.independent,
                          child: Text('Independent')),
                      PopupMenuItem<FilterList>(
                          value: FilterList.reuters, child: Text('Reuters')),
                      PopupMenuItem<FilterList>(
                          value: FilterList.cnn, child: Text('CNN')),
                      PopupMenuItem<FilterList>(
                          value: FilterList.alJazeera,
                          child: Text('Al-Jazeera')),
                    ])
          ],
          elevation: 0.0,
        ),
        body: ListView(
          children: [
            SizedBox(
              height: height * .55,
              width: width,
              child: FutureBuilder<NewsChannelHeadlineModel>(
                future: newsViewModel.fetchNewChannelHeadlineApi(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: SpinKitCircle(color: Colors.blue, size: 50));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.articles!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        DateTime dateTime = DateTime.parse(snapshot
                            .data!.articles![index].publishedAt
                            .toString());
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewsDetailScreen(
                                        newsImage: snapshot
                                            .data!.articles![index].urlToImage
                                            .toString(),
                                        newsTitle: snapshot.data!.articles![index].title
                                            .toString(),
                                        newsDate: snapshot
                                            .data!.articles![index].publishedAt
                                            .toString(),
                                        newsAuthor: snapshot
                                            .data!.articles![index].publishedAt
                                            .toString(),
                                        newsDesc: snapshot.data!.articles![index].author
                                            .toString(),
                                        newsContent: snapshot
                                            .data!.articles![index].description
                                            .toString(),
                                        newsSource: snapshot.data!.articles![index].source.toString())));
                          },
                          child: SizedBox(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: height * 0.6,
                                  width: width * .9,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: height * .02),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Container(
                                        child: spinKit2,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error_outline,
                                              color: Colors.red),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 20,
                                  child: Card(
                                    elevation: 5,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Container(
                                      alignment: Alignment.bottomCenter,
                                      padding: const EdgeInsets.all(15),
                                      height: height * .22,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: width * 0.7,
                                            child: Text(
                                                snapshot.data!.articles![index]
                                                    .title
                                                    .toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                          ),
                                          const Spacer(),
                                          SizedBox(
                                            width: width * 0.7,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      snapshot
                                                          .data!
                                                          .articles![index]
                                                          .source!
                                                          .name
                                                          .toString(),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                  Text(format.format(dateTime),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                ]),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Expanded(
                child: FutureBuilder<CatgoriesNewsModel>(
                  future: newsViewModel.fetchCategoryNewsApi('General'),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: SpinKitCircle(color: Colors.blue, size: 50));
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.articles!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            DateTime dateTime = DateTime.parse(snapshot
                                .data!.articles![index].publishedAt
                                .toString());
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => NewsDetailScreen(
                                                  newsImage: snapshot
                                                      .data!
                                                      .articles![index]
                                                      .urlToImage
                                                      .toString(),
                                                  newsTitle: snapshot.data!
                                                      .articles![index].title
                                                      .toString(),
                                                  newsDate: snapshot
                                                      .data!
                                                      .articles![index]
                                                      .publishedAt
                                                      .toString(),
                                                  newsAuthor: snapshot
                                                      .data!
                                                      .articles![index]
                                                      .publishedAt
                                                      .toString(),
                                                  newsDesc: snapshot.data!
                                                      .articles![index].author
                                                      .toString(),
                                                  newsContent:
                                                      snapshot.data!.articles![index].description.toString(),
                                                  newsSource: snapshot.data!.articles![index].source.toString())));
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                        imageUrl: snapshot
                                            .data!.articles![index].urlToImage
                                            .toString(),
                                        fit: BoxFit.cover,
                                        height: height * .18,
                                        width: width * .3,
                                        placeholder: (context, url) =>
                                            Container(
                                          child: spinKit2,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error_outline,
                                                color: Colors.red),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                    height: height * .18,
                                    padding: EdgeInsets.only(left: 15),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Text(
                                              snapshot
                                                  .data!.articles![index].title
                                                  .toString(),
                                              maxLines: 3,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w700)),
                                        ),
                                        Spacer(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                snapshot.data!.articles![index]
                                                    .source!.name
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black54,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            IconButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              BookMark()));
                                                },
                                                icon:
                                                    Icon(Icons.bookmark_sharp)),
                                            // Expanded(
                                            //   child: Text(format.format(dateTime),
                                            //       maxLines: 3,
                                            //       style: TextStyle(
                                            //           fontSize: 15,
                                            //           color: Colors.black54,
                                            //           fontWeight:
                                            //               FontWeight.w500)),
                                            // ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            );
                          });
                    }
                  },
                ),
              ),
            ),
          ],
        ));
  }
}

const spinKit2 = SpinKitFadingCircle(
  color: Colors.amber,
  size: 50,
);
