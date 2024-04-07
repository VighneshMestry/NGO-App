import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ngo_app/features/events/repository/event_repository.dart';
import 'package:ngo_app/models/event_model.dart';

final eventControllerProvider = StateNotifierProvider<EventController, bool>(
  (ref) => EventController(
    eventRepository: ref.watch(eventRepositoryProvider),
    ref: ref,
  ),
);

final getEventListByActivityProvider = StreamProvider.family((ref, String activity) {
  return ref.watch(eventControllerProvider.notifier).getEventListByActivity(activity);
});

class EventController extends StateNotifier<bool> {
  final EventRepository _eventRepository;
  final Ref _ref;
  EventController({
    required EventRepository eventRepository,
    required Ref ref,
  })  : _eventRepository = eventRepository,
        _ref = ref,
        super(false);

  void addEvent(BuildContext context, Event event) async {
    try {
      await _ref.read(eventRepositoryProvider).addEvent(context, event);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Event registered successfully")));
    } on Exception {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Event with same name already exists")));
    } catch (e) {
      throw e.toString();
    }
  }

  Future<int> getEventActivityCount(String activity) async {
    return await _eventRepository.getEventActivityCount(activity);
  }

  Stream<List<Event>> getEventListByActivity(String activity) {
    return _eventRepository.getEventListByActivity(activity);
  }
}