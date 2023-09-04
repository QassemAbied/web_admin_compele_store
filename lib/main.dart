import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:web_admin_compele_store/screens/header_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  await Firebase.initializeApp(
    options:  FirebaseOptions(
        apiKey: "AIzaSyBM7TCYVl5k6LLxQc_arhTQxHx43VxhOMs",
        authDomain: "fire-store-e5379.firebaseapp.com",
        projectId: "fire-store-e5379",
        storageBucket: "fire-store-e5379.appspot.com",
        messagingSenderId: "233002367467",
        appId: "1:233002367467:web:e72a4a3cc4e4f6b4c101ae",
        measurementId: "G-H2851CLYM1"
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  SamplePage(),
    );
  }
}

