import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatBubble extends StatefulWidget {
  final String message;
  final bool isMe;

  final Size size;

  final String username;
  final String displayName;
  final String imageURL;
  final String timeAgo;
  final Color leftColor;
  final Color rightColor;

  ChatBubble(
      {this.isMe,
      this.message,
      this.size,
      this.username,
      this.displayName,
      this.imageURL,
      this.timeAgo,
      this.leftColor,
      this.rightColor});

  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  String get initial => widget.displayName == null
      ? "."
      : widget.displayName.substring(0, 1).toUpperCase();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment:
          widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          textDirection: widget.isMe ? TextDirection.rtl : TextDirection.ltr,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5)
              ]),
              child: widget.imageURL == null
                  ? CircleAvatar(
                      radius: 15,
                      backgroundColor:
                          widget.isMe ? widget.rightColor : Colors.red,
                      child: Text(widget.username
                          .substring(
                            0,
                            1,
                          )
                          .toUpperCase()),
                    )
                  : CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage(widget.imageURL),
                    ),
            ),
            SizedBox(
              width: widget.isMe ? 10 : 10,
            ),
            Text(
              '${widget.username} - ${widget.timeAgo}',
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Container(
            constraints: BoxConstraints(maxWidth: widget.size.width * 0.6),
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: !widget.isMe
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).accentColor,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5)
                ]),
            child: Text(
              widget.message,
              style: TextStyle(
                  color: widget.isMe ? Colors.white : Colors.white,
                  fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
