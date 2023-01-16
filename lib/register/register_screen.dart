import 'dart:async';

import 'package:chat_app/firebase_errors.dart';
import 'package:chat_app/home/home_screen.dart';
import 'package:chat_app/login/login_screen.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:chat_app/register/register_navigator.dart';
import 'package:chat_app/register/register_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/utils.dart'as Utils;

class RegisterScreen extends StatefulWidget {
  static String routeName = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}


class _RegisterScreenState extends State<RegisterScreen>implements RegisterNavigator {
  String firstName = '';
  String lastName = '';
  String email = '';
  String password = '';
  String userName = '';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RegisterViewModel viewModel = RegisterViewModel();
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this ;
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>viewModel,
      child: Stack(
        children: [
          Container(
            color: Colors.white,
            child: Image.asset(
              'assets/images/background.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text('Create Account'),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Form(
              key: formKey,
              child: Container(
                padding: EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration:InputDecoration(
                        labelText: 'First Name'
                      ),
                      onChanged: (text){
                        firstName = text;
                      },
                      validator: (text){
                        if(text == null || text.trim().isEmpty){
                          return 'Please Enter first Name';
                        }
                        return null ;
                      },
                    ),
                    TextFormField(
                      decoration:InputDecoration(
                          labelText: 'last Name'
                      ),
                      onChanged: (text){
                        lastName = text;
                      },
                      validator: (text){
                        if(text == null || text.trim().isEmpty){
                          return 'Please Enter last Name';
                        }
                        return null ;
                      },
                    ),
                    TextFormField(
                      decoration:InputDecoration(
                          labelText: 'user Name'
                      ),
                      onChanged: (text){
                        userName = text;
                      },
                      validator: (text){
                        if(text == null || text.trim().isEmpty){
                          return 'Please Enter user Name';
                        }
                        return null ;
                      },
                    ),
                    TextFormField(
                      decoration:InputDecoration(
                          labelText: 'email'
                      ),
                      onChanged: (text){
                        email = text;
                      },
                      validator: (text){
                        bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(text!);
                        if(text == null || text.trim().isEmpty){
                          return 'Please Enter email';
                        }
                        if(!emailValid){
                          return 'please enter valid email';
                        }
                        return null ;
                      },
                    ),
                    TextFormField(
                      decoration:InputDecoration(
                          labelText: 'password'
                      ),
                      onChanged: (text){
                        password = text;
                      },
                      validator: (text){
                        if(text == null || text.trim().isEmpty){
                          return 'Please Enter password';
                        }
                        if(text.length<6){
                          return 'password should be at least 6 chart';
                        }
                        return null ;
                      },
                    ),
                    SizedBox(height: 20,),
                    ElevatedButton(
                        onPressed: (){
                          validateForm();
                        },
                        child: Text('Register')
                    ),
                    SizedBox(height: 20,),
                    TextButton(
                        onPressed: (){
                          Navigator.of(context).pushNamed(LoginScreen.routeName);
                        },
                        child: Text('Have an account ?',
                        textAlign: TextAlign.start,)),
                  ],

                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
 void validateForm(){
   if(formKey.currentState?.validate()==true){
     viewModel.registerFireBaseAuth(email, password,firstName,lastName,userName);
   }
 }

  @override
  void hideLoading() {
   Utils.hideLoading(context);
  }

  @override
  void showLoading() {
    Utils.showLoading(context, 'Loading...');

  }

  @override
  void showMessage(String message) {
    Utils.showMessage(context, message, 'Ok', (context){
      Navigator.pop(context);
    });

  }

  @override
  void goToHome(MyUser user) {
    var provider = Provider.of<UserProvider>(context , listen: false);
    provider.user = user ;
    Timer(Duration(milliseconds:2000),(){
      Navigator.of(context).pushNamed(HomeScreen.routeName);
    });
  }
}
