import 'package:calc/components/Button.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      enabled: false,
                      contentPadding: EdgeInsets.all(20.0),
                      hintText: "2x+3",
                      hintStyle: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
                                    children: [
                                      Button(
                                        text: "7",
                                      ),
                                      Button(
                                        text: "8",
                                      ),
                                      Button(
                                        text: "9",
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Button(
                                        text: "6",
                                      ),
                                      Button(
                                        text: "5",
                                      ),
                                      Button(
                                        text: "4",
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Button(
                                        text: "3",
                                      ),
                                      Button(
                                        text: "2",
                                      ),
                                      Button(
                                        text: "1",
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Button(
                                        text: ".",
                                      ),
                                      Button(
                                        text: "0",
                                      ),
                                      Button(
                                        icon: Icon(
                                          Icons.backspace,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 75,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Button(
                                  icon: Icon(
                                    MdiIcons.division,
                                    size: 20,
                                  ),
                                ),
                                Button(
                                  icon: Icon(
                                    Icons.clear,
                                    size: 20,
                                  ),
                                ),
                                Button(
                                  icon: Icon(
                                    Icons.remove,
                                    size: 20,
                                  ),
                                ),
                                Button(
                                  icon: Icon(
                                    Icons.add,
                                    size: 20,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 2),
                                  child: RawMaterialButton(
                                    onPressed: () {},
                                    fillColor: Color(0xff848ccf),
                                    elevation: 20,
                                    child: Icon(
                                      MdiIcons.equal,
                                      size: 23,
                                      color: Colors.white,
                                    ),
                                    padding: EdgeInsets.all(20.0),
                                    shape: CircleBorder(),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 20,
                    color: Color(0xff848ccf),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 15,
                        color: Colors.grey.shade100,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
