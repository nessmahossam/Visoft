import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viisoft/models/sharedpref_helper.dart';
import 'package:viisoft/constants.dart';

class DatabaseMethod {

  

    getCurrentUser() async {
       return await  currentUser.data()['Name'];
    //   DocumentSnapshot currentUser;
    //   String currUserName;
    //   String id = await SharedPreferenceHelper().getUserId();
    // return await  FirebaseFirestore.instance
    //   .collection("Users")
    //   .doc(id)
    //   .get()
    //   .then((value){
    //         print(value.data());
    //     currentUser = value;
    //      currUserName = value.data()['Name'];

    //   });
  }
  Future<void> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  await FirebaseAuth.instance.signOut();
}
  Future<Stream<QuerySnapshot>> getUserByUserName(String username) async {
    return FirebaseFirestore.instance
        .collection("Users")
        .where("Name", isEqualTo: username)
        .snapshots();
  }

   Future<Stream<QuerySnapshot>> getUserByUserIDs(String userID) async {
    return FirebaseFirestore.instance
        .collection("Users")
        .where("uid", isEqualTo: userID)
        .snapshots();
  }
  Future addMessage(
      String chatRoomId, String messageId, Map messageInfoMap) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .doc(messageId)
        .set(messageInfoMap);
  }

  updateLastMessageSend(String chatRoomId, Map lastMessageInfoMap) {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .update(lastMessageInfoMap);
  }

  createChatRoom(String chatRoomId, Map chatRoomInfoMap) async {
    final snapShot = await FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .get();

    if (snapShot.exists) {
      // chatroom already exists
      return true;
    } else {
      // chatroom does not exists
      return FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(chatRoomId)
          .set(chatRoomInfoMap);
    }
  }

  Future<Stream<QuerySnapshot>> getChatRoomMessages(chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("ts", descending: true)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getChatRooms() async {
    String myID = await SharedPreferenceHelper().getUserId();
    String myName = await  getCurrentUser();
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .orderBy("lastMessageSendTs", descending: true)
        .where("users", arrayContains: myName)
        .snapshots();
  }



}