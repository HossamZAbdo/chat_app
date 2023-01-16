import 'package:chat_app/chat/chat_screen.dart';
import 'package:chat_app/model/room.dart';
import 'package:flutter/material.dart';

class RoomWid extends StatelessWidget{
  Room room ;
  RoomWid({required this.room});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed(ChatScreen.routeName,arguments: room);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade700,
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Image.asset('assets/images/${room.categoryId}.png',
            width: 50,
            ),
            Text(room.title),
          ],
        ),
      ),
    );
  }
}
