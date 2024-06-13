import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  bool _isLoading = false;

  Future<void> _register() async {
    if (_usernameController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _nameController.text.isEmpty ||
        _emailController.text.isEmpty) {
      _showErrorDialog("Kolom Kosong", "Harap isi semua kolom.");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      var response = await http.post(
        Uri.parse('http://192.168.125.48:3001/api/add'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': _usernameController.text,
          'password': _passwordController.text,
          'name': _nameController.text,
          'level': 'user', // Set level to 'user' by default
          'email': _emailController.text,
        }),
      );

      if (response.statusCode == 200) {
        // Jika registrasi berhasil
        Navigator.pop(context); // Kembali ke halaman sebelumnya (LoginPage)
      } else {
        // Jika registrasi gagal
        _showErrorDialog(
            "Gagal Registrasi", "Terjadi kesalahan saat registrasi.");
      }
    } catch (e) {
      print("Error: $e");
      _showErrorDialog(
          "Terjadi Kesalahan", "Terjadi kesalahan saat menghubungi server.");
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _showErrorDialog(String title, String content) {
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

  Widget _buildRegistrationForm() {
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
            FilteringTextInputFormatter.allow(RegExp(r'[a-z]')),
          ],
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
        TextField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: 'Nama Panggilan',
            prefixIcon: Icon(Icons.person_outline),
          ),
        ),
        SizedBox(height: 20.0),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            prefixIcon: Icon(Icons.email),
          ),
        ),
        SizedBox(height: 20.0),
        _isLoading
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: _register,
                child: Text('Register'),
              ),
        SizedBox(height: 10.0),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya (LoginPage)
          },
          child: Text('Batal'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Register',
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
              child: _buildRegistrationForm(),
            ),
          ),
        ),
      ),
    );
  }
}
