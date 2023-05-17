import 'package:karima/core/services/firestore_user.dart';
import 'package:karima/helper/local_storage_data.dart';
import 'package:karima/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../views/home/control_view.dart';

class AuthViewModel extends GetxController {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? email, password, name, pic;

  final Rxn<User> _user = Rxn<User>();

  String? get user => _user.value?.email;

  final LocalStorageData localStorageData = Get.find();

  @override
  void onInit() {
    super.onInit();
    _user.bindStream(_auth.authStateChanges());
    if(_auth.currentUser != null){
      getCurrentUserData(_auth.currentUser!.uid);
    }
  }


  void googleSignInMethod() async {
    final GoogleSignInAccount googleUser = (await _googleSignIn.signIn())!;
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );

    await _auth.signInWithCredential(credential).then((user) {
      saveUser(user);
      Get.offAll(ControlView());
    });
  }

  void facebookSignInMethod() async {
    final AccessToken result = (await FacebookAuth.instance.login()) as AccessToken;

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(result.token);

    await _auth.signInWithCredential(facebookAuthCredential).then((user) {
      saveUser(user);
    });
  }

  void signInWithEmailAndPassword(String text, String ext) async {
    try {
      await _auth.signInWithEmailAndPassword(email: text, password: ext).then((value) async{
        getCurrentUserData(value.user!.uid);
      });
      Get.offAll(ControlView());
    } catch (e) {
      Get.snackbar(
        'Error login account',
        e.toString(),
        colorText: Colors.black,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void createAccountWithEmailAndPassword(email, password) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) async {
        saveUser(user);
      });

      Get.offAll(ControlView());
    } catch (e) {
      Get.snackbar(
        'Error creating account',
        e.toString(),
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void saveUser(UserCredential user) async {
    UserModel userModel = UserModel(
      userID: user.user!.uid,
      email: user.user!.email,
      name: name ?? user.user!.displayName ?? "User",
      fullName: "Testing user",
      pic: user.user!.photoURL ?? 'https://firebasestorage.googleapis.com/v0/b/karima-pfe.appspot.com/o/default-person.png?alt=media&token=eb571919-9149-4f4b-9015-7d07ec4e3507',
    );
    await FireStoreUser().addUserToFirestore(userModel);
    setUser(userModel);
  }

void getCurrentUserData(String uid) async{
  await FireStoreUser().getCurrentUser(uid).then((value) {
    setUser(UserModel.fromjson(value.data() as Map<dynamic, dynamic>?));
  });
}

  void setUser(UserModel userModel) async{
    await localStorageData.setUser(userModel);
  }
}


