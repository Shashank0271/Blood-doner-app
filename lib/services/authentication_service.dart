import 'package:blood_doner/app/app.logger.dart';
import 'package:blood_doner/services/firestore_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:stacked_services/stacked_services.dart';
import '../app/app.locator.dart';
import '../app/app.router.dart';
import '../models/UserModel.dart';

class AuthenticationService {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Logger _log = getLogger('AuthenticationService');
  late bool _isuserSignedin;
  User? _firebaseUser;
  UserModel? _user;
  User? get firebaseUser => _firebaseUser;
  UserModel? get user => _user;
  bool get isUserSignedIn => _isuserSignedin;

  AuthenticationService() {
    _firebaseAuth.authStateChanges().listen((User? user) async {
      if (user == null) {
        _user = null;
        _isuserSignedin = false;
        _log.i("user is currently signed out !");
      } else {
        _isuserSignedin = true;
        _firebaseUser = user;
        _log.i("user is currently signed in !");
        populateUser(
            userId: user.uid); //executed whenever user is authenticated
      }
    });
  }

  Future<void> signUpWithEmail({
    @required name,
    @required email,
    @required password,
    @required age,
    @required bloodGroup,
    @required role,
    @required imageUrl,
    @required imageFileName,
  }) async {
    //TODO : add check for valid email id
    try {
      _user = UserModel(
        userName: name,
        email: email,
        age: age,
        bloodGroup: bloodGroup,
        role: role,
        imageFileName: imageFileName,
        imageUrl: imageUrl,
      );

      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _firestoreService.createNewUserEntry(
          uid: _firebaseUser!.uid, user: _user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _snackbarService.showSnackbar(message: 'password is too weak');
      } else if (e.code == 'email-already-in-use') {
        _snackbarService.showSnackbar(
            message: 'The email account already exists');
      }
    } catch (e) {
      _log.e(e);
    }
  }

  Future<void> loginWithEmail({@required email, @required password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _log.e('No user found for that email.');
        _snackbarService.showSnackbar(message: 'Email not registered .Sign up');
        rethrow;
      } else if (e.code == 'wrong-password') {
        _log.e('Wrong password provided for that user.');
        _snackbarService.showSnackbar(message: 'Wrong password.');
        rethrow;
      }
      rethrow;
    } catch (e) {
      _log.e(e);
    }
  }

  // Future<void> signInWithGoogle() async {
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //   final GoogleSignInAuthentication? googleAuth =
  //       await googleUser?.authentication;

  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );

  //   UserCredential _credential =
  //       await FirebaseAuth.instance.signInWithCredential(credential);
  //   populateUser(
  //       userId: _firebaseUser!.uid, userName: _credential.user!.displayName);
  // }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    _navigationService.clearStackAndShow(Routes.loginView);
  }

  Future<void> populateUser({@required userId}) async {
    _user = await _firestoreService.getUser(uid: userId);
  }
}
