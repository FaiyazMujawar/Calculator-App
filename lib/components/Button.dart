import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final text;
  final icon;
  final color;
  final action;

  const Button({Key key, this.text, this.icon, this.action, this.color})
      : super(key: key);
  @override
  ButtonState createState() => ButtonState();
}

class ButtonState extends State<Button> {
  String text;
  Color color;
  Icon icon;
  Function action;
  @override
  void initState() {
    text = widget.text;
    icon = widget.icon;
    color = widget.color;
    action = widget.action;
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
            color: Colors.grey.shade200,
            width: 1.0,
          ),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(15),
          color: color ?? Colors.white38,
          child: InkWell(
            onTap: action,
            borderRadius: BorderRadius.circular(15),
            child: Center(
                child: icon == null
                    ? Text(
                        text,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      )
                    : icon),
          ),
        ),
      ),
    );
  }
}
