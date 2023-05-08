import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:karima/model/user_model.dart';

class FireStoreUser{

  final CollectionReference _userCollectionRef = FirebaseFirestore.instance.collection('Users');

  

  Future<void> addUserToFirestore(UserModel userModel) async{
    return await _userCollectionRef.doc(userModel.userID).set(userModel.tojson());
    
  }

  Future<DocumentSnapshot> getCurrentUser (String uid) async{
    return await _userCollectionRef.doc(uid).get();
  }
}