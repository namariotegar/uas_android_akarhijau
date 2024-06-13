import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SearchPage.dart';
import 'PostingPage.dart';
import 'ProfilPage.dart';
import 'LoginPage.dart';
import 'ContentHome.dart'; // Import the new ContentHome widget

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool isLoggedIn;
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    ContentHome(), // Use the new ContentHome widget here
    SearchPage(),
    PostingPage(),
    ProfilPage(),
  ];

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loggedIn = prefs.getBool('isLoggedIn') ?? false;
    setState(() {
      isLoggedIn = loggedIn;
    });
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        title: Text(
          "Akar Hijau",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
            color: Color.fromARGB(215, 37, 202, 0),
          ),
        ),
        centerTitle: true,
        elevation: 4.0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0), // The height of the bottom line
          child: Container(
            color: Colors.grey, // The color of the bottom line
            height: 1.0, // The thickness of the bottom line
          ),
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 32,
            ),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search_outlined,
              size: 32,
            ),
            label: 'Cari',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_box_outlined,
              size: 32,
            ),
            label: 'Posting',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outlined,
              size: 32,
            ),
            label: 'Profil',
          ),
        ],
        selectedItemColor: Color.fromARGB(255, 1, 167, 26),
        unselectedItemColor: Color.fromARGB(255, 0, 0, 0).withOpacity(0.6),
      ),
    );
  }
}
