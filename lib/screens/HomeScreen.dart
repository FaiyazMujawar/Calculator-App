import 'dart:math';

import 'package:calc/components/Button.dart';
import 'package:calc/services/Calculator.dart';
import 'package:calc/themes.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String input;
  String output;
  String exp;
  Calculator calculator;
  @override
  void initState() {
    input = "";
    output = "";
    calculator = new Calculator();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
              height: MediaQuery.of(context).size.height * 0.35,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextField(
                    textAlign: TextAlign.end,
                    maxLength: 10,
                    decoration: InputDecoration(
                      enabled: false,
                      contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      border: InputBorder.none,
                      hintText: input,
                      hintStyle: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  TextField(
                    textAlign: TextAlign.end,
                    maxLength: 10,
                    decoration: InputDecoration(
                      enabled: false,
                      contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      border: InputBorder.none,
                      hintText: output,
                      hintStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(5),
                color: kSecondaryColor,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Button(
                                  icon: Icon(
                                    Icons.backspace,
                                    color: Colors.white,
                                  ),
                                  color: kPrimaryColor,
                                  action: backSpace(),
                                  lonPressAction: () {
                                    setState(() {
                                      input = "";
                                      output = "";
                                    });
                                  },
                                ),
                                Button(
                                  text: "(",
                                  textStyle: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 20,
                                  ),
                                  action: setText("("),
                                ),
                                Button(
                                  text: ")",
                                  textStyle: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 20,
                                  ),
                                  action: setText(")"),
                                ),
                                Button(
                                  icon: Icon(
                                    MdiIcons.division,
                                    color: kPrimaryColor,
                                    size: 25,
                                  ),
                                  // color: Color(0xffe5e5e5),
                                  action: setText("÷"),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Button(
                                  text: "7",
                                  action: setText("7"),
                                ),
                                Button(
                                  text: "8",
                                  action: setText("8"),
                                ),
                                Button(
                                  text: "9",
                                  action: setText("9"),
                                ),
                                Button(
                                  icon: Icon(
                                    Icons.clear,
                                    color: kPrimaryColor,
                                    size: 25,
                                  ),
                                  // color: Color(0xffe5e5e5),
                                  action: setText("x"),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Button(
                                  text: "4",
                                  action: setText("4"),
                                ),
                                Button(
                                  text: "5",
                                  action: setText("5"),
                                ),
                                Button(
                                  text: "6",
                                  action: setText("6"),
                                ),
                                Button(
                                  icon: Icon(
                                    MdiIcons.plus,
                                    color: kPrimaryColor,
                                    size: 25,
                                  ),
                                  // color: Color(0xffe5e5e5),
                                  action: setText("+"),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Button(
                                  text: "1",
                                  action: setText("1"),
                                ),
                                Button(
                                  text: "2",
                                  action: setText("2"),
                                ),
                                Button(
                                  text: "3",
                                  action: setText("3"),
                                ),
                                Button(
                                  icon: Icon(
                                    MdiIcons.minus,
                                    color: kPrimaryColor,
                                    size: 25,
                                  ),
                                  // color: Color(0xffe5e5e5),
                                  action: setText("−"),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Button(
                                  icon: Icon(
                                    MdiIcons.swapHorizontal,
                                    color: kPrimaryColor,
                                  ),
                                  action: getBottomSheet(),
                                ),
                                Button(
                                  text: "0",
                                  action: setText("0"),
                                ),
                                Button(
                                  text: ".",
                                  action: setText("."),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  child: RawMaterialButton(
                                    onPressed: () {
                                      exp = input;
                                      exp =
                                          exp.replaceAll(new RegExp(r'x'), '*');
                                      exp =
                                          exp.replaceAll(new RegExp(r'÷'), '/');
                                      exp = exp.replaceAll(
                                          new RegExp(r'e'), e.toString());
                                      exp = exp.replaceAll(
                                          new RegExp(r'π'), pi.toString());
                                      setState(() {
                                        String result =
                                            calculator.calculate(exp);
                                        output = result == null
                                            ? "ERROR"
                                            : "= " + result;
                                      });
                                    },
                                    fillColor: kPrimaryColor,
                                    elevation: 20,
                                    child: Icon(
                                      MdiIcons.equal,
                                      size: 23,
                                      color: Colors.white,
                                    ),
                                    padding: EdgeInsets.all(25.0),
                                    shape: CircleBorder(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Function setText(String text) {
    return () => setState(() {
          input += text;
        });
  }

  Function backSpace() {
    return () => setState(() {
          String lastTerm;
          if (input.length > 3) {
            lastTerm = input.substring(input.length - 4, input.length);
            if (lastTerm == "sin(" ||
                lastTerm == "cos(" ||
                lastTerm == "tan(" ||
                lastTerm == "log(" ||
                lastTerm == "inv(")
              input = input.substring(0, input.length - 3);
          }
          if (input.length > 4 && lastTerm == "qrt(")
            input = input.substring(0, input.length - 4);
          else if (input.endsWith("ln("))
            input = input.substring(0, input.length - 2);
          else if (input.length != 0)
            input = input.substring(0, input.length - 1);
        });
  }

  Function getBottomSheet() {
    return () => showModalBottomSheet(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10.0))),
          backgroundColor: kPrimaryColor,
          context: context,
          isScrollControlled: true,
          builder: (context) => Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Button(
                                text: "sin",
                                color: Colors.transparent,
                                action: setText("sin("),
                              ),
                              Button(
                                text: "cos",
                                color: Colors.transparent,
                                action: setText("cos("),
                              ),
                              Button(
                                text: "tan",
                                color: Colors.transparent,
                                action: setText("tan("),
                              ),
                              Button(
                                text: "log",
                                color: Colors.transparent,
                                action: setText("log("),
                              ),
                              Button(
                                text: "ln",
                                color: Colors.transparent,
                                action: setText("ln("),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Button(
                                icon: Icon(
                                  MdiIcons.percentOutline,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                color: Colors.transparent,
                                action: setText("%"),
                              ),
                              Button(
                                text: "e",
                                color: Colors.transparent,
                                action: setText("e"),
                              ),
                              Button(
                                text: "X!",
                                color: Colors.transparent,
                                action: setText("!"),
                              ),
                              Button(
                                icon: Icon(
                                  MdiIcons.exponent,
                                  color: Colors.white,
                                ),
                                color: Colors.transparent,
                                action: setText("^"),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Button(
                                text: "",
                                icon: Icon(
                                  MdiIcons.pi,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                color: Colors.transparent,
                                action: setText("π"),
                              ),
                              Button(
                                text: "",
                                icon: Icon(
                                  MdiIcons.squareRoot,
                                  size: 25,
                                  color: Colors.white,
                                ),
                                color: Colors.transparent,
                                action: setText("sqrt("),
                              ),
                              Button(
                                text: "1/x",
                                color: Colors.transparent,
                                action: setText("inv("),
                              ),
                              Button(
                                text: "",
                                color: Colors.transparent,
                              ),
                              Button(
                                text: "",
                                color: Colors.transparent,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
  }
}
