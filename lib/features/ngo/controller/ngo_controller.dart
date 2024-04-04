// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/ngo_model.dart';
import '../repository/ngo_repository.dart';

final ngoControllerProvider = StateNotifierProvider<NgoController, bool>(
  (ref) => NgoController(
    ngoRepository: ref.watch(ngoRepositoryProvider),
    ref: ref,
  ),
);

final getNgoListByActivityProvider = StreamProvider.family((ref, String activity) {
  return ref.watch(ngoControllerProvider.notifier).getNgoListByActivity(activity);
});

class NgoController extends StateNotifier<bool> {
  final NgoRepository _ngoRepository;
  final Ref _ref;
  NgoController({
    required NgoRepository ngoRepository,
    required Ref ref,
  })  : _ngoRepository = ngoRepository,
        _ref = ref,
        super(false);

  void addNgo(BuildContext context, NGO ngo) async {
    try {
      await _ref.read(ngoRepositoryProvider).addNgo(context, ngo);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("NGO registered successfully")));
    } on Exception {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("NGO with same name already exists")));
    } catch (e) {
      throw e.toString();
    }
  }

  Future<int> getNgoActivityCount(String activity) async {
    return await _ngoRepository.getNgoActivityCount(activity);
  }

  void uploadImage(BuildContext context, File coverImage, String name) async {
    await _ngoRepository.uploadImage(context, coverImage, name);
  }

  Future<String> getDownloadURL(String name) async {
    return await _ngoRepository.getPdfDownloadUrl(name);
  }

  Stream<List<NGO>> getNgoListByActivity(String activity) {
    return _ngoRepository.getNgoListByActivity(activity);
  }
}
