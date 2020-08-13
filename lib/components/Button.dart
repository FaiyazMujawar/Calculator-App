import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final text;
  final icon;
  final color;
  final textStyle;
  final action;
  final lonPressAction;

  const Button(
      {Key key,
      this.text,
      this.icon,
      this.action,
      this.color,
      this.textStyle,
      this.lonPressAction})
      : super(key: key);
  @override
  ButtonState createState() => ButtonState();
}

class ButtonState extends State<Button> {
  String text;
  Color color;
  Icon icon;
  TextStyle textStyle;
  Function action;
  Function lonPressAction;
  @override
  void initState() {
    text = widget.text;
    icon = widget.icon;
    color = widget.color;
    textStyle = widget.textStyle;
    action = widget.action;
    lonPressAction = widget.lonPressAction;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            width: 1.0,
            color: color == Colors.transparent ? color : Colors.grey.shade300,
          ),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(15),
          color: color ?? Color(0xfff9f9f9),
          child: InkWell(
            onTap: action,
            onLongPress: lonPressAction,
            borderRadius: BorderRadius.circular(15),
            child: Center(
                child: icon == null
                    ? Text(
                        text,
                        style: textStyle == null
                            ? TextStyle(
                                fontSize: 20,
                                fontFamily: 'Rubik',
                                color: color == Colors.transparent
                                    ? Colors.white
                                    : Colors.black)
                            : textStyle,
                      )
                    : icon),
          ),
        ),
      ),
    );
  }
}
