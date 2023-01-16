import 'package:chat_app/model/message.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:chat_app/model/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseUtils{

  static CollectionReference<MyUser> getUserCollection(){
    return
    FirebaseFirestore.instance.collection(MyUser.collectionName)
        .withConverter<MyUser>(
        fromFirestore: ((snapshot ,options) => MyUser.fromJson(snapshot.data()!)) ,
        toFirestore: (user , options)=> user.toJson());
  }

  static CollectionReference<Room> getRoomCollection(){
    return
      FirebaseFirestore.instance.collection(Room.collectionName)
          .withConverter<Room>(
          fromFirestore: ((snapshot ,options) => Room.fromJson(snapshot.data()!)) ,
          toFirestore: (room , options)=> room.toJson());
  }

  static CollectionReference<Message> getMessageCollection(String roomId){
    return getRoomCollection().doc(roomId).collection(Message.collectionName)
          .withConverter<Message>(
          fromFirestore: ((snapshot ,options) => Message.fromJson(snapshot.data()!)) ,
          toFirestore: (message , options)=> message.toJson());
  }


  static Future<void> createUser(MyUser user){
    return
    getUserCollection().doc(user.id).set(user);
  }

  static Future<MyUser?> readUser(String userId)async{
    var userDocSnapshot = await getUserCollection().doc(userId).get();
    return userDocSnapshot.data();
  }

  static Future<void> createRoomFromFireStore(String title , String description , String categoryId){
   var roomColl = getRoomCollection();
   var docRef = roomColl.doc();
   Room room = Room(
       id: docRef.id,
       title: title,
       description: description,
       categoryId: categoryId
   );
   return docRef.set(room);
  }

  static  Stream<QuerySnapshot<Room>>  getRooms(){
    return getRoomCollection().snapshots();

  }

  static Future <void> sendMessageToRoom(Message message){
    var roomMessage = getMessageCollection(message.roomId);
    var docRef = roomMessage.doc();
    message.id =docRef.id;
    return docRef.set(message);

  }
  static Stream<QuerySnapshot<Message>> getMessage(String roomId){
    return getMessageCollection(roomId).orderBy('dateTime').snapshots();

  }






}