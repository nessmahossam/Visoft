import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

const RegisterAndLoginText = Padding(
  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
  child: Text(
    'Register!',
    style: TextStyle(
      fontSize: 35,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
  ),
);
showAlert(AlertType alertType, String title, List<DialogButton> listOfButtons,
    bool isCloseButton, bool isOverLayTapDismiss, BuildContext context, img) {
  var alertStyle = AlertStyle(
      buttonsDirection: ButtonsDirection.column,
      animationType: AnimationType.fromTop,
      isCloseButton: isCloseButton,
      isOverlayTapDismiss: isOverLayTapDismiss,
      backgroundColor: Colors.blueGrey,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Theme.of(context).primaryColor, width: 3),
      ),
      titleStyle: TextStyle(
        color: Colors.white,
      ),
      constraints: BoxConstraints.expand(width: 300),
      overlayColor: Color(0x55000000),
      alertElevation: 0,
      alertAlignment: Alignment.center);
  Alert(
      context: context,
      title: title,
      style: alertStyle,
      buttons: listOfButtons,
      image: Container(
        height: 300,
        width: double.infinity,
        child: Image(
          fit: BoxFit.cover,
        ),
      )).show();
}

const statusList = [
  {
    "img": "assets/images/web1.1.png",
    "isPlayed": true,
    "title": "Search For Job / Mobile App",
    "userImg":
        "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80.jpg",
    "userName": "Yana George",
    "price": "214EGP",
  },
  {
    "img": "assets/images/web1.png",
    "isPlayed": true,
    "title": "Morning Application /web design",
    "userImg":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRloalRBzRCgapHsTH9YjqhbcgrUB5rq0T_w&usqp=CAU",
    "userName": "John Wheler",
    "price": "254EGP",
  },
  {
    "isPlayed": false,
    "title": "Redesign of mobile PlantApp",
    "userImg":
        "https://images.unsplash.com/photo-1552058544-f2b08422138a?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1544&q=80.jpg",
    "userName": "mark zuckerberg",
    "img": "assets/images/mob1.png",
    "price": "200EGP",
  },
  {
    "isPlayed": false,
    "title": "Web Design",
    "userImg":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2stN_qoz3TPMCm9BF9TtpUneEzvyCJc8P4g&usqp=CAU",
    "userName": "Maha Mohamed",
    "img": "assets/images/web2.png",
    "price": "420EGP",
  },
  {
    "isPlayed": false,
    "title": "Foodima /Web Application",
    "userImg":
        "https://st.depositphotos.com/2309453/3120/i/600/depositphotos_31203671-stock-photo-friendly-smiling-man.jpg",
    "userName": "hessuin medhat",
    "img": "assets/images/web3.png",
    "price": "374EGP",
  },
  {
    "isPlayed": true,
    "title": "Website UI/UX Design",
    "userImg":
        "https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?ixid=MXwxMjA3fDB8MHxzZWFyY2h8M3x8cGVyc29ufGVufDB8fDB8&ixlib=rb-1.2.1&w=1000&q=80.jpg",
    "userName": "Eng Jo",
    "img": "assets/images/web4.png",
    "price": "264EGP",
  },
];