import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_film/dtos/user.dart';

class UserService {
  var db = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;

  Future<RLUser> createUser(
      String email, String username, String password) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    FirebaseAuth.instance.currentUser?.updateDisplayName(username);
    var doc = db.collection("users").doc(auth.currentUser?.uid);
    var user = RLUser(
        id: auth.currentUser!.uid.toString(),
        name: username,
        email: auth.currentUser!.email!,
        imagePath: auth.currentUser?.photoURL);
    await doc.set(user.toJson());
    return user;
  }


  Future<List<RLUser?>> findUser(String userSearchString) async {
    if(userSearchString == null){
      return [RLUser(id: "a", email: "email",name: "prova")];
    }
    var name = await db.collection("users").where("name", isEqualTo: userSearchString).get();
    var nameMap = name.docs.map((e) => RLUser.fromJson(e.data()));
    if(nameMap != null ){
      return nameMap.toList();
    }
    var email = await db.collection("users").where("email", isEqualTo: userSearchString).get();
    var emailMap = email.docs.map((e) => RLUser.fromJson(e.data()));
    if(emailMap != null ){
      return emailMap.toList();
    }

    return [null];
  }



}
