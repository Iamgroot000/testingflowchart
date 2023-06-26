import 'dart:convert';

import 'package:flutter/material.dart';

import 'connection_params.dart';

enum ElementKind {
  rectangle,
  diamond,
  storage,
  oval,
  parallelogram, hexagon, custom, polygon,
}

enum Handler {
  topCenter,
  bottomCenter,
  rightCenter,
  leftCenter, bottomLeft, bottomRight, topLeft, topRight,
}

/// Class to store [ElementWidget]s and notify its changes
class FlowElement extends ChangeNotifier {
  /// Unique id set when adding a [FlowElement] with [Dashboard.addElement()]
  String id;

  /// The position of the [FlowElement]
  Offset position;

  /// The size of the [FlowElement]
  Size size;

  /// Element text
  String text;

  /// Text color
  Color textColor;

  /// Text size
  double textSize;

  /// Makes text bold if true
  bool textIsBold;

  /// Element shape
  ElementKind kind;

  /// Connection handlers
  List<Handler> handlers;

  /// The size of element handlers
  double handlerSize;

  /// Background color of the element
  Color backgroundColor;

  /// Border color of the element
  Color borderColor;

  /// Border thickness of the element
  double borderThickness;

  /// Shadow elevation
  double elevation;

  /// List of connections of this element
  List<ConnectionParams> next;

  /// Element text
  bool isResizing;

  /// The selected group for this element
  String selectedGroup;

  /// The selected group index for this element
  int groupIndex;

  /// The selected Mode for this element
  String selectedMode;

  /// The selected length for this element's answer
  int selectedLength;




  /// STRING FOR MANDATORY QUESTIONS IN FLOWCHART
  String isMandatory;






  /// The selected length for this element's answer
  String options;

  FlowElement({
    this.position = Offset.zero,
    this.size = Size.infinite,
    this.text = '',
    this.selectedGroup= '',
    this.groupIndex= 0,
    this.selectedMode= '',

    ///
    this.isMandatory = '',

    this.options = "",
    this.selectedLength=50,
    this.textColor = Colors.black,
    this.textSize = 14,
    this.textIsBold = false,
    this.kind = ElementKind.rectangle,
    this.handlers = const [
      Handler.topCenter,
      Handler.bottomCenter,
      Handler.rightCenter,
      Handler.leftCenter,
    ],
    this.handlerSize = 15.0,
    this.backgroundColor = Colors.white,
    this.borderColor = Colors.blue,
    this.borderThickness = 3,
    this.elevation = 4,
    next,
  })  : next = next ?? [],
        id = '',
        isResizing = false;

  @override
  String toString() {
    return 'kind: $kind  text: $text';
  }

  /// When setting to true, a handler will disply at the element bottom right
  /// to let the user to resize it. When finish it will disappear.
  setIsResizing(bool resizing) {
    isResizing = resizing;
    notifyListeners();
  }

  /// Used internally to set an unique Uuid to this element
  setId(String id) {
    this.id = id;
  }

  /// Set text
  setText(String text) {
    this.text = text;
    notifyListeners();
  }

  /// SET GROUP NAME
  setGroupName(String groupName){
    this.selectedGroup = groupName;
    notifyListeners();
  }

  setGroupIndex(int index){
    this.groupIndex = index;
    notifyListeners();
  }

  setOptions(String options){
    this.options = options;
    notifyListeners();
  }


  setModeName(String modeName){
    this.selectedMode = modeName;
    notifyListeners();
  }

  selectLength(int selectedLength){
    this.selectedLength = selectedLength;
    notifyListeners();
  }


  /// Set text color
  setTextColor(Color color) {
    textColor = color;
    notifyListeners();
  }

  /// Set text size
  setTextSize(double size) {
    textSize = size;
    notifyListeners();
  }

  /// Set text bold
  setTextIsBold(bool isBold) {
    textIsBold = isBold;
    notifyListeners();
  }


  ///
  ///
  ///

  /// STRING MANDATORY

  setMandatoryField(String isMandatory){
    this.isMandatory = isMandatory;
    notifyListeners();
  }

  ///
  ///
  ///








