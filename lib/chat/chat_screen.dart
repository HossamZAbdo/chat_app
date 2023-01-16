import 'package:chat_app/chat/chat_navigator.dart';
import 'package:chat_app/chat/chat_screen_view_model.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/model/room.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/utils.dart'as Utils;

class ChatScreen extends StatefulWidget {
  static String routeName = 'chat';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> implements ChatNavigator {
  ChatScreenViewModel viewModel = ChatScreenViewModel();
  String messageContent = '';
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as Room;
    var userProvider = Provider.of<UserProvider>(context);
    viewModel.room = args ;
    viewModel.currentUser =userProvider.user;
    viewModel.UpRoomMess();

    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(children: [
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
            title: Text(args.title),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
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
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 32),
              padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: StreamBuilder<QuerySnapshot<Message>>(
                  stream: viewModel.streamMessage,
                  builder: (context,snapshot){
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    var message = snapshot.data?.docs.map((doc) => doc.data()).toList();
                    return ListView.builder(itemBuilder: (context,index){
                      return Text(message?.elementAt(index).content ?? '');

                    },
                      itemCount: message?.length ?? 0 ,

                    );


                  },
                )),
                Row(
                  children: [
                    Expanded(
                        child: TextField(
                          controller:controller ,
                          onChanged: (text){
                            messageContent = text;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(5),
                            hintText: 'Type Message',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(topRight:Radius.circular(15)),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                                color: Colors.red
                              ),
                            ),
                          ),
                    )
                    ),
                    SizedBox(width: 10,),
                    ElevatedButton(
                        onPressed: (){
                          viewModel.insertMessage(messageContent);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Text('Send'),
                              SizedBox(width: 10,),
                              Icon(Icons.send),
                            ],
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }

  @override
  void showMessage(String message) {
    Utils.showMessage(context, message, 'Ok', (context){
      Navigator.pop(context);
    });
  }

  @override
  void clearMessage() {
    controller.clear();

  }
}
