import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/provider/todoProvider.dart';
import 'package:notes_app/screens/home_screen.dart';
import 'package:notes_app/screens/loading_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => TodoProvider())],
      child: GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: LoginPage(),
        initialRoute: '/login',
        routes: {
        '/login':(context)=> LoginPage(),
        '/home':(context)=>HomeView()
      },
      ),
    );
  }
}
