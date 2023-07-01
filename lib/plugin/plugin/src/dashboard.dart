// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testingflowchart/globals.dart';
import 'package:testingflowchart/widgets/toastMessage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';
import '../../../globals.dart' as global;
import 'elements/connection_params.dart';
import 'ui/draw_arrow.dart';
import 'elements/flow_element.dart';
import 'ui/grid_background.dart';

/// Class to store all the scene elements.
/// It notifies changes to [FlowChart]
class Dashboard extends ChangeNotifier {
  //FlowElement flowElement;
  List<FlowElement> elements;
  Offset dashboardPosition;
  Size dashboardSize;
  Offset handlerFeedbackOffset;
  GridBackgroundParams gridBackgroundParams;

  Dashboard()
      : elements = [],
        dashboardPosition = Offset.zero,
        dashboardSize = Size(0, 0),
        handlerFeedbackOffset = const Offset(-40, -40),
        gridBackgroundParams = const GridBackgroundParams();

  /// set grid background parameters
  setGridBackgroundParams(GridBackgroundParams params) {
    gridBackgroundParams = params;
    notifyListeners();
  }

  /// set the feedback offset to help on mobile device to see the
  /// end of arrow and not hiding behind the finger when moving it
  setHandlerFeedbackOffset(Offset offset) {
    handlerFeedbackOffset = offset;
  }

  /// set [isResizable] element property
  setElementResizable(FlowElement element, bool resizable) {
    element.isResizing = resizable;
    notifyListeners();
  }

  /// add a [FlowElement] to the dashboard
  addElement(FlowElement element, {bool notify = true}) {
    if (element.id.isEmpty) {
      element.id = const Uuid().v4();
    }
    elements.add(element);
    if (notify) {
      notifyListeners();
    }
  }

  /// find the element by its [id]
  int findElementIndexById(String id) {
    return elements.indexWhere((element) => element.id == id);
  }

  /// remove all elements
  removeAllElements() {
    elements.clear();
    notifyListeners();
  }

  /// remove the [handler] connection of [element]
  removeElementConnection(FlowElement element, Handler handler) {
    Alignment alignment;
    switch (handler) {
      case Handler.topCenter:
        alignment = const Alignment(0.0, -1.0);
        break;
      case Handler.bottomCenter:
        alignment = const Alignment(0.0, 1.0);
        break;
      case Handler.leftCenter:
        alignment = const Alignment(-1.0, 0.0);
        break;
      case Handler.rightCenter:
      default:
        alignment = const Alignment(1.0, 0.0);
    }
    element.next.removeWhere((handlerParam) =>
    handlerParam.arrowParams.startArrowPosition == alignment);
    notifyListeners();
  }

  /// remove all the connection from the [element]
  removeElementConnections(FlowElement element) {
    element.next.clear();
    notifyListeners();
  }

  /// remove all the elements with [id] from the dashboard
  removeElementById(String id) {
    // remove the element
    String elementId = '';
    elements.removeWhere((element) {
      if (element.id == id) {
        elementId = element.id;
      }
      return element.id == id;
    });

    // remove all connections to the elements found
    for (FlowElement e in elements) {
      e.next.removeWhere((handlerParams) {
        return elementId.contains(handlerParams.destElementId);
      });
    }
    notifyListeners();
  }

  /// remove element
  /// return true if it has been removed
  bool removeElement(FlowElement element) {
    // remove the element
    bool found = false;
    String elementId = element.id;
    elements.removeWhere((e) {
      if (e.id == element.id) found = true;
      return e.id == element.id;
    });

    // remove all connections to the element
    for (FlowElement e in elements) {
      e.next.removeWhere(
              (handlerParams) => handlerParams.destElementId == elementId);
    }
    notifyListeners();
    return found;
  }

  /// needed to know the diagram widget position to compute
  /// offsets for drag and drop elements
  setDashboardPosition(Offset position) {
    dashboardPosition = position;
  }

  /// needed to know the diagram widget size
  setDashboardSize(Size size) {
    dashboardSize = size;
  }

