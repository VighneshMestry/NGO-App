class Event {
  final String eventName;
  final String eventId;
  final String activity;
  final String coverImage;
  final String venue;
  final String organisedBy;
  final String description;
  final String contactUs;
  Event({
    required this.eventName,
    required this.eventId,
    required this.activity,
    required this.coverImage,
    required this.venue,
    required this.organisedBy,
    required this.description,
    required this.contactUs,
  });

  Event copyWith({
    String? eventName,
    String? eventId,
    String? activity,
    String? coverImage,
    String? venue,
    String? organisedBy,
    String? description,
    String? contactUs,
  }) {
    return Event(
      eventName: eventName ?? this.eventName,
      eventId: eventId ?? this.eventId,
      activity: activity ?? this.activity,
      coverImage: coverImage ?? this.coverImage,
      venue: venue ?? this.venue,
      organisedBy: organisedBy ?? this.organisedBy,
      description: description ?? this.description,
      contactUs: contactUs ?? this.contactUs,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'eventName': eventName,
      'eventId': eventId,
      'activity': activity,
      'coverImage': coverImage,
      'venue': venue,
      'organisedBy': organisedBy,
      'description': description,
      'contactUs': contactUs,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      eventName: map['eventName'] as String,
      eventId: map['eventId'] as String,
      activity: map['activity'] as String,
      coverImage: map['coverImage'] as String,
      venue: map['venue'] as String,
      organisedBy: map['organisedBy'] as String,
      description: map['description'] as String,
      contactUs: map['contactUs'] as String,
    );
  }
}
