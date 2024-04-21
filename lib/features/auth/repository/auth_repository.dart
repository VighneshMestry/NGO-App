import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../models/attendance_model.dart';
import '../../../models/user_model.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
    googleSignIn: GoogleSignIn(),
  ),
);

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
  })  : _auth = auth,
        _firestore = firestore,
        _googleSignIn = googleSignIn;

  CollectionReference get _users => _firestore.collection("users");

  CollectionReference get _attendance => _firestore.collection("attendance");

  Stream<User?> get authStateChange => _auth.authStateChanges();

  Future<UserModel> signInWithGoogle(bool isStaff) async {
    try {
      UserCredential userCredential;
      GoogleSignIn _googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      late UserModel? _userModel;

      final googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      userCredential = await _auth.signInWithCredential(credential);

      // UserModel userModel;

      if (userCredential.additionalUserInfo!.isNewUser) {
        _userModel = UserModel(
            name: userCredential.user!.displayName ?? "No Name",
            profilePic: userCredential.user!.photoURL!,
            uid: userCredential.user!.uid,
            isStaff: isStaff);
        await FirebaseFirestore.instance
            .collection("users")
            .doc(userCredential.user!.uid)
            .set(_userModel.toMap());
      } else {
        _userModel = await getUserData(userCredential.user!.uid).first;
      }
      return _userModel;
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  void logOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  Stream<UserModel> getUserData(String uid) {
    return _users.doc(uid).snapshots().map(
        (event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }

  Future<void> addAttendance(
      BuildContext context, Attendance attendance) async {
    // await _attendance.doc().set(date);
    await _attendance.add(attendance.toMap());
  }

  Stream<List<Attendance>> getAttendance(String uid) {
    return _attendance.where("uid", isEqualTo: uid).snapshots().map((event) => event
        .docs
        .map((e) => Attendance.fromMap(e.data() as Map<String, dynamic>))
        .toList());
  }
}
