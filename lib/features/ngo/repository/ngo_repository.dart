import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ngo_app/models/ngo_model.dart';

class NgoRepository {

  CollectionReference get ngo => FirebaseFirestore.instance.collection('yourCollection');  

  Stream<List<String>> getNgoActivityList() {
    return ngo.snapshots().map((event) {
      Set<String> uniqueActivities = {};
      for(var doc in event.docs) {
        NGO ngo = NGO.fromMap(doc.data() as Map<String, dynamic>);
        var activity = ngo.activity;
        if(!uniqueActivities.contains(activity)){
          uniqueActivities.add(activity);
        }
      }
      return uniqueActivities.toList();
    }); 
  }
}