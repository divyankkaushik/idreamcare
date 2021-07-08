import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:idreamcare/feature/authentication/screens/phoneauth/models/users.dart';

class FirebaseRepository {
  FirebaseFirestore repository = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future setData(String? number) async {
    String uid = firebaseAuth.currentUser!.uid.toString();
    await repository.collection("Users").doc(uid).set({
      "phoneNumber": number,
      "Uid": uid,
    });
  }

  Future fetchData() async {
    try {
      var queryDocuments = await repository.collection("Users").get();
      if (queryDocuments.docs.isNotEmpty) {
        return queryDocuments.docs.map((snapshot) {
          return snapshot.data();
        }).toList();
      }
    } catch (e) {
      print(e);
    }
  }

  // Future fetchAllUsers(User currentUser) async {
  //   List<AppUser> userList = <AppUser>[];

  //   QuerySnapshot querySnapshot = await repository.collection("Users").get();
  //   for (var i = 0; i < querySnapshot.docs.length; i++) {
  //     if (querySnapshot.docs[i].id != currentUser.uid) {
  //       userList.add(AppUser.fromMap(querySnapshot.docs[i].data()));
  //       print(querySnapshot.docs[i].data());
  //     }
  //   }
  //   return userList;
  // }
}
