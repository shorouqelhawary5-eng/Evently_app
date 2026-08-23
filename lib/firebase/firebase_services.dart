import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  static Future<UserCredential> register({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    return userCredential;
  }

  static Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<void> addUserinFirebase(UserModel user) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference<Map<String, dynamic>> userCollection = db.collection(
      'user',
    );
    DocumentReference<Map<String, dynamic>> userDocument = userCollection.doc(
      user.id,
    );
    return userDocument.set({
      'id': user.id,
      'name': user.name,
      'email': user.email,
    });
  }

  static Future<UserModel> getUserFromFirebase(String uId) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference<Map<String, dynamic>> userCollection = db.collection(
      'user',
    );
    DocumentReference<Map<String, dynamic>> userDocument = userCollection.doc(
      uId,
    );
    DocumentSnapshot documentSnapShot = await userDocument.get();
    Map<String, dynamic> userJson =
        documentSnapShot.data() as Map<String, dynamic>;
    return UserModel(
      id: userJson['id'],
      name: userJson['name'],
      email: userJson['email'],
    );
  }
}
