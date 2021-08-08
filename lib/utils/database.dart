import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:physiotherapy/authentication/auth_client.dart';
import 'package:physiotherapy/models/medicines.dart';
import 'package:physiotherapy/models/pose.dart';
import 'package:physiotherapy/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

/// The main Firestore collection.
final CollectionReference mainCollection =
    Firestore.instance.collection('physio');

final DocumentReference documentReference = mainCollection.document('test');

class Database {
  static User user;

  /// For storing user data on the database
  Future<User> storeUserData({
    String uid,
    String imageUrl,
    String userName,
    String gender,
  }) async {
    User userData;

    DocumentReference documentReferencer =
        documentReference.collection('users').document(uid);

    DocumentSnapshot userDocSnapshot = await documentReferencer.get();
    bool doesDocumentExist = userDocSnapshot.exists;
    print('User info exists: $doesDocumentExist');

    Map<String, dynamic> data = <String, dynamic>{
      "uid": uid,
      "imageUrl": imageUrl,
      "userName": userName,
      "gender": gender,
    };
    print('DATA:\n$data');

    userData = User.fromJson(data);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (doesDocumentExist) {
      await documentReferencer.updateData(data).whenComplete(() {
        print("User Info updated in the database");
        prefs.setBool('details_uploaded', true);
      }).catchError((e) => print(e));
    } else {
      await documentReferencer.setData(data).whenComplete(() {
        print("User Info added to the database");
        prefs.setBool('details_uploaded', true);
      }).catchError((e) => print(e));
    }

    return userData;
  }

  /// For storing user data on the database
  Future<User> placeOrder({
    String uid,
    String productName,
  }) async {
    User userData;

    DocumentReference documentReferencer =
        documentReference.collection('orders').document(uid);

    DocumentSnapshot userDocSnapshot = await documentReferencer.get();
    bool doesDocumentExist = userDocSnapshot.exists;
    print('User info exists: $doesDocumentExist');

    Map<String, dynamic> data = <String, dynamic>{
      "uid": uid,
      "product": productName
    };
    print('DATA:\n$data');

    userData = User.fromJson(data);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (doesDocumentExist) {
      await documentReferencer.updateData(data).whenComplete(() {
        print("Order updated in the database");
      }).catchError((e) => print(e));
    } else {
      await documentReferencer.setData(data).whenComplete(() {
        print("Order Info added to the database");
      }).catchError((e) => print(e));
    }
    ScaffoldMessenger.of(navigatorKey.currentContext).showSnackBar(SnackBar(
      content: Text("Order Placed Successfully!"),
    ));
  }

  /// For retrieving the user info from the database
  Future<User> retrieveUserInfo() async {
    String uid = AuthenticationClient.presentUser.uid;
    DocumentSnapshot userInfo =
        await documentReference.collection('users').document(uid).get();

    User userData = User.fromJson(userInfo.data);

    return userData;
  }

  /// For retrieving the poses from the database
  Future<List<Pose>> retrievePoses() async {
    QuerySnapshot posesQuery =
        await documentReference.collection('poses').getDocuments();

    List<Pose> poses = [];
    print(posesQuery.documents);
    posesQuery.documents.forEach((doc) {
      print(doc.data);
      poses.add(Pose.fromJson(doc.data));
    });
    print("POSE: ${poses}");
    return poses;
  }

  /// For retrieving the poses from the database
  retrieveMedications() async {
    String uid = AuthenticationClient.presentUser.uid;

    QuerySnapshot medicationQuery = await documentReference
        .collection('poses')
        .document(uid)
        .collection('medicines')
        .getDocuments();

    List<Medicines> medicines = [];

    medicationQuery.documents.forEach((doc) {
      medicines.add(Medicines.fromJson(doc.data));
    });
    print(medicines);
    return medicines;
  }

  uploadScore({
    String poseName,
    int stars,
    double accuracy,
    int timeInMilliseconds,
  }) async {
    String currentUid = AuthenticationClient.presentUser.uid;

    DocumentReference documentReferencer = documentReference
        .collection('user_info')
        .document(currentUid)
        .collection('score')
        .document(poseName);

    Map<String, dynamic> scoreData = <String, dynamic>{
      "stars": stars,
      "accuracy": accuracy,
      "time": timeInMilliseconds,
    };
    print('DATA:\n$scoreData');

    await documentReferencer.setData(scoreData).whenComplete(() {
      print("Score added to the database!");
    }).catchError((e) => print(e));

    QuerySnapshot scoreDocs = await documentReference
        .collection('user_info')
        .document(currentUid)
        .collection('score')
        .getDocuments();

    int totalStars = 0;
    double totalAcuracy = 0.0;
    int totalTimeInMilliseconds = 0;

    scoreDocs.documents.forEach((doc) {
      totalStars += doc.data['stars'];
      totalAcuracy = totalAcuracy == 0.0
          ? doc.data['accuracy']
          : double.parse(
              ((totalAcuracy + doc.data['accuracy']) / 2).toStringAsFixed(3));
      // totalAcuracy = doc.data['accuracy'];
      totalTimeInMilliseconds += doc.data['time'];
    });

    DocumentReference userReferencer =
        documentReference.collection('user_info').document(currentUid);

    Map<String, dynamic> totalScoreData = <String, dynamic>{
      "stars": totalStars,
      "accuracy": totalAcuracy,
      "time": FieldValue.increment(totalTimeInMilliseconds),
    };

    await userReferencer.updateData(totalScoreData).whenComplete(() {
      print('User total score updated!');
    }).catchError((e) => print(e));
  }
}
