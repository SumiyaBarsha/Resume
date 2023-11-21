import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meal_recommenderadmin/fixedDiet.dart';
import 'AdminRecipePage.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

    options: DefaultFirebaseOptions.currentPlatform,

  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MealBuddy_Admin',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DietPlanPage(), // Your AdminRecipePage is set as the home page
      // You can also use routes to navigate to different screens
    );
  }
}