  /// make an arrow connection from [sourceElement] to
  /// the elements with id [destId]
  /// [arrowParams] definition of arrow parameters
  addNextById(FlowElement sourceElement, String destId, ArrowParams arrowParams,
      {bool notify = true}) {
    int found = 0;
    for (int i = 0; i < elements.length; i++) {
      if (elements[i].id == destId) {
        // if the [id] already exist, remove it and add this new connection
        sourceElement.next
            .removeWhere((element) => element.destElementId == destId);
        sourceElement.next.add(ConnectionParams(
          destElementId: elements[i].id,
          arrowParams: arrowParams,
          targetElementId: '',
        ));

        found++;
      }
    }

    if (found == 0) {
      debugPrint('Element with $destId id not found!');
      return;
    }
    if (notify) {
      notifyListeners();
    }
  }

  //******************************* */
  /// manage load/save using json
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'elements': elements.map((x) => x.toMap()).toList(),
    };
  }

  factory Dashboard.fromMap(Map<String, dynamic> map) {
    Dashboard d = Dashboard();
    d.elements = List<FlowElement>.from(
      (map['elements'] as List<dynamic>).map<FlowElement>(
            (x) => FlowElement.fromMap(x as Map<String, dynamic>),
      ),
    );
    return d;
  }

  /// Add the element to a group [element]
  Future<void> addElementToGroup(BuildContext context,
      FlowElement element) async {
    // Show a dialog to select a group
    String selectedGroup = global.groups.first;

    await showDialog(
      context: context,
      builder: (context) {
        // Build the dialog content
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Select a group'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < global.groups.length; i++)
                    CheckboxListTile(
                      title: Text(global.groups[i]),
                      value: global.groups[i] == selectedGroup,
                      onChanged: (value) {
                        setState(() {
                          if (value == true) {
                            selectedGroup = global.groups[i];
                            element.setGroupName(global.groups[i]);
                            element.setGroupIndex(i);
                            print('this is the index $i');
                            print("THIS IS TEST ${global.groups[i]}");
                          } else {
                            print("NOT FOUND ${global.groups[i]}");
                          }
                        });
                      },
                    ),
                ],
              ),
              actions: [
                // TextButton(
                //   onPressed: () {
                //     Navigator.pop(context);
                //   },
                //   child: Text('Cancel'),
                // ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, selectedGroup);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      },
    );

    // Add the element to the selected group and notify listeners
    print('Adding $element to $selectedGroup');
    notifyListeners();
  }

  /// Add the element to a isMandatory [element]
  Future<void> isMandatory(BuildContext context, FlowElement element) async {
    // Show a dialog to select a group
    String isMandatory = global.mandatory.last;

    await showDialog(
      context: context,
      builder: (context) {
        // Build the dialog content
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Select True or False'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < global.mandatory.length; i++)
                    CheckboxListTile(
                      title: Text(global.mandatory[i]),
                      value: global.mandatory[i] == isMandatory,
                      onChanged: (val) {
                        setState(() {
                          if (val == true) {
                            isMandatory = global.mandatory[i];
                            element.setMandatoryField(global.mandatory[i]);
                            print('this is the index $i');
                            print("THIS IS TEST ${global.mandatory[i]}");
                          } else {
                            print("NOT FOUND ${global.mandatory[i]}");
                          }
                        });
                      },
                    ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, isMandatory);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      },
    );

    // Add the element to the selected group and notify listeners
    print('Adding $element to $isMandatory');
    notifyListeners();
  }

  /// Adding the mode of the element [element]
  Future<void> setMode(BuildContext context, FlowElement element) async {
    // Show a dialog to select the mode
    String selectedMode = global.inputMode.first;

    // Show a dialog to select the answer length
    int selectedLength = 20;
    String selectedDate = "00-00-0000";

    TextEditingController numberController = TextEditingController();
    TextEditingController dateController = TextEditingController();
    TextEditingController durationController = TextEditingController();

    updateLength({required int length}) async {
      element.selectLength(length);
      Navigator.pop(context);
    }

    String options = '';
    // Set isOptional to false by default

    TextEditingController optionsController = TextEditingController();

    updateOptions({required String options}) async {
      List finalOptions = options.split("/");

      print("${finalOptions}");

      if (options.isEmpty) {
        showToast("PLEASE ENTER OPTIONS ", ToastGravity.BOTTOM);
      } else {
        showToast("SETTING OPTIONS ${options}", ToastGravity.BOTTOM);
        element.setOptions(options);
        Navigator.pop(context);
      }
    }

    await showDialog(
      context: context,
      builder: (context) {
        // Build the dialog content
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Select a Mode'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < global.inputMode.length; i++)
                    CheckboxListTile(
                      title: Text(global.inputMode[i]),
                      value: global.inputMode[i] == selectedMode,
                      onChanged: (value) {
                        setState(() {
                          if (value == true) {
                            selectedMode = global.inputMode[i];
                            element.setModeName(global.inputMode[i]);
                            print("THIS IS TEST ${global.inputMode[i]}");
                          } else {
                            print("NOT FOUND ${global.inputMode[i]}");
                          }
                        });
                      },
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  selectedMode == "numeric"
                      ? TextField(
                    keyboardType: TextInputType.number,
                    controller: numberController,
                    decoration: const InputDecoration(
                        labelText: 'Answer length (Optional)'),
                    onChanged: (value) {
                      selectedLength =
                          int.tryParse(numberController.text) ?? 50;
                    },
                  )
                      : selectedMode == "date"
                      ? TextField(
                    keyboardType: TextInputType.datetime,
                    controller: dateController,
                    onChanged: (value) {
                      selectedDate = dateController.text;
                    },
                  )
                      : selectedMode == "dateTime"
                      ? SizedBox()
                      : selectedMode == "duration"
                      ? TextField(
                    keyboardType: TextInputType.text,
                    controller: durationController,
                    onChanged: (value) {
                      selectedDate = durationController.text;
                    },
                  )
                      : selectedMode == "options"
                      ? TextField(
                    keyboardType: TextInputType.number,
                    controller: optionsController,
                    decoration: const InputDecoration(
                        labelText:
                        "Please type '/ ' after each option"),
                    onChanged: (value) {
                      options = optionsController.text;
                    },
                  )
                      : selectedMode == "multiOptions"
                      ? TextField(
                    keyboardType: TextInputType.text,
                    controller: optionsController,
                    decoration: const InputDecoration(
                        labelText:
                        "Please type '/ ' after each option"),
                    onChanged: (value) {
                      options =
                          optionsController.text;
                    },
                  )
                      : Container(
                    height: 0.1,
                  )
                ],
              ),
              actions: [
                // TextButton(
                //   onPressed: () {
                //     Navigator.pop(context);
                //   },
                //   child: Text('Cancel'),
                // ),
                TextButton(
                  onPressed: () {
                    selectedMode == "numeric"
                        ? updateLength(length: selectedLength)
                        : selectedMode == "options"
                        ? updateOptions(options: options)
                        : selectedMode == "multiOptions"
                        ? updateOptions(options: options)
                        : Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      },
    );

    // Add the mode to the element and notify listeners
    print('Adding $element to $selectedMode');
    notifyListeners();
  }

  String toJson() => json.encode(toMap());

  factory Dashboard.fromJson(String source) =>
      Dashboard.fromMap(json.decode(source) as Map<String, dynamic>);

  String prettyJson() {
    var spaces = ' ' * 2;
    var encoder = JsonEncoder.withIndent(spaces);
    return encoder.convert(toMap());
  }

  /// save the dashboard into [completeFilePath]
  final storage = FirebaseStorage.instance;

  saveDashboard(docref) async {
    try {
      final jsonData = prettyJson();
      final jsonMap = json.decode(jsonData)
      as Map<String, dynamic>; // get the formatted JSON data
      print('jsondata from flowchart');
      print(jsonData);
      await FirebaseFirestore.instance
      // .collection("TESTING")
          .collection("flowCharts")
          .doc(docref)
          .set(jsonMap);
      print("Dashboard saved to Firestore successfully!");
    } catch (e) {
      print("Error saving dashboard to Firestore : $e");
    }
  }

  updateDashboard(docref) async {
    try {
      final jsonData = prettyJson();
      final jsonMap = json.decode(jsonData)
      as Map<String, dynamic>; // get the formatted JSON data
      // print('jsondata from flowchart');
      // print(jsonData);
      await FirebaseFirestore.instance
      // .collection("TESTING")
          .collection("flowCharts")
          .doc(docref)
          .update(jsonMap);


      // await FirebaseFirestore.instance
      //     .collection("TESTING")
      //     .doc('anaemiaAssessment')
      //     .set(jsonMap);
      //
      // await FirebaseFirestore.instance
      //     .collection("flowCharts")
      //     .doc('anaemiaAssessment')
      //     .set(jsonMap);


      await FirebaseFirestore.instance
          .collection("TESTING")
          .doc('followAnaemiaAssessment')
          .update(jsonMap);

      await FirebaseFirestore.instance
          .collection("flowCharts")
          .doc('followAnaemiaAssessment')
          .update(jsonMap);


      // await FirebaseFirestore.instance
      //     .collection("flowCharts")
      //     .doc('Adult Pregnent')
      //     .set(jsonMap);


      // await FirebaseFirestore.instance
      //     .collection("flowCharts")
      //     .doc('Aged Pregnent')
      //     .set(jsonMap);
      // await FirebaseFirestore.instance
      //     .collection("flowCharts")
      //     .doc('Adolescent Pregnent')
      //     .set(jsonMap);

      // await FirebaseFirestore.instance
      //     .collection("flowCharts")
      //     .doc('Adult Pregnent')
      //     .set(jsonMap);


      // await FirebaseFirestore.instance
      //     .collection("flowCharts")
      //     .doc('Testing')
      //     .set(jsonMap);
      //
      //
      //     await FirebaseFirestore.instance
      //     .collection("flowCharts")
      //     .doc('PNC')
      //     .update(jsonMap);
      // //
      //
      //     await FirebaseFirestore.instance
      //     .collection("flowCharts")
      //     .doc('PNC_Registration')
      //     .set(jsonMap);


      // await FirebaseFirestore.instance
      //     // .collection("flowCharts")
      //     .collection("TESTING")
      //     .doc('NeoNatal Male')
      //     .set(jsonMap);
      //
      // //
      // await FirebaseFirestore.instance
      // // .collection("flowCharts")
      //     .collection("TESTING")
      //     .doc('NeoNatal Female')
      //     .update(jsonMap);
      // //
      // await FirebaseFirestore.instance
      // .collection("flowCharts")
      // //     .collection("TESTING")
      //     .doc('Toddler Male')
      //     .update(jsonMap);
      // //
      //  await FirebaseFirestore.instance
      //  // .collection("flowCharts")
      //      .collection("TESTING")
      //     .doc('Toddler Female')
      //     .update(jsonMap);

      // await FirebaseFirestore.instance
      // // .collection("flowCharts")
      //     .collection("TESTING")
      //     .doc('Pediatric Male')
      //     .set(jsonMap);
      // //
      // //
      // await FirebaseFirestore.instance
      // // .collection("flowCharts")
      //     .collection("TESTING")
      //     .doc('Pediatric Female')
      //     .set(jsonMap);

      /// FEMALE QUESTIONS WHICH IS SAME FOR ALL THE GROUP

      // await FirebaseFirestore.instance
      // // .collection("flowCharts")
      //     .collection("TESTING")
      //     .doc('Adolescent Male')
      //     .set(jsonMap);
      //
      // await FirebaseFirestore.instance
      //     // .collection("flowCharts")
      //     .collection("TESTING")
      //     .doc('adultMale(18y-30y)')
      //     .update(jsonMap);
      // //
      // //
      // await FirebaseFirestore.instance
      // // .collection("flowCharts")
      //     .collection("TESTING")
      //     .doc('adultMale(31y-45y)')
      // // .update(jsonMap);
      //     .set(jsonMap);
      // //
      // //
      // await FirebaseFirestore.instance
      // // .collection("flowCharts")
      //     .collection("TESTING")
      //     .doc('middleAgedMale(46y-60y)')
      // // .update(jsonMap);
      //     .set(jsonMap);
      //
      //
      // await FirebaseFirestore.instance
      // // .collection("flowCharts")
      //     .collection("TESTING")
      //     .doc('agedAdultMale(61y-70y)')
      // // .update(jsonMap);
      //     .set(jsonMap);
      //
      //
      // await FirebaseFirestore.instance
      // // .collection("flowCharts")
      //     .collection("TESTING")
      //     .doc('oldAgedMale(71Y-80Y)')
      // // .update(jsonMap);
      //     .set(jsonMap);
      //
      //
      // await FirebaseFirestore.instance
      // // .collection("flowCharts")
      //     .collection("TESTING")
      //     .doc('80+Male')
      //     // .update(jsonMap);
      //     .set(jsonMap);

      /// FEMALE QUESTIONS WHICH IS SAME FOR ALL THE GROUP
      //
      // await FirebaseFirestore.instance
      // // .collection("flowCharts")
      //     .collection("TESTING")
      //     .doc('Adolescent Female')
      //     .update(jsonMap);
      //
      //
      //
      // await FirebaseFirestore.instance
      // .collection("flowCharts")
      // //     .collection("TESTING")
      //     .doc('adultFemale(18y-30y)')
      //     .update(jsonMap);
      //
      //
      //
      // await FirebaseFirestore.instance
      // .collection("flowCharts")
      //     // .collection("TESTING")
      //     .doc('adultFemale(31y-45y)')
      //     .update(jsonMap);
      //
      //
      //
      // await FirebaseFirestore.instance
      // .collection("flowCharts")
      //     // .collection("TESTING")
      //     .doc('middleAgedFemale(46y-60y)')
      //     .update(jsonMap);
      //
      //
      //
      // await FirebaseFirestore.instance
      // .collection("flowCharts")
      //     // .collection("TESTING")
      //     .doc('agedAdultFemale(61y-70y)')
      //     .update(jsonMap);
      //
      //
      //
      // await FirebaseFirestore.instance
      // .collection("flowCharts")
      //     // .collection("TESTING")
      //     .doc('oldAgedFemale(71Y-80Y)')
      //     .update(jsonMap);
      //
      //
      //
      // await FirebaseFirestore.instance
      // .collection("flowCharts")
      //     // .collection("TESTING")
      //     .doc('80+female')
      //     .update(jsonMap);

      print("Dashboard saved to Firestore successfully!");

      // final file = File('/path/to/Flowchart.json');
      // final storageRef = storage.ref().child('flowcharts/Flowchart.json');
      // await storageRef.putFile(file);
      // print('File uploaded successfully!');
    } catch (e) {
      print("Error saving dashboard to Firestore : $e");
    }
  }

  /// clear the dashboard and load the new one

  loadDashboard(docref) async {
    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection("flowCharts")
      // .collection("TESTING")
          .doc(docref)
          .get();


      // await FirebaseFirestore.instance
      //     .collection("TESTING")
      //     .doc(docref)
      //     .get();

      if (!docSnapshot.exists) {
        print("Dashboard data does not exist in Firestore.");
        return;
      }

      final jsonMap = docSnapshot.data() as Map<String, dynamic>;
      final jsonData = json.encode(jsonMap);

      // print('jsondata from Firestore');
      // print(jsonData);

      // Decode the JSON data into FlowElement objects
      List<FlowElement> all = List<FlowElement>.from(
        (json.decode(jsonData)['elements'] as List<dynamic>).map<FlowElement>(
              (x) => FlowElement.fromMap(x as Map<String, dynamic>),
        ),
      );

      // Add the FlowElement objects to the elements list
      elements.clear();
      for (int i = 0; i < all.length; i++) {
        addElement(all.elementAt(i));
      }
      notifyListeners();
    } catch (e) {
      print("Error loading dashboard from Firestore: $e");
    }
  }


}