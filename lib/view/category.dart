import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:news/models/categories_model.dart';

import '../view_model/views_news_model.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('MMMM dd,yyyy');
  String categoryName = 'General';
  List<String> btnCategories = [
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology'
  ];
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: btnCategories.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          categoryName = btnCategories[index];
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Container(
                            decoration: BoxDecoration(
                                color: categoryName == btnCategories[index]
                                    ? Colors.blue
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Center(
                                  child: Text(
                                btnCategories[index].toString(),
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white),
                              )),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: FutureBuilder<CatgoriesNewsModel>(
                  future: newsViewModel.fetchCategoryNewsApi(categoryName),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: SpinKitCircle(color: Colors.blue, size: 50));
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.articles!.length,
                          itemBuilder: (context, index) {
                            DateTime dateTime = DateTime.parse(snapshot
                                .data!.articles![index].publishedAt
                                .toString());
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    
                                    borderRadius: BorderRadius.circular(15),
                                    child:CachedNetworkImage(
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
                                      height: height * .18,
                                      width: width * .3,
                                      placeholder: (context, url) => Container(
                                        child: spinKit2,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error_outline,
                                              color: Colors.red),
                                    ),
                                  
                                  ),
                                  Expanded(child: 
                                  Container(
                                    height: height*.18,
                                    padding: EdgeInsets.only(left:15),
                                    child: Column(
                                      children: [
                                        Text(snapshot
                                          .data!.articles![index].title
                                          .toString(),
                                          maxLines: 3,
                                          style:TextStyle(
                                            fontSize: 15,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w700
                                          )
                                          ),
                                          IconButton(onPressed: ()
                                          {}, icon: Icon(Icons.bookmark_sharp)),
                                        Spacer(),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: 
                                              Text(snapshot.data!.articles![index].source!.name.toString(),
                                              style:TextStyle(fontSize: 15,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w600)
                                              
                                              ),
                                              ),
                                              //Icon(Icons.bookmark_sharp),
                                              // Text(format.format(dateTime),
                                              // maxLines: 3,
                                              // style:TextStyle(
                                              //                                           fontSize: 15,
                                              //                                           color: Colors.black54,
                                              //                                           fontWeight: FontWeight.w500
                                              // )
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
            ],
          ),
        ));
  }
}

const spinKit2 = SpinKitFadingCircle(
  color: Colors.amber,
  size: 50,
);
