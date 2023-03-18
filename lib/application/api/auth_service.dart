import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  signInWithgoogle() async {
    //interactive sign in process
    final GoogleSignInAccount? googleSignInAccount =
        await GoogleSignIn().signIn();

    //obtain auth credentials from request
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    //create new credentials for user
    final credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    //finally use credentials to sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
