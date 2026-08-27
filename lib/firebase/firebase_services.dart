import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/models/categories_model.dart';
import 'package:evently_app/models/event_model.dart';
import 'package:evently_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
    CollectionReference<UserModel> userCollection = db
        .collection("user")
        .withConverter(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        );
    DocumentReference<UserModel> userDocument = userCollection.doc(user.id);
    return userDocument.set(user);
  }

  static Future<UserModel?> getUserFromFirebase(String uId) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference<UserModel> userCollection = db
        .collection("user")
        .withConverter(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        );

    DocumentReference<UserModel> userDocument = userCollection.doc(uId);
    DocumentSnapshot<UserModel> snapshot = await userDocument.get();
    return snapshot.data();

    // final userDocument = await FirebaseFirestore.instance
    //     .collection("user")
    //     .doc(uId)
    //     .get();

    // final userData = userDocument.data();
    // if (!userDocument.exists || userData == null) {
    //   throw StateError('User document was not found for id: $uId');
    // }

    // final user = UserModel.fromJson(userData);
    // return user;
  }

  static Future<void> addEventToFirebase(
    EventModel event,
    BuildContext context,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference<EventModel> eventCollection = db
        .collection("event")
        .withConverter(
          fromFirestore: (snapshot, _) =>
              EventModel.fromJson(snapshot.data()!, context),
          toFirestore: (event, _) => event.toJson(),
        );
    DocumentReference<EventModel> eventDocument = eventCollection.doc();
    event.id = eventDocument.id;
    return eventDocument.set(event);
  }

  static Stream<List<EventModel>> getEventFromFirebase(
    BuildContext context,
    CategoriesModel selectedCategory,
  ) async* {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference<EventModel> eventCollection = db
        .collection("event")
        .withConverter(
          fromFirestore: (snapshot, _) =>
              EventModel.fromJson(snapshot.data()!, context),
          toFirestore: (event, _) => event.toJson(),
        );
    Stream<QuerySnapshot<EventModel>> snapshot = eventCollection
        .where(
          "categoryId",
          isEqualTo: selectedCategory.id == '0' ? null : selectedCategory.id,
        )
        .orderBy("dateAndTime")
        .snapshots();

    Stream<List<EventModel>> events = snapshot.map(
      (querySnapshot) => querySnapshot.docs
          .map((documentSnapshot) => documentSnapshot.data())
          .toList(),
    );

    yield* events;
  }

  static Future<List<EventModel>> getFavoriteEventsFromFirebase(
    BuildContext context,
  ) async {
    final favoriteEventIds = UserModel.currentUser?.favoriteEventId ?? [];
    if (favoriteEventIds.isEmpty) {
      return [];
    }

    final snapshot = await FirebaseFirestore.instance
        .collection("event")
        .withConverter<EventModel>(
          fromFirestore: (snapshot, _) =>
              EventModel.fromJson(snapshot.data()!, context),
          toFirestore: (event, _) => event.toJson(),
        )
        .get();

    return snapshot.docs
        .map((document) => document.data())
        .where((event) => favoriteEventIds.contains(event.id))
        .toList();
  }

  static CollectionReference<UserModel> getUserCollection() {
    return FirebaseFirestore.instance
        .collection("user")
        .withConverter(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        );
  }

  static Future<void> addEventtoFavorite(EventModel event) async {
    UserModel currentUser = UserModel.currentUser!;
    currentUser.favoriteEventId.add(event.id);
    CollectionReference<UserModel> userCollection = getUserCollection();
    DocumentReference<UserModel> userDocument = userCollection.doc(
      currentUser.id,
    );
    return userDocument.set(currentUser);
  }

  static Future<void> removeEventFromFavourite(EventModel event) {
    UserModel currentUser = UserModel.currentUser!;
    currentUser.favoriteEventId.remove(event.id);
    CollectionReference<UserModel> userCollection = getUserCollection();
    DocumentReference<UserModel> userDocument = userCollection.doc(
      currentUser.id,
    );
    return userDocument.set(currentUser);
  }
}
