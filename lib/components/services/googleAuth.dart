import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthentication {
  signInwithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await gUser?.authentication;
    // final credentials = GoogleAuthProvider.credential(
    //   accessTooken: googleAuth?.accessToken,
    //   idToken: googleAuth?.idToken,
    // );
    // return credentials;
  }
}
