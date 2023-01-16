import 'package:chat_app/database/database.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier{
  MyUser? user ;
  User? firebaseUser ;

  UserProvider(){
    firebaseUser =FirebaseAuth.instance.currentUser ;
    initMyUser();
  }
  void initMyUser()async{
    if(firebaseUser != null){
      user =await DataBaseUtils.readUser(firebaseUser?.uid ?? '');
    }

  }
}