import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import '../flowchart.dart';
import 'globals.dart' as global;

class SimpleUI extends StatefulWidget {
  final String name;

  const SimpleUI({Key? key, required this.name}) : super(key: key);

  @override
  State<SimpleUI> createState() => _SimpleUIState();
}

class _SimpleUIState extends State<SimpleUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // drawer: NavBar(),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'PRE CONSULTING CLINICAL WORKFLOW',
            style: TextStyle(
              fontSize: 27,
              color: Colors.white,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
            ),
          ),
          automaticallyImplyLeading: false,
          // removes back arrow
          backgroundColor: Colors.blue[900],
          // sets background color to light blue
          elevation: 0,
        ),
        body: Row(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.92,
              width: MediaQuery.of(context).size.width * 0.20,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade100),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      // Navigate to main screen
                      // Navigator.pushNamed(context, '/preconsultingclicnicalworkflow');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SimpleUI(
                                    name: '',
                                  )));
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height * 0.1,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/axi.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text('Add User'),
                    trailing: Icon(
                      Icons.person,
                      color: Colors.blue.shade900,
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text('Patient Info Flowchart'),
                    onTap: () {
                      // Navigate to QuestionAdd class
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const flowchart(title: '', name: 'info')));
                    },
                  ),
                  const Divider(),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 09,
              width: MediaQuery.of(context).size.width * 0.8,
              color: Colors.blueGrey.shade50,
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 0.09,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade100),
                          color: Colors.grey[50],
                        ),
                        child: Center(
                          child: MediaQuery(
                            data: MediaQuery.of(context)
                                .copyWith(textScaleFactor: 1.3),
                            child: Text(
                              "⚠ Highly Sensitive data flow specifier settings. Updates or any change to flowcharts requires \n LEVEL-1 Authorization",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                // fontSize:
                                inherit: true,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.82,
                          width: MediaQuery.of(context).size.width,
                          // color: Colors.lightGreen,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DynamicHeightGridView(
                              // Set up your grid properties here
                              crossAxisCount: 3,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              itemCount: 10,
                              builder: (context, index) {
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.35,
                                  width:
                                      MediaQuery.of(context).size.width * 0.26,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Dialog(
                                                    child: Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              2.5,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.6,
                                                      padding:
                                                          EdgeInsets.all(16.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          InkWell(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) => flowchart(
                                                                          title:
                                                                              '',
                                                                          name: global.flow[index][0] )));
                                                            },
                                                            child: Container(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.3,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.17,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border
                                                                    .all(),
                                                                color: Colors
                                                                    .blue
                                                                    .shade900,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              child: Center(
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .male_outlined,
                                                                      // Add the male icon
                                                                      size:
                                                                          50.0,
                                                                      color: Colors
                                                                          .white,
                                                                      // Set the size of the iconcolor: Colors.white, // Set the color of the icon
                                                                    ),
                                                                    Text(
                                                                      "Male",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontSize:
                                                                            20.0,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) => flowchart(
                                                                          title:
                                                                          '',
                                                                          name: global.flow[index][1] )));
                                                            },
                                                            child: Container(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.3,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.17,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border
                                                                    .all(),
                                                                color: Colors
                                                                    .blue
                                                                    .shade900,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              child: Center(
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .female_outlined,
                                                                      // Add the male icon
                                                                      size:
                                                                          50.0,
                                                                      // Set the size of the icon
                                                                      color: Colors
                                                                          .white, // Set the color of the icon
                                                                    ),
                                                                    Text(
                                                                      "Female",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontSize:
                                                                            20.0,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) => flowchart(
                                                                          title:
                                                                          '',
                                                                          name: global.flow[index][2] )));
                                                            },
                                                            child: Container(
                                                              height: MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .height *
                                                                  0.3,
                                                              width: MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width *
                                                                  0.17,
                                                              decoration:
                                                              BoxDecoration(
                                                                border: Border
                                                                    .all(),
                                                                color: Colors
                                                                    .blue
                                                                    .shade900,
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10.0),
                                                              ),
                                                              child: Center(
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .transgender_outlined,
                                                                      // Add the male icon
                                                                      size:
                                                                      50.0,
                                                                      // Set the size of the icon
                                                                      color: Colors
                                                                          .white, // Set the color of the icon
                                                                    ),
                                                                    Text(
                                                                      "Others",
                                                                      style:
                                                                      TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                        FontWeight.bold,
                                                                        fontSize:
                                                                        20.0,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.10,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.19,
                                              margin: const EdgeInsets.only(
                                                  left: 10, top: 10),
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.2),
                                                    blurRadius: 5,
                                                    offset: const Offset(0, 3),
                                                  ),
                                                ],
                                                image: const DecorationImage(
                                                  image: AssetImage(
                                                      "assets/images/Hello.png"),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              child: Transform.scale(
                                                scale: 20.95,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.120,
                                              decoration: const BoxDecoration(
                                                  // border: Border.all(),
                                                  ),
                                              child: Center(
                                                child: Text(
                                                  global.name[index][0],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'Times New Roman',
                                                    fontSize: 20,
                                                    inherit: true,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.070,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.20,
                                          decoration: const BoxDecoration(
                                              // border: Border.all()
                                              ),
                                          padding:
                                              const EdgeInsets.only(top: 0.110),
                                          child: Center(
                                            child: Text(
                                              global.name[index][1],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                debugLabel:
                                                    'whiteCupertino subtitle',
                                                fontFamily: 'Times New Roman',
                                                fontSize: 13,
                                                inherit: true,
                                                letterSpacing: 1,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      )
                      // const SizedBox(
                      //   height: 10,
                      // ),

                      //
                    ]),
              ),
            ),
          ],
        ));
  }
}
