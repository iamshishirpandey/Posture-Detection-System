import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class AuthenticationClient {
  static FirebaseUser presentUser;

  Future<Set<dynamic>> checkForCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool authSignedIn = prefs.getBool('auth') ?? false;
    bool isDetailsUploaded = prefs.getBool('details_uploaded') ?? false;

    final FirebaseUser user = await _auth.currentUser();

    presentUser = user;

    Set userDetailSet = {user, isDetailsUploaded};

    if (authSignedIn == true && user != null) {
      return userDetailSet;
    }

    return null;
  }

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(user.uid != null);
    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoUrl != null);

//Only Taking first part of name using substring

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();

    presentUser = currentUser;

    if (currentUser != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('auth', true);
      // authSignedIn = true;
      return user;
    }

    return null;
  }

  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
    await _auth.signOut();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('auth', false);

    print("User Sign Out");
  }
}

Future<String> getUid() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String uid = prefs.getString('uid');

  return uid;
}
