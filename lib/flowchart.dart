
import 'dart:html';
import 'dart:typed_data';
import 'dart:ui';
import 'package:testingflowchart/plugin/plugin/src/dashboard.dart';
import 'package:testingflowchart/plugin/plugin/src/elements/flow_element.dart';
import 'package:testingflowchart/plugin/plugin/src/flow_chart.dart';
import 'package:flutter/material.dart';

import 'package:star_menu/star_menu.dart';
import 'dashboardhomescreen.dart';
import 'element_settings_menu.dart';
import 'text_menu.dart';
import 'package:flutter/rendering.dart';
import 'globals.dart' as global;


class flowchart extends StatefulWidget {
  final String name,title;
  const flowchart({Key? key, required this.title, required this.name,}) : super(key: key);

  @override
  State<flowchart> createState() => _flowchartState();
}

class _flowchartState extends State<flowchart> {
  Dashboard dashboard = Dashboard();
  var docref = '';
  String names = '';
  // String startAgeController=Te;

  final GlobalKey flowChartKey = GlobalKey();



  @override
  void initState(){
    super.initState();
    setState(() {
      docref = widget.name;
      names = widget.name;
    });
    dashboard.loadDashboard(docref);
  }

  void alertBox(){
    docref = widget.name;

  }


  Future<void> downloadFlowChart() async {
    try {
      RenderRepaintBoundary boundary =
      flowChartKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Save the image bytes to the device's storage
      Blob blob = Blob([pngBytes], 'image/png');
      String url = Url.createObjectUrlFromBlob(blob);
      AnchorElement downloadLink = AnchorElement(href: url);
      downloadLink.download = 'flowchart.png';
      downloadLink.click();

      print('File saved to device storage');
    } catch (e) {
      print('Error saving image: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'PRE CONSULTING CLINICAL FLOWCHART',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            letterSpacing: 6,
          ),
        ),
        backgroundColor: Colors.blue[900],
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => SimpleUI(name: '', )),
            );
          },
        ),
      ),
      // backgroundColor: Colors.black12,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width * 0.20,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            // Navigate to main screen
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SimpleUI(name: '', )));
                          },
                          child: Container(
                            margin: EdgeInsets.all(20),
                            height: MediaQuery.of(context).size.height * 0.1,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/axi.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Divider(),
                        listViewInFlowChart(context, 'NeoNatal', 0),
                        Divider(),
                        listViewInFlowChart(context, 'Toddler', 1),
                        Divider(),
                        listViewInFlowChart(context, 'Pediatric', 2),
                        Divider(),
                        listViewInFlowChart(context, 'Adolescent', 3),
                        Divider(),
                        listViewInFlowChart(context, 'Adult (18y-30y)', 4),
                        Divider(),
                        listViewInFlowChart(context, 'Adult (30y-45y)', 5),
                        Divider(),
                        listViewInFlowChart(context, 'Middle Aged (46y-60y)', 6),
                        Divider(),
                        listViewInFlowChart(context, 'Aged Adult (60y-70y)', 7),
                        Divider(),
                        listViewInFlowChart(context, 'Old Aged (70y - 80y)', 8),
                        Divider(),
                        listViewInFlowChart(context, 'Old (80y +)', 9),
                        Divider(),
                      ],
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width*0.8,
                      height: MediaQuery.of(context).size.height*0.05,
                      child: Center(
                        child: Text(
                          "If a node in the graph is connected to the top, the statement regarding its connectivity is 'yes.' On the other hand, if the node is connected to the right, the statement is 'no.'",
                          style: TextStyle(
                            color: Colors.blue.shade900,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left, // Aligns text to center left
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        // constraints: BoxConstraints.expand(),
                        width: MediaQuery.of(context).size.width*0.8,
                        height: MediaQuery.of(context).size.height,
                        child: RepaintBoundary(
                          key: flowChartKey,
                          child: FlowChart(
                            dashboard: dashboard,
                            onDashboardTapped: ((context, position) {

                              debugPrint('Dashboard tapped $position');
                              _displayDashboardMenu(context, position);
                            }),
                            onDashboardLongtTapped: ((context, position) {
                              debugPrint('Dashboard long tapped $position');
                            }),
                            onElementLongPressed: (context, position, element) {
                              debugPrint('Element with "${element.text}" text '
                                  'long pressed');
                            },
                            onElementPressed: (context, position, element) {
                              debugPrint('Element with "${element.text}" text pressed');
                              _displayElementMenu(context, position, element);
                            },
                            onHandlerPressed: (context, position, handler, element) {
                              debugPrint('handler pressed: position $position '
                                  'handler $handler" of element $element');
                              _displayHandlerMenu(position, handler, element);
                            },
                            onHandlerLongPressed: (context, position, handler, element) {
                              debugPrint('handler long pressed: position $position '
                                  'handler $handler" of element $element');
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                scrollDirection: Axis.vertical,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
        downloadFlowChart,
        child: Icon(Icons.download),
      ),
    );
  }

  //*********************
  //* POPUP MENUS
  //*********************

  /// Display a drop down menu when tapping on a handler
  _displayHandlerMenu(
      Offset position,
      Handler handler,
      FlowElement element,
      ) {
    StarMenuOverlay.displayStarMenu(
      context,
      StarMenu(
        params: StarMenuParameters(
          shape: MenuShape.linear,
          openDurationMs: 60,
          linearShapeParams: const LinearShapeParams(
            angle: 270,
            space: 10,
          ),
          onHoverScale: 1.1,
          useTouchAsCenter: true,
          centerOffset: position -
              Offset(
                dashboard.dashboardSize.width / 1,
                dashboard.dashboardSize.height / 1,
              ),
        ),
        onItemTapped: (index, controller) => controller.closeMenu!(),
        items: [
          FloatingActionButton(
            child: const Icon(Icons.delete),
            onPressed: () =>
                dashboard.removeElementConnection(element, handler),
          )
        ],
        parentContext: context,
      ),
    );
  }

  /// Display a drop down menu when tapping on an element
  _displayElementMenu(
      BuildContext context,
      Offset position,
      FlowElement element,
      // FlowElement groupElement,
      ) {
    StarMenuOverlay.displayStarMenu(
      context,
      StarMenu(
        params: StarMenuParameters(
          shape: MenuShape.linear,
          openDurationMs: 60,
          linearShapeParams: const LinearShapeParams(
            angle: 270,
            alignment: LinearAlignment.left,
            space: 10,
          ),
          onHoverScale: 1.1,
          centerOffset: position - const Offset(50, 0),
          backgroundParams: const BackgroundParams(
            backgroundColor: Colors.transparent,
          ),
          boundaryBackground: BoundaryBackground(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).cardColor,
              boxShadow: kElevationToShadow[6],
            ),
          ),
        ),
        onItemTapped: (index, controller) {
          if (!(index == 5 || index == 2)) {
            controller.closeMenu!();
          }
        },
        items: [
          Text(
            element.text,
            style: const TextStyle(fontWeight: FontWeight.w900),
          ),
          InkWell(
            onTap: () => dashboard.removeElement(element),
            child: const Text('Delete'),
          ),
          TextMenu(element: element),
          // GroupMenu(groupElement: element),
          InkWell(
            onTap: () {
              dashboard.removeElementConnections(element);
            },
            child: const Text('Remove all connections'),
          ),
          InkWell(
            onTap: () {
              dashboard.addElementToGroup(context,element);
            },
            child:  Text('Add to group -------> ${element.selectedGroup}'),
          ),

          InkWell(
            onTap: () {
              dashboard.setMode(context,element);
            },
            child:  Text('Select Mode -------> ${element.selectedMode}'),
          ),

          InkWell(
            onTap: () {
              dashboard.isMandatory(context,element);
            },
            child:  Text('isMandatory -------> ${element.isMandatory}'),
          ),





          InkWell(
            onTap: () {
              dashboard.setElementResizable(element, true);
            },
            child: const Text('Resize'),
          ),
          ElementSettingsMenu(
            element: element,
          ),
        ],
        parentContext: context,
      ),
    );
  }

  /// Display a linear menu for the dashboard
  /// with menu entries built with [menuEntries]
  _displayDashboardMenu(BuildContext context, Offset position) {
    StarMenuOverlay.displayStarMenu(
      context,
      StarMenu(
        params: StarMenuParameters(
          shape: MenuShape.linear,
          openDurationMs: 60,
          linearShapeParams: const LinearShapeParams(
            angle: 270,
            alignment: LinearAlignment.left,
            space: 10,
          ),
          // calculate the offset from the dashboard center
          centerOffset: position -
              Offset(
                dashboard.dashboardSize.width / 2,
                dashboard.dashboardSize.height / 2,
              ),
        ),
        onItemTapped: (index, controller) => controller.closeMenu!(),
        parentContext: context,
        items: [
          ActionChip(
              label: const Text('Add diamond'),
              onPressed: () {
                dashboard.addElement(FlowElement(
                    position: position - const Offset(40, 40),
                    size: const Size(80, 80),
                    text: '${dashboard.elements.length}',
                    kind: ElementKind.diamond,
                    handlers: [
                      Handler.bottomCenter,
                      Handler.topCenter,
                      Handler.leftCenter,
                      Handler.rightCenter,
                    ]));
              }),
          ActionChip(
              label: const Text('Add rect'),
              onPressed: () {
                dashboard.addElement(FlowElement(
                    position: position - const Offset(50, 25),
                    size: const Size(100, 50),
                    text: '${dashboard.elements.length}',
                    kind: ElementKind.rectangle,
                    handlers: [
                      Handler.bottomCenter,
                      Handler.topCenter,
                      Handler.leftCenter,
                      Handler.rightCenter,
                    ]));
              }),
          ActionChip(
              label: const Text('Add oval'),
              onPressed: () {
                dashboard.addElement(FlowElement(
                    position: position - const Offset(50, 25),
                    size: const Size(100, 50),
                    text: '${dashboard.elements.length}',
                    kind: ElementKind.oval,
                    handlers: [
                      Handler.bottomCenter,
                      Handler.topCenter,
                      Handler.leftCenter,
                      Handler.rightCenter,
                    ]));
              }),
          ActionChip(
              label: const Text('Add parallelogram'),
              onPressed: () {
                dashboard.addElement(FlowElement(
                    position: position - const Offset(50, 25),
                    size: const Size(100, 50),
                    text: '${dashboard.elements.length}',
                    kind: ElementKind.parallelogram,
                    handlers: [
                      Handler.bottomCenter,
                      Handler.topCenter,
                    ]));
              }),

          ActionChip(
            label: const Text('Add hexagon'),
            onPressed: () {
              dashboard.addElement(FlowElement(
                position: position - const Offset(50, 25),
                size: const Size(100, 100), // Adjust size as needed
                text: '${dashboard.elements.length}',
                kind: ElementKind.hexagon, // Set kind to "polygon" for a hexagon
                handlers: [
                  Handler.bottomLeft,
                  Handler.bottomRight,
                  Handler.topLeft,
                  Handler.topRight,
                  Handler.leftCenter,
                  Handler.rightCenter,
                ],
              ));
            },
          ),







          ActionChip(
              label: const Text('Add storage'),
              onPressed: () {
                dashboard.addElement(FlowElement(
                    position: position - const Offset(50, 25),
                    size: const Size(100, 150),
                    text: '${dashboard.elements.length}',
                    kind: ElementKind.storage,
                    handlers: [
                      Handler.bottomCenter,
                      Handler.leftCenter,
                      Handler.rightCenter,
                    ]));
              }),
          // ActionChip(
          //     label: const Text('Remove all'),
          //     onPressed: () {
          //       dashboard.removeAllElements();
          //     }),
          ActionChip(
              label: const Text('SAVE dashboard'),
              onPressed: () async {
                dashboard.saveDashboard(docref);
              }),

          ActionChip(
              label: const Text('Update dashboard'),
              onPressed: () async {
                dashboard.updateDashboard(docref);
              }),
          ActionChip(
              label: const Text('LOAD dashboard'),
              onPressed: () async {
                dashboard.loadDashboard(docref);
              }),
        ],
      ),
    );
  }

  Widget listViewInFlowChart(BuildContext context, String flowname, int index) {
    return ListTile(
      title: Text(flowname),
      trailing: Icon(Icons.arrow_right_alt_outlined, color: Colors.blue.shade900),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: Container(
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.width * 0.6,
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => flowchart(
                              title: '',
                              name: global.flow[index][0], // Make sure 'index' is defined or passed as a parameter
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width * 0.17,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          color: Colors.blue.shade900,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.male_outlined,
                                size: 50.0,
                                color: Colors.white,
                              ),
                              Text(
                                "Male",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
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
                              title: '',
                              name: global.flow[index][1],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width * 0.17,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          color: Colors.blue.shade900,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.female_outlined,
                                size: 50.0,
                                color: Colors.white,
                              ),
                              Text(
                                "Female",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
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
                              title: '',
                              name: global.flow[index][2],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width * 0.17,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          color: Colors.blue.shade900,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.transgender_outlined,
                                size: 50.0,
                                color: Colors.white,
                              ),
                              Text(
                                "Others",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
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
    );
  }



}


