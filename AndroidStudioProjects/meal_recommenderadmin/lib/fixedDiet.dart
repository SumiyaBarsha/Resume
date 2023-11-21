import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON decoding


Future<List<dynamic>> fetchMealPlans() async {
  var response = await http.get(Uri.parse('https://spoonacular.com/food-api/mealplans'));
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load meal plans');
  }
}


class DietPlanPage extends StatefulWidget {
  @override
  _DietPlanPage createState() => _DietPlanPage();
}

class _DietPlanPage extends State<DietPlanPage> {
  int _selectedIndex = 0;
  late Future<List<dynamic>> mealPlans;
  @override
  void initState() {
    super.initState();
    mealPlans = fetchMealPlans();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Add navigation logic here
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('MealBuddy',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          // Your header section here
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Choose your perfect diet plan',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 16.00,
              ),
            ),
          ),
          // Horizontally scrollable cards
          Container(
            height: 220, // Adjust the height to fit your design
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('BALANCED', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Expanded(
                  child:FutureBuilder<List<dynamic>>(
                      future: mealPlans,
                      builder: (context, snapshot){
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        } else if (snapshot.hasData) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              var mealPlan = snapshot.data![index];
                              return buildCard(mealPlan['imageUrl'], mealPlan['title'], mealPlan['subtitle']);
                            },
                          );
                        }else {
                          return Text('No meal plans found');
                        }
                      }
                  )
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 220, // Adjust the height to fit your design
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('FASTING', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5, // Number of items in the horizontal list for this section
                    itemBuilder: (context, index) {
                      return buildCard(
                        'https://via.placeholder.com/150',
                        'Title $index', // Replace with actual titles
                        'Subtitle $index', // Replace with actual subtitles
                      );
                    },
                  ),

                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 220, // Adjust the height to fit your design
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('KETO/LOW CARB', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5, // Number of items in the horizontal list for this section
                    itemBuilder: (context, index) {
                      return buildCard(
                        'https://via.placeholder.com/150',
                        'Title $index', // Replace with actual titles
                        'Subtitle $index', // Replace with actual subtitles
                      );
                    },
                  ),

                ),
              ],
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget buildCard(String imageUrl, String title, String subtitle) {
    return InkWell(
      onTap: () {
        // Handle the tap, navigate to a new screen or display a message
        print('Card tapped!');
      },
      child: Card(
        margin: EdgeInsets.all(8.0),
        child: Container(
          width: 160, // Adjust the width to fit your design
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(
                imageUrl,
                height: 120, // Adjust the height to fit your design
                width: 160,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(subtitle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
