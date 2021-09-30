import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key key,
     this.text,
     this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>   TextButton(
    child: Text(this.text),
    style: TextButton.styleFrom(
      primary: Colors.black,
      // padding: EdgeInsets.fromWindowPadding(),
      backgroundColor: Color.fromARGB(203, 255, 255, 255),
      onSurface: Colors.grey[600],
      side: BorderSide(color: Colors.black, width: 0.5),
      shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
    ),
    onPressed: onClicked,

  );
}