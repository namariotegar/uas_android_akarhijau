import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LoginPage.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({Key? key}) : super(key: key);

  // Method to create a vertical space
  Widget verticalSpace(double height) {
    return SizedBox(height: height);
  }

  // Method to create a text widget with given text, font size, and boldness
  Widget profileText(
      String text, double fontSize, bool isBold, TextAlign alignment) {
    return Text(
      text,
      textAlign: alignment,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  // Method to handle logout
  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            verticalSpace(40), // Using verticalSpace method to add space
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Container(
                      width: 180.0,
                      height: 180.0,
                      color: Colors.grey, // You can replace with your image
                      child: Image.asset(
                        'assets/profile_avatar.png', // Make sure this path is correct
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  verticalSpace(40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 125, // Adjust this width to your preference
                        child:
                            profileText("Username", 20, true, TextAlign.right),
                      ),
                      SizedBox(
                          width:
                              175), // Adding some space between "Nama:" and the name
                      Expanded(
                        child:
                            profileText("@yudi_fer", 20, false, TextAlign.left),
                      ),
                    ],
                  ),
                  verticalSpace(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 90, // Adjust this width to your preference
                        child: profileText("Nama", 20, true, TextAlign.right),
                      ),
                      SizedBox(
                          width:
                              190), // Adding some space between "Nama:" and the name
                      Expanded(
                        child: profileText(
                            "Yudi Ferdian", 20, false, TextAlign.left),
                      ),
                    ],
                  ),
                  verticalSpace(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 88, // Adjust this width to your preference
                        child: profileText("Email", 20, true, TextAlign.right),
                      ),
                      SizedBox(
                          width:
                              80), // Adding some space between "Nama:" and the name
                      Expanded(
                        child: profileText("yudiferdian12@gmail.com", 20, false,
                            TextAlign.left),
                      ),
                    ],
                  ),
                  verticalSpace(35),
                  ElevatedButton(
                    onPressed: () => _logout(context),
                    child: Text('Logout'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
