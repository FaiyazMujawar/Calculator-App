import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final text;
  final icon;

  const Button({Key key, this.text, this.icon}) : super(key: key);
  @override
  ButtonState createState() => ButtonState();
}

class ButtonState extends State<Button> {
  String text;
  Color color;
  Icon icon;
  @override
  void initState() {
    text = widget.text;
    icon = widget.icon;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey.shade200,
            width: 1.0,
          ),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            onTap: () {
              print(text);
            },
            borderRadius: BorderRadius.circular(10),
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
