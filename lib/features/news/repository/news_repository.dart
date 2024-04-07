import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ngo_app/models/news_model.dart';

final newsRepositoryProvider = Provider((ref) {
  return NewsRepository();
});

class NewsRepository {
  CollectionReference get newsCollection =>
      FirebaseFirestore.instance.collection('news');

  Future<int> getNgoActivityCount(String activity) async {
    QuerySnapshot querySnapshot =
        await newsCollection.where("activity", isEqualTo: activity).get();
    return querySnapshot.size;
  }

  Future<void> addNews(BuildContext context, NewsModel news) async {
    await newsCollection.doc(news.newsId).set(news.toMap());
  }

    Stream<List<NewsModel>> getNewsListByActivity(String activity) {
    return newsCollection.where("activity", isEqualTo: activity).snapshots().map(
        (event) => event.docs
            .map((e) => NewsModel.fromMap(e.data() as Map<String, dynamic>))
            .toList());
  }

}
