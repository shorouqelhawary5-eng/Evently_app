import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/models/categories_model.dart';
import 'package:evently_app/models/event_model.dart';
import 'package:evently_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices {
  static Future<UserCredential> register({
    required String email,
    required String password,
  }) async {
    return await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  static CollectionReference<UserModel> getUserCollection() {
    return FirebaseFirestore.instance
        .collection("user")
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        );
  }

  static CollectionReference<EventModel> getEventCollection(
    BuildContext context,
  ) {
    return FirebaseFirestore.instance
        .collection("event")
        .withConverter<EventModel>(
          fromFirestore: (snapshot, _) =>
              EventModel.fromJson(snapshot.data()!, context),
          toFirestore: (event, _) => event.toJson(),
        );
  }

  static Future<void> addUserinFirebase(UserModel user) async {
    return getUserCollection().doc(user.id).set(user);
  }

  static Future<UserModel?> getUserFromFirebase(String uId) async {
    DocumentSnapshot<UserModel> snapshot = await getUserCollection()
        .doc(uId)
        .get();
    return snapshot.data();
  }

  // ---------------- EVENT SERVICES ----------------

  static Future<void> addEventToFirebase(
    EventModel event,
    BuildContext context,
  ) async {
    var eventCollection = getEventCollection(context);
    DocumentReference<EventModel> eventDocument = eventCollection.doc();
    event.id = eventDocument.id;
    return eventDocument.set(event);
  }

  static Stream<List<EventModel>> getEventFromFirebase(
    BuildContext context,
    CategoriesModel selectedCategory,
  ) {
    var eventCollection = getEventCollection(context);

    // إذا كانت الفئة المحددة هي "الكل" (id == '0') يجلب جميع الأحداث بدون where
    Query<EventModel> query = selectedCategory.id == '0'
        ? eventCollection.orderBy("dateAndTime")
        : eventCollection
              .where("categoryId", isEqualTo: selectedCategory.id)
              .orderBy("dateAndTime");

    return query.snapshots().map(
      (querySnapshot) => querySnapshot.docs.map((doc) => doc.data()).toList(),
    );
  }

  static Future<List<EventModel>> getFavoriteEventsFromFirebase(
    BuildContext context,
  ) async {
    final favoriteEventIds = UserModel.currentUser?.favoriteEventId ?? [];
    if (favoriteEventIds.isEmpty) {
      return [];
    }

    final snapshot = await getEventCollection(context).get();

    return snapshot.docs
        .map((document) => document.data())
        .where((event) => favoriteEventIds.contains(event.id))
        .toList();
  }

  static Future<void> addEventtoFavorite(EventModel event) async {
    UserModel currentUser = UserModel.currentUser!;
    currentUser.favoriteEventId.add(event.id);

    return FirebaseFirestore.instance
        .collection("user")
        .doc(currentUser.id)
        .update({
          'favoriteEventId': FieldValue.arrayUnion([event.id]),
        });
  }

  static Future<void> removeEventFromFavourite(EventModel event) async {
    UserModel currentUser = UserModel.currentUser!;
    currentUser.favoriteEventId.remove(event.id);

    return FirebaseFirestore.instance
        .collection("user")
        .doc(currentUser.id)
        .update({
          'favoriteEventId': FieldValue.arrayRemove([event.id]),
        });
  }

  static Future<void> editEvent(EventModel event, BuildContext context) {
    var collection = getEventCollection(context);
    return collection.doc(event.id).update(event.toJson());
  }

  static Future<void> deleteEvent(EventModel event, BuildContext context) {
    var collection = getEventCollection(context);
    return collection.doc(event.id).delete();
  }

  static Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        serverClientId:
            "295236827184-c77e00uf6simgt81bf5hdd9clafm0u7l.apps.googleusercontent.com",
      );

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      auth.UserCredential firebaseUser = await FirebaseAuth.instance
          .signInWithCredential(credential);

      UserModel finalUser = UserModel(
        id: firebaseUser.user!.uid,
        name: firebaseUser.user!.displayName ?? "",
        email: firebaseUser.user!.email ?? "",
        favoriteEventId: [],
      );
      await addUserinFirebase(finalUser);
    } catch (e) {
      rethrow;
    }
    return null;
  }
}
