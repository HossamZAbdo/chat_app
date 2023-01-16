import 'package:chat_app/database/database.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:chat_app/register/register_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../firebase_errors.dart';

class RegisterViewModel extends ChangeNotifier{
  late RegisterNavigator navigator ;
  void registerFireBaseAuth(String email, String password , String firstName , String lastName , String userName)async{
    navigator.showLoading();
      try {
        final result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        MyUser user = MyUser(
            id: result.user?.uid??'',
            firstName: firstName,
            lastName: lastName,
            userName: userName,
            email: email
        );
        var task = DataBaseUtils.createUser(user);
        navigator.hideLoading();
        navigator.showMessage('Register Successfully');
        navigator.goToHome(user);
        print('id:${result.user?.uid}');
      } on FirebaseAuthException catch (e) {
        if (e.code == FirebaseErrors.weakPassword) {
          navigator.hideLoading();
          navigator.showMessage('The password provided is too weak.');
          print('The password provided is too weak.');
        } else if (e.code == FirebaseErrors.emailInUse) {
          navigator.hideLoading();
          navigator.showMessage('The account already exists for that email.');
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }

  }

}