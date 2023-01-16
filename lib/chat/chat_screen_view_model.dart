import 'package:chat_app/chat/chat_navigator.dart';
import 'package:chat_app/database/database.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:chat_app/model/room.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreenViewModel extends ChangeNotifier{
  late ChatNavigator navigator ;
  late Room room ;
  late MyUser? currentUser ;
  late Stream<QuerySnapshot<Message>> streamMessage ;


  void insertMessage(String messageContent)async{
    if(messageContent.trim().isEmpty){
      return ;
    }
    Message message = Message(
        content: messageContent,
        dateTime: DateTime.now().millisecondsSinceEpoch,
        categoryId: room.categoryId,
        senderName: room.id,
        roomId: currentUser?.id??'',
        senderId: currentUser?.userName??'',
    );
    try{
      var result = await DataBaseUtils.sendMessageToRoom(message);
      navigator.clearMessage();

    }catch(error){
      navigator.showMessage(error.toString());
    }
  }
  void UpRoomMess(){
    streamMessage = DataBaseUtils.getMessage(room.id);
  }

}