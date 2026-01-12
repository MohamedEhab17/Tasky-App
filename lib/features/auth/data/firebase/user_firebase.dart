import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasky_app/features/auth/data/model/user_model.dart';

class UserFirebase {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  UserFirebase({required this.firestore, required this.auth});

  CollectionReference<UserModel> getCollectionUser() {
    return firestore
        .collection('Users')
        .withConverter<UserModel>(
          fromFirestore: (user, _) => UserModel.fromJson(user.data()!),
          toFirestore: (user, _) => user.toJson(),
        );
  }

  Future<void> addUser(UserModel userModel) async {
    // Ensure we use the current authenticated user's ID
    String uid = auth.currentUser!.uid;
    userModel.uid = uid;
    await getCollectionUser().doc(uid).set(userModel);
  }

  Future<UserModel?> getUser() async {
    if (auth.currentUser == null) return null;
    final snapshot = await getCollectionUser().doc(auth.currentUser!.uid).get();
    return snapshot.data();
  }

  Future<void> updatePassword(String uid, String password) async {
    await getCollectionUser().doc(uid).update({'password': password});
  }
}
