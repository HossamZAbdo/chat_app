import 'package:chat_app/database/database.dart';
import 'package:chat_app/rooms/add_room_navigator.dart';
import 'package:flutter/material.dart';

class AddRoomViewModel extends ChangeNotifier{
late AddRoomNavigator navigator ;
void createRoom(String roomTitle , String roomDescription , String categoryId)async{
  DataBaseUtils.createRoomFromFireStore(roomTitle, roomDescription, categoryId);
  navigator.showLoading();
  try{
    var room = await DataBaseUtils.createRoomFromFireStore(roomTitle, roomDescription, categoryId);
    navigator.hideLoading();
    navigator.showMessage('Room Create Successfully');

  }catch(error){
    navigator.hideLoading();
    navigator.showMessage(error.toString());
  }
}
}