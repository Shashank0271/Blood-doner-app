import 'package:blood_doner/app/app.logger.dart';
import 'package:blood_doner/services/firestore_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
        _isuserSignedin = false;
        _log.v("user is currently signed out !");
      } else {
        _isuserSignedin = true;
        _firebaseUser = user;
        _log.v("user is currently signed in !");
        populateUser(
            userId: user.uid); //executed whenever user is authenticated
      }
    });
  }

  Future<void> signUpWithEmail({
    @required email,
    @required password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
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

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    _navigationService.clearStackAndShow(Routes.loginView);
  }

  Future populateUser({required String userId}) async {
    try {
      if (await _firestoreService.isUserPresent(uid: userId)) {
        _user = await _firestoreService.getUser(uid: userId);
        _navigationService.clearStackAndShow(Routes.myPageView);
      } else {
        _navigationService.clearStackAndShow(Routes.completeProfileView);
      }
    } catch (e) {
      _log.e(e);
    }
  }
}
