// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/news_model.dart';
import 'news_more_info_card.dart';

class NewsCustomCard extends ConsumerStatefulWidget {
  final NewsModel news;
  const NewsCustomCard({super.key, 
    required this.news,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewsCustomCardState();
}

class _NewsCustomCardState extends ConsumerState<NewsCustomCard> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade400),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade50,
            spreadRadius: 4,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              widget.news.coverImage,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 180,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 5),
                    const Icon(Icons.newspaper),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: Text(
                        widget.news.headLine,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const SizedBox(width: 5),
                    const Icon(Icons.textsms_outlined),
                    const SizedBox(width: 14),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: Text(widget.news.news),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const SizedBox(width: 5),
                    const Icon(Icons.man),
                    const SizedBox(width: 14),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: Text(widget.news.journalist,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const SizedBox(width: 5),
                    const Icon(Icons.phone),
                    const SizedBox(width: 3),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => NewsMoreInfoCard(news: widget.news))
                          );
                        },
                        child: Text(
                          "Contact Us",
                          style: TextStyle(
                              color: Colors.blue.shade800,
                              fontWeight: FontWeight.w600),
                        )),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}