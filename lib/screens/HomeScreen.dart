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
                color: Colors.grey.shade100,
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
                                    MdiIcons.deleteOutline,
                                    color: Colors.white,
                                  ),
                                  color: kPrimaryColor,
                                  action: () {
                                    setState(() {
                                      input = "";
                                      output = "";
                                    });
                                  },
                                ),
                                Button(
                                  icon: Icon(
                                    Icons.backspace,
                                    color: kPrimaryColor,
                                    size: 20,
                                  ),
                                  action: () {
                                    setState(() {
                                      if (input.length > 0) {
                                        input = input.substring(
                                            0, input.length - 1);
                                      }
                                    });
                                  },
                                ),
                                Button(
                                  icon: Icon(
                                    MdiIcons.percentOutline,
                                    color: kPrimaryColor,
                                    size: 20,
                                  ),
                                  action: setText("%"),
                                ),
                                Button(
                                  icon: Icon(
                                    MdiIcons.division,
                                    color: kPrimaryColor,
                                    size: 20,
                                  ),
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
                                    size: 20,
                                  ),
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
                                    size: 20,
                                  ),
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
                                    size: 20,
                                  ),
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
                                      setState(() {
                                        String result =
                                            calculator.solveExp(input);
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
                                    padding: EdgeInsets.all(20.0),
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
            )
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
}
