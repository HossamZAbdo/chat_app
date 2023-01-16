

import 'package:chat_app/chat/chat_screen.dart';
import 'package:chat_app/home/home_screen.dart';
import 'package:chat_app/login/login_screen.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:chat_app/register/register_screen.dart';
import 'package:chat_app/rooms/add_room.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main ()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => UserProvider()),
    ],
      child: MyApp()));
}
class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return MaterialApp(
      title: 'Chat App',
      debugShowCheckedModeBanner: false,
      initialRoute: userProvider.firebaseUser == null ? LoginScreen.routeName :HomeScreen.routeName,
      routes: {
       RegisterScreen.routeName : (context) => RegisterScreen() ,
        LoginScreen.routeName : (context)=> LoginScreen() ,
        HomeScreen.routeName : (context)=> HomeScreen(),
        AddRoom.routeName : (context) => AddRoom(),
        ChatScreen.routeName : (context) => ChatScreen(),

      },

    );
  }
}
