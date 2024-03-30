// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ngo_app/features/ngo/repository/ngo_repository.dart';
import 'package:ngo_app/models/ngo_model.dart';


final ngoControllerProvider = StateNotifierProvider<NgoController, bool>(
  (ref) => NgoController(
    ngoRepository: ref.watch(ngoRepositoryProvider),
    ref: ref,
  ),
);

class NgoController extends StateNotifier<bool> {
  final NgoRepository _ngoRepository;
  final Ref _ref;
  NgoController(
   {
    required NgoRepository ngoRepository,
    required Ref ref,
  })  : _ngoRepository = ngoRepository,
        _ref = ref, super(false);

  // Future<List<String>> getNgoActivityList() async{
  //   return await _ngoRepository.getNgoActivityList();
  // }

  void addNgo (BuildContext context, NGO ngo) {
    state = true;
    print(state);
    _ref.read(ngoRepositoryProvider).addNgo(context, ngo);
    state = false;
    print(state);
  }

  Future<int> getNgoActivityCount(String activity) async {
    return await _ngoRepository.getNgoActivityCount(activity);
  }
  
}
