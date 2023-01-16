import 'package:chat_app/database/database.dart';
import 'package:chat_app/firebase_errors.dart';
import 'package:chat_app/login/login_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier{
  late LoginNavigator navigator ;
  void loginFireBaseAuth(String email ,String password)async{
    navigator.showLoading();
    try {
      final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      var useObj = DataBaseUtils.readUser(result.user?.uid??'');
      if(useObj == null){
        navigator.hideLoading();
        navigator.showMessage('Login with failed try again');
      }else{
        navigator.hideLoading();
        navigator.showMessage('Login Successfully');
        navigator.navigatorToHome();
      }
      print('id:${result.user?.uid}');
    } on FirebaseAuthException catch (e) {
      if (e.code ==FirebaseErrors.userNotFound) {
        navigator.hideLoading();
        navigator.showMessage('No user found for that email.');
        print('No user found for that email.');
      } else if (e.code == FirebaseErrors.wrongPassword) {
        navigator.hideLoading();
        navigator.showMessage('Wrong password provided for that user.');
        print('Wrong password provided for that user.');
      }
    }
}
}