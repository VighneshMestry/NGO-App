// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utilities/utils.dart';
import '../../../models/event_model.dart';

class EventMoreInfoCard extends ConsumerWidget {
  final Event event;
  const EventMoreInfoCard({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        child: SizedBox(
          // height: 200,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.4,
                    child: Text(
                      event.eventName,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(event.coverImage),
                  ),
                  const SizedBox(height: 20),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 5),
                            const Icon(Icons.location_pin),
                            const SizedBox(width: 14),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.4,
                              child: Text(event.venue),
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
                              width: MediaQuery.of(context).size.width / 1.4,
                              child: Text(event.organisedBy,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
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
                                  makePhoneCall(event.contactUs);
                                },
                                child: Text(
                                  "Contact Us",
                                  style: TextStyle(
                                      color: Colors.blue.shade800,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16),
                                )),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          event.description,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 17),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