  /// Set background color
  setBackgroundColor(Color color) {
    backgroundColor = color;
    notifyListeners();
  }

  /// Set border color
  setBorderColor(Color color) {
    borderColor = color;
    notifyListeners();
  }

  /// Set border thickness
  setBorderThickness(double thickness) {
    borderThickness = thickness;
    notifyListeners();
  }

  /// Set elevation
  setElevation(double elevation) {
    this.elevation = elevation;
    notifyListeners();
  }

  /// Change element position in the dashboard
  changePosition(Offset newPosition) {
    position = newPosition;
    notifyListeners();
  }

  /// Change element size
  changeSize(Size newSize) {
    if (newSize.width < 40) newSize = Size(40, newSize.height);
    if (newSize.height < 40) newSize = Size(newSize.width, 40);
    size = newSize;
    notifyListeners();
  }

  @override
  bool operator ==(covariant FlowElement other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }

  @override
  int get hashCode {
    return position.hashCode ^
    size.hashCode ^
    text.hashCode ^
    selectedGroup.hashCode^
    groupIndex.hashCode^
    options.hashCode^
    selectedMode.hashCode^
    selectedLength.hashCode^
    textColor.hashCode ^
    textSize.hashCode ^
    textIsBold.hashCode ^
    id.hashCode ^
    kind.hashCode ^
    handlers.hashCode ^
    handlerSize.hashCode ^
    backgroundColor.hashCode ^
    borderColor.hashCode ^
    borderThickness.hashCode ^
    elevation.hashCode ^
    next.hashCode^
    isMandatory.hashCode;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'positionDx': position.dx,
      'positionDy': position.dy,
      'size.width': size.width,
      'size.height': size.height,
      'text': text,

      ///CUSTOM FIELDS - START

      'selectedGroup': selectedGroup,
      'options': options,
      'groupIndex': groupIndex,
      'selectedMode': selectedMode,
      'selectedLength': selectedLength,
      'isMandatory' : isMandatory,

      ///CUSTOM FIELDS - END

      'textColor': textColor.value,
      'textSize': textSize,
      'textIsBold': textIsBold,
      'id': id,
      'kind': kind.index,
      'handlers': handlers.map((x) => x.index).toList(),
      'handlerSize': handlerSize,
      'backgroundColor': backgroundColor.value,
      'borderColor': borderColor.value,
      'borderThickness': borderThickness,
      'elevation': elevation,
      'next': next.map((x) => x.toMap()).toList(),
    };
  }

  factory FlowElement.fromMap(Map<String, dynamic> map) {
    FlowElement e = FlowElement(
      position: Offset(
        map['positionDx'] as double,
        map['positionDy'] as double,
      ),
      size: Size(map['size.width'] as double, map['size.height'] as double),
      text: map['text'] as String,


      ///Added extra fields in the plugin
      selectedGroup: map['selectedGroup'] as String,
      groupIndex: map['groupIndex'] as int ,
      selectedMode: map['selectedMode'] as String,
      selectedLength: map['selectedLength'] as int,
      options: map['options'] as String,
      isMandatory : map['isMandatory'] as String,

      textColor: Color(map['textColor'] as int),
      textSize: map['textSize'] as double,
      textIsBold: map['textIsBold'] as bool,
      kind: ElementKind.values[map['kind'] as int],
      handlers: List<Handler>.from(
        (map['handlers'] as List<dynamic>).map<Handler>(
              (x) => Handler.values[x],
        ),
      ),
      handlerSize: map['handlerSize'] as double,
      backgroundColor: Color(map['backgroundColor'] as int),
      borderColor: Color(map['borderColor'] as int),
      borderThickness: map['borderThickness'] as double,
      elevation: map['elevation'] as double,
      next: List<ConnectionParams>.from(
        (map['next'] as List<dynamic>).map<dynamic>(
              (x) => ConnectionParams.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
    e.setId(map['id'] as String);
    return e;
  }

  String toJson() => json.encode(toMap());

  factory FlowElement.fromJson(String source) =>
      FlowElement.fromMap(json.decode(source) as Map<String, dynamic>);
}
