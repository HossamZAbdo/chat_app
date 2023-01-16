import 'package:chat_app/home/home_navigator.dart';
import 'package:chat_app/home/home_screen_view_model.dart';
import 'package:chat_app/rooms/add_room.dart';
import 'package:chat_app/rooms/room_wid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements HomeNavigator{
  HomeScreenViewModel viewModel =HomeScreenViewModel();
  @override
  void initState() {
    super.initState();
    viewModel.navigator= this;
    //viewModel.getRooms();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> viewModel,
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
            title: Text('Home Screen'),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              Navigator.of(context).pushNamed(AddRoom.routeName);
            },
            child: Icon(Icons.add),
          ),
          body:Consumer<HomeScreenViewModel>(
            builder: (buildContext,HomeScreenViewModel,child){
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                  ),
                itemBuilder: (context,index){
                  return RoomWid(room: viewModel.rooms[index],);

                },
                itemCount: viewModel.rooms.length,
              );

            },
          )

        ),
      ]),
    );
  }
}
