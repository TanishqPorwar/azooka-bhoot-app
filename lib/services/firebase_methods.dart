import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseMethods {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final List<Map<String, dynamic>> map = [];

  Stream<User> authStateChanges() {
    return firebaseAuth.authStateChanges();
  }

  Future<void> signInAnonymously() async {
    try {
      UserCredential u = await firebaseAuth.signInAnonymously();
    } catch (e) {
      print(e);
    }
  }

  Stream<QuerySnapshot> getDataByApplication(String application) {
    return firestore
        .collection("fluorophores")
        .where("application", isEqualTo: application)
        .snapshots();
  }

  Stream<QuerySnapshot> getDataByQuery(String query) {
    if (query.length != 0)
      return firestore
          .collection("fluorophores")
          .where("search", arrayContains: query.toLowerCase())
          .snapshots();
    return firestore
        .collection("none")
        .where("name", isEqualTo: "")
        .snapshots();
  }
}
