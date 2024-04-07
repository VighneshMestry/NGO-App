import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ngo_app/features/news/repository/news_repository.dart';
import 'package:ngo_app/models/news_model.dart';

final newsControllerProvider =
    StateNotifierProvider<NewsController, bool>((ref) {
  return NewsController(
      newsRepository: ref.watch(newsRepositoryProvider), ref: ref);
});

final getNewsListByActivityProvider = StreamProvider.family((ref, String activity) {
  return ref.watch(newsControllerProvider.notifier).getNewsListByActivity(activity);
});

class NewsController extends StateNotifier<bool> {
  final NewsRepository _newsRepository;
  final Ref _ref;
  NewsController({
    required NewsRepository newsRepository,
    required Ref ref,
  })  : _newsRepository = newsRepository,
        _ref = ref,
        super(false);

  Future<int> getNewsActivityCount(String activity) async {
    return await _newsRepository.getNgoActivityCount(activity);
  }

  void addNews(BuildContext context, NewsModel news) async {
    await _ref.read(newsRepositoryProvider).addNews(context, news);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("News posted successfully")));
  }

  Stream<List<NewsModel>> getNewsListByActivity(String activity) {
    return _newsRepository.getNewsListByActivity(activity);
  }
}
