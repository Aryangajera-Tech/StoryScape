import 'package:day_2/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class InfoCard extends StatefulWidget {
  InfoCard({
    required this.username
});
  String username;
  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:CircleAvatar(
              maxRadius: 25,
              backgroundColor: Yellow,
          child: Icon(Icons.person_outline_rounded, color: Green)
            ),
      title:Text(widget.username.toString(),style: TextStyle(color: Yellow))
    );
  }
}
