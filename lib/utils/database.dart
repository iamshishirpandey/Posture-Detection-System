import 'package:cloud_firestore/cloud_firestore.dart';
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
}
