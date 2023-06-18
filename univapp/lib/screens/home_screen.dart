import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_signin/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> universities = [];
  List<dynamic> filteredUniversities = [];

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUniversities();
  }

  Future<void> fetchUniversities() async {
    final response = await http.get(
        Uri.parse('http://universities.hipolabs.com/search?country=India'));
    if (response.statusCode == 200) {
      setState(() {
        universities = json.decode(response.body);
        filteredUniversities = universities;
      });
    } else {
      print('Failed to fetch universities');
    }
  }

  void filterUniversities(String query) {
    setState(() {
      filteredUniversities = universities
          .where((university) =>
              university['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Universities List (Home Page)',
          style: TextStyle(
            fontSize: 17,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(100, 100, 0, 0),
                items: [
                  PopupMenuItem(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Profile Details',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ListTile(
                          title: Text('Email Id: ${user?.email ?? ""}'),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          IconButton(
            onPressed: signOut,
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: filterUniversities,
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: Scrollbar(
              child: ListView.builder(
                itemCount: filteredUniversities.length,
                itemBuilder: (context, index) {
                  final university = filteredUniversities[index];
                  return ListTile(
                    title: Text(university['name']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              UniversityDetailsPage(university: university),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UniversityDetailsPage extends StatelessWidget {
  final dynamic university;

  const UniversityDetailsPage({Key? key, required this.university})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('University Details Page'),
      ),
      body: Center(
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/college.png', // Replace with the path to your local logo image
                      height: 150,
                      width: 150,
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Center(
                child: Text(
                  'Name: ${university['name']}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Center(
                child: Text(
                  'Country: ${university['country']}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Center(
                child: Text(
                  'State-Province: ${university['state-province']}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Center(
                child: Text(
                  'Domain: ${university['domains']}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Center(
                child: Text(
                  'State Alpha Code: ${university['alpha_two_code']}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: GestureDetector(
                onTap: () {
                  launch(university['web_pages'][0]);
                },
                child: Center(
                  child: Text(
                    'Web Page: ${university['web_pages'][0]}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      decoration: TextDecoration.underline,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
