// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ngo_app/features/events/controller/event_controller.dart';
import 'package:ngo_app/features/events/widgets/event_custom_card.dart';

class EventScreen extends ConsumerStatefulWidget {
  final String activity;
  const EventScreen({
    super.key,
    required this.activity,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EventScreenState();
}

class _EventScreenState extends ConsumerState<EventScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.activity),
        centerTitle: true,
      ),
      body: ref.watch(getEventListByActivityProvider(widget.activity)).when(
            data: (eventsListByActivity) {
              return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: eventsListByActivity.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: EventCustomCard(event: eventsListByActivity[index]),
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
