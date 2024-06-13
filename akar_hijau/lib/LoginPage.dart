import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart'; // Tambahkan import ini
import 'package:akar_hijau/HomePage.dart'; // Pastikan lokasi import ini sesuai dengan struktur proyek Anda
import 'package:akar_hijau/RegistrationPage.dart'; // Pastikan lokasi import ini sesuai dengan struktur proyek Anda

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  // Fungsi untuk memeriksa status login
  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  // Fungsi untuk handle login
  Future<void> _login() async {
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      _showErrorDialog(
          "Kolom Kosong", "Harap isi kedua kolom username dan password.");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Kirim data ke server menggunakan HTTP POST
      var response = await http.post(
        Uri.parse('http://192.168.125.48:3001/api/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': _usernameController.text,
          'password': _passwordController.text,
        }),
      );

      // Periksa respon dari server
      if (response.statusCode == 200) {
        // Jika login berhasil, simpan status login dan lanjutkan ke halaman beranda
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        // Jika login gagal, tampilkan pesan kesalahan
        _showErrorDialog("Kredensial Salah", "Username atau password salah.");
      }
    } catch (e) {
      // Tangani kesalahan jika ada
      print("Error: $e");
      _showErrorDialog(
          "Terjadi Kesalahan", "Terjadi kesalahan saat menghubungi server.");
    }

    setState(() {
      _isLoading = false;
    });
  }

  // Fungsi untuk menampilkan dialog kesalahan
  void _showErrorDialog(String title, String content) {
    // Pindahkan pemanggilan setState untuk memastikan status loading diperbarui
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    });
  }

  // Widget untuk logo
  Widget _buildLogo() {
    return Padding(
      padding: EdgeInsets.only(bottom: 40.0),
      child: Image.asset(
        'assets/login_icon.png',
        width: 250,
        height: 300,
      ),
    );
  }

  // Widget untuk form login
  Widget _buildLoginForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: _usernameController,
          decoration: InputDecoration(
            labelText: 'Username',
            prefixIcon: Icon(Icons.alternate_email),
          ),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[a-z]'))
          ], // Hanya huruf kecil
        ),
        SizedBox(height: 20.0),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: Icon(Icons.lock),
          ),
        ),
        SizedBox(height: 20.0),
        _isLoading
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: _login,
                child: Text('Sign In'),
              ),
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Belum punya akun? "),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationPage()),
                );
              },
              child: Text('Registrasi'),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Tutup keyboard ketika mengetuk di luar kolom teks
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Login',
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLogo(),
                  SizedBox(height: 20.0),
                  _buildLoginForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
