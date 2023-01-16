


import 'package:chat_app/model/category.dart';
import 'package:chat_app/rooms/add_room_view_model.dart';
import 'package:flutter/material.dart';

import 'add_room_navigator.dart';
import 'package:chat_app/utils.dart'as Utils;

class AddRoom extends StatefulWidget {
  static String routeName = 'add_room';

  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> implements AddRoomNavigator{
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String roomTitle = '';
  String roomDescription = '';
  var categoryList = Category.getAllCategories();
  late Category selectedItem ;
  AddRoomViewModel viewModel = AddRoomViewModel();
  @override
  void initState() {
    super.initState();
    selectedItem = categoryList[0];
    viewModel.navigator = this ;
  }
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
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
          title: Text('Add Room'),
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
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Create New Room',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25,),
                Image.asset(
                  'assets/images/groub.png',
                  width: 60,
                  height: 60,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Room Title'),
                  onChanged: (text) {
                    roomTitle = text;
                  },
                ),
                SizedBox(height: 25,),
                DropdownButton<Category>(
                  value: selectedItem,
                    items:categoryList.map((category)=>DropdownMenuItem<Category>(
                      value: category,
                        child: Row(
                          children: [
                            Image.asset(category.image,
                            width: 50,
                            height: 50,
                            ),
                            SizedBox(width: 10,),
                            Text(category.title),
                          ],
                        )
                    )).toList(),
                    onChanged: (newSelectedItem){
                    if(newSelectedItem==null)return;
                      setState(() {
                        selectedItem = newSelectedItem;
                      });
                    }
                ),
                SizedBox(height: 25,),
                TextFormField(
                  decoration:
                      InputDecoration(hintText: 'Enter Room Description'),
                  onChanged: (text) {
                    roomDescription = text;
                  },
                ),
                SizedBox(height: 25,),
                ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                ),
                                    ),),
                    onPressed: () {
                      validateForm();

                    },
                    child: Text('Create'))
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  void validateForm() {
    if(formKey.currentState?.validate() == true){
      viewModel.createRoom(roomTitle, roomDescription, selectedItem.id);

    }
  }

  @override
  void hideLoading() {
    Utils.hideLoading(context);
  }

  @override
  void showLoading() {
    Utils.showLoading(context, 'Room Create Loading ....');
  }

  @override
  void showMessage(String message) {
    Utils.showMessage(context, message, 'Ok', (context){
      Utils.hideLoading(context);
      Navigator.pop(context);
    });
  }
}
