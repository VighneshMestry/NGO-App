// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ngo_app/features/ngo/controller/ngo_controller.dart';
import 'package:ngo_app/features/widgets/custom_card.dart';

class NgoScreen extends ConsumerStatefulWidget {
  final String activity;
  const NgoScreen({
    super.key,
    required this.activity,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NgoScreenState();
}

class _NgoScreenState extends ConsumerState<NgoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.activity),
        centerTitle: true,
      ),
      body: ref.watch(getNgoListByActivityProvider(widget.activity)).when(
            data: (ngoListByActivity) {
              return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: ngoListByActivity.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CustomCard(ngo: ngoListByActivity[index]),
                  );
                },
              );
            },
            error: (error, stackTrace) => Text(error.toString()),
            loading: () => const CircularProgressIndicator(),
          ),
    );
  }
}
