class NewsModel {
  final String headLine;
  final String newsId;
  final String activity;
  final String coverImage;
  final String news;
  final String journalist;
  final String newsDescription;
  final String contactUs;
  NewsModel({
    required this.headLine,
    required this.newsId,
    required this.activity,
    required this.coverImage,
    required this.news,
    required this.journalist,
    required this.newsDescription,
    required this.contactUs,
  });

  NewsModel copyWith({
    String? headLine,
    String? newsId,
    String? activity,
    String? coverImage,
    String? news,
    String? journalist,
    String? newsDescription,
    String? contactUs,
  }) {
    return NewsModel(
      headLine: headLine ?? this.headLine,
      newsId: newsId ?? this.newsId,
      activity: activity ?? this.activity,
      coverImage: coverImage ?? this.coverImage,
      news: news ?? this.news,
      journalist: journalist ?? this.journalist,
      newsDescription: newsDescription ?? this.newsDescription,
      contactUs: contactUs ?? this.contactUs,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'headLine': headLine,
      'newsId': newsId,
      'activity': activity,
      'coverImage': coverImage,
      'news': news,
      'journalist': journalist,
      'newsDescription': newsDescription,
      'contactUs': contactUs,
    };
  }

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      headLine: map['headLine'] as String,
      newsId: map['newsId'] as String,
      activity: map['activity'] as String,
      coverImage: map['coverImage'] as String,
      news: map['news'] as String,
      journalist: map['journalist'] as String,
      newsDescription: map['newsDescription'] as String,
      contactUs: map['contactUs'] as String,
    );
  }
}
