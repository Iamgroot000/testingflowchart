import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:testingflowchart/dashboardhomescreen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyBdVeAUpAq81ZqwOaKAISHnZlY0W84t4tw",
          authDomain: "flowchart-f936f.firebaseapp.com",
          projectId: "flowchart-f936f",
          storageBucket: "flowchart-f936f.appspot.com",
          messagingSenderId: "692451153183",
          appId: "1:692451153183:web:657476297bd5c7accacc2a",
          measurementId: "G-H7EM4VYKCV"
      )
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
            future : _initialization,
            builder: (context, snapshot){
              if(snapshot.hasError){
                print("Error");
              }
              if (snapshot.connectionState == ConnectionState.done) {
                // return HomeScreen(name: '',);
                return SimpleUI(name: "");
              }
              return CircularProgressIndicator();
            }
        )
    );
  }
}


