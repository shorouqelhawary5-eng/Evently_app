import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/models/categories_model.dart';
import 'package:evently_app/models/event_model.dart';
import 'package:evently_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseServices {
  // ---------------- AUTH ----------------

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

  // ---------------- COLLECTIONS WITH CONVERTERS ----------------

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

  // ---------------- USER SERVICES ----------------

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

  // ---------------- FAVORITES (OPTIMIZED) ----------------

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

  // ---------------- EDIT & DELETE (FIXED) ----------------

  static Future<void> editEvent(EventModel event, BuildContext context) {
    var collection = getEventCollection(context);
    return collection.doc(event.id).update(event.toJson());
  }

  static Future<void> deleteEvent(EventModel event, BuildContext context) {
    var collection = getEventCollection(context);
    return collection.doc(event.id).delete();
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:evently_app/models/categories_model.dart';
// import 'package:evently_app/models/event_model.dart';
// import 'package:evently_app/models/user_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class FirebaseServices {
//   static Future<UserCredential> register({
//     required String email,
//     required String password,
//   }) async {
//     UserCredential userCredential = await FirebaseAuth.instance
//         .createUserWithEmailAndPassword(email: email, password: password);

//     return userCredential;
//   }

//   static Future<UserCredential> login({
//     required String email,
//     required String password,
//   }) async {
//     UserCredential userCredential = await FirebaseAuth.instance
//         .signInWithEmailAndPassword(email: email, password: password);
//     return userCredential;
//   }

//   static Future<void> logout() async {
//     await FirebaseAuth.instance.signOut();
//   }

//   static Future<void> addUserinFirebase(UserModel user) async {
//     FirebaseFirestore db = FirebaseFirestore.instance;
//     CollectionReference<UserModel> userCollection = db
//         .collection("user")
//         .withConverter(
//           fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
//           toFirestore: (user, _) => user.toJson(),
//         );
//     DocumentReference<UserModel> userDocument = userCollection.doc(user.id);
//     return userDocument.set(user);
//   }

//   static Future<UserModel?> getUserFromFirebase(String uId) async {
//     FirebaseFirestore db = FirebaseFirestore.instance;
//     CollectionReference<UserModel> userCollection = db
//         .collection("user")
//         .withConverter(
//           fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
//           toFirestore: (user, _) => user.toJson(),
//         );

//     DocumentReference<UserModel> userDocument = userCollection.doc(uId);
//     DocumentSnapshot<UserModel> snapshot = await userDocument.get();
//     return snapshot.data();
//   }

//   static Future<void> addEventToFirebase(
//     EventModel event,
//     BuildContext context,
//   ) async {
//     FirebaseFirestore db = FirebaseFirestore.instance;
//     CollectionReference<EventModel> eventCollection = db
//         .collection("event")
//         .withConverter(
//           fromFirestore: (snapshot, _) =>
//               EventModel.fromJson(snapshot.data()!, context),
//           toFirestore: (event, _) => event.toJson(),
//         );
//     DocumentReference<EventModel> eventDocument = eventCollection.doc();
//     event.id = eventDocument.id;
//     return eventDocument.set(event);
//   }

//   static Stream<List<EventModel>> getEventFromFirebase(
//     BuildContext context,
//     CategoriesModel selectedCategory,
//   ) async* {
//     FirebaseFirestore db = FirebaseFirestore.instance;
//     CollectionReference<EventModel> eventCollection = db
//         .collection("event")
//         .withConverter(
//           fromFirestore: (snapshot, _) =>
//               EventModel.fromJson(snapshot.data()!, context),
//           toFirestore: (event, _) => event.toJson(),
//         );
//     Stream<QuerySnapshot<EventModel>> snapshot = eventCollection
//         .where(
//           "categoryId",
//           isEqualTo: selectedCategory.id == '0' ? null : selectedCategory.id,
//         )
//         .orderBy("dateAndTime")
//         .snapshots();

//     Stream<List<EventModel>> events = snapshot.map(
//       (querySnapshot) => querySnapshot.docs
//           .map((documentSnapshot) => documentSnapshot.data())
//           .toList(),
//     );

//     yield* events;
//   }

//   static Future<List<EventModel>> getFavoriteEventsFromFirebase(
//     BuildContext context,
//   ) async {
//     final favoriteEventIds = UserModel.currentUser?.favoriteEventId ?? [];
//     if (favoriteEventIds.isEmpty) {
//       return [];
//     }

//     final snapshot = await FirebaseFirestore.instance
//         .collection("event")
//         .withConverter<EventModel>(
//           fromFirestore: (snapshot, _) =>
//               EventModel.fromJson(snapshot.data()!, context),
//           toFirestore: (event, _) => event.toJson(),
//         )
//         .get();

//     return snapshot.docs
//         .map((document) => document.data())
//         .where((event) => favoriteEventIds.contains(event.id))
//         .toList();
//   }

//   static CollectionReference<UserModel> getUserCollection() {
//     return FirebaseFirestore.instance
//         .collection("user")
//         .withConverter(
//           fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
//           toFirestore: (user, _) => user.toJson(),
//         );
//   }

//   static Future<void> addEventtoFavorite(EventModel event) async {
//     UserModel currentUser = UserModel.currentUser!;
//     currentUser.favoriteEventId.add(event.id);
//     CollectionReference<UserModel> userCollection = getUserCollection();
//     DocumentReference<UserModel> userDocument = userCollection.doc(
//       currentUser.id,
//     );
//     return userDocument.set(currentUser);
//   }

//   static Future<void> removeEventFromFavourite(EventModel event) {
//     UserModel currentUser = UserModel.currentUser!;
//     currentUser.favoriteEventId.remove(event.id);
//     CollectionReference<UserModel> userCollection = getUserCollection();
//     DocumentReference<UserModel> userDocument = userCollection.doc(
//       currentUser.id,
//     );
//     return userDocument.set(currentUser);
//   }

//   static Future<void> editEvent(EventModel event) {
//     var collection = getUserCollection();
//     var document = collection.doc(event.id);
//     return document.update(event.toJson());
//   }

//   static Future<void> deleteEvent(EventModel event) {
//     var collection = getUserCollection();
//     var document = collection.doc(event.id);
//     return document.delete();
//   }

// }
