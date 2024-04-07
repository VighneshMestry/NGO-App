// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ngo_app/features/news/controller/news_controller.dart';
import 'package:ngo_app/features/news/widgets/news_custom_card.dart';

class NewsScreen extends ConsumerStatefulWidget {
  final String activity;
  const NewsScreen({
    super.key,
    required this.activity,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewsScreenState();
}

class _NewsScreenState extends ConsumerState<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.activity),
        centerTitle: true,
      ),
      body: ref.watch(getNewsListByActivityProvider(widget.activity)).when(
            data: (newsListByActivity) {
              return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: newsListByActivity.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: NewsCustomCard(news: newsListByActivity[index]),
                  );
                },
              );
            },
            error: (error, stackTrace) => Text(error.toString()),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
    );
  }
}
