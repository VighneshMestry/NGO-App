import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/event_model.dart';

final eventRepositoryProvider = Provider((ref) {
  return EventRepository();
});

class EventRepository {
  CollectionReference get eventCollection =>
      FirebaseFirestore.instance.collection('events');

  Future<int> getEventActivityCount(String activity) async {
    QuerySnapshot querySnapshot =
        await eventCollection.where("activity", isEqualTo: activity).get();
    return querySnapshot.size;
  }

  Future<void> addEvent(BuildContext context, Event event) async {
        QuerySnapshot querySnapshot =
        await eventCollection.where('eventName', isEqualTo: event.eventName).get();

    if (querySnapshot.docs.isNotEmpty) {
      throw Exception();
    } else {
      await eventCollection.doc(event.eventId).set(event.toMap());
    }
  }

    Stream<List<Event>> getEventListByActivity(String activity) {
    return eventCollection.where("activity", isEqualTo: activity).snapshots().map(
        (event) => event.docs
            .map((e) => Event.fromMap(e.data() as Map<String, dynamic>))
            .toList());
  }

}