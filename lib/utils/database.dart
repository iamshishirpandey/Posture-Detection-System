import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:physiotherapy/authentication/auth_client.dart';
import 'package:physiotherapy/models/medicines.dart';
import 'package:physiotherapy/models/pose.dart';
import 'package:physiotherapy/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
}
