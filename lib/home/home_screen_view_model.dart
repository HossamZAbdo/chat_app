import 'package:chat_app/database/database.dart';
import 'package:chat_app/home/home_navigator.dart';
import 'package:chat_app/model/room.dart';
import 'package:flutter/material.dart';

class HomeScreenViewModel extends ChangeNotifier{
  List<Room> rooms = [];
late HomeNavigator navigator ;
HomeScreenViewModel(){
  getRooms();
}
void getRooms()async{
  //rooms = await DataBaseUtils.getRooms();
  rooms = DataBaseUtils.getRooms() as List<Room>;
}

}