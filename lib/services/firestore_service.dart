import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/UserModel.dart';

class FirestoreService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  late CollectionReference _userColletionreference;

  FirestoreService() {
    _userColletionreference = _firebaseFirestore.collection('Users');
  }
  Future<void> createNewUserEntry(//call after entering details
      {required uid, required UserModel user}) async {
    await _userColletionreference.doc(uid).set(user.toMap());
  }

  Future<UserModel> getUser({required uid}) async {
    DocumentSnapshot documentSnapshot =
        await _userColletionreference.doc(uid).get();
    return UserModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
  }

  Future<void> updateUser(
      {required String uid, required UserModel userModel}) async {
    _userColletionreference.doc(uid).update(userModel.toMap());
  }

  Future<bool> isUserPresent({required String uid}) async {
    DocumentSnapshot documentSnapshot =
        await _userColletionreference.doc(uid).get();
    return documentSnapshot.exists;
  }
  //TODO : implement function to get all users 
}
