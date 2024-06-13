import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class PostingPage extends StatefulWidget {
  const PostingPage({Key? key}) : super(key: key);

  @override
  _PostingPageState createState() => _PostingPageState();
}

class _PostingPageState extends State<PostingPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _stepsController =
      TextEditingController(text: '1. ');
  final TextEditingController _equipmentController =
      TextEditingController(text: '1. ');

  // Method untuk mengirim data postingan ke server
  Future<void> _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        var response = await http.post(
          Uri.parse('http://192.168.125.48:3001/api/add_post'),
          body: {
            'posting_title': _titleController.text,
            'author': _authorController.text,
            'equipment': _equipmentController.text,
            'steps': _stepsController.text,
          },
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Post submitted successfully!')),
          );
          _formKey.currentState!.reset();
          _stepsController.text = '1. ';
          _equipmentController.text = '1. '; // Reset steps to initial value
        } else {
          String errorMessage = 'Failed to submit post';
          if (response.statusCode == 400) {
            errorMessage = 'Bad request. Please check your data and try again.';
          } else if (response.statusCode == 404) {
            errorMessage =
                'Server not found. Please check your network connection.';
          } else {
            errorMessage =
                'Error ${response.statusCode}. Please try again later.';
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage)),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      }
    }
  }

  void _addStep() {
    final text = _stepsController.text;
    final lines = text.split('\n');
    final nextStepNumber = lines.length + 1;
    final newText =
        text.isEmpty ? '$nextStepNumber. ' : '$text\n$nextStepNumber. ';
    _stepsController.text = newText;
    _stepsController.selection = TextSelection.fromPosition(
      TextPosition(offset: _stepsController.text.length),
    );
  }

  void _addEquipment() {
    final text = _equipmentController.text;
    final lines = text.split('\n');
    final nextStepNumber = lines.length + 1;
    final newText =
        text.isEmpty ? '$nextStepNumber. ' : '$text\n$nextStepNumber. ';
    _equipmentController.text = newText;
    _equipmentController.selection = TextSelection.fromPosition(
      TextPosition(offset: _equipmentController.text.length),
    );
  }

  // void _addEquipment() {
  //   final text = _equipmentController.text;
  //   final lines = text.split('\n');
  //   final nextEquipmentNumber = lines.length + 1;
  //   final newText = text.isEmpty
  //       ? '$nextEquipmentNumber. '
  //       : '$text\n$nextEquipmentNumber. ';
  //   _equipmentController.text = newText;
  //   _equipmentController.selection = TextSelection.fromPosition(
  //     TextPosition(offset: _equipmentController.text.length),
  //   );
  // }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _equipmentController.dispose();
    _stepsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, // Center the title
        title: Text(
          'Postingan Baru',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Make the text slightly bold
            fontSize: 26, // Set the font size to 20 (adjust as needed)
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Judul Postingan'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan judul postingan';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _authorController,
                decoration: InputDecoration(labelText: 'Nama Pembuat'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon masukkan pemosting';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _equipmentController,
                decoration: InputDecoration(
                  labelText: 'Peralatan',
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: InkWell(
                      onTap: _addEquipment,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey),
                          color: Colors.blue, // Warna tombol
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child:
                            Icon(Icons.add, color: Colors.white), // Warna ikon
                      ),
                    ),
                  ),
                ),
                maxLines: 8,
                inputFormatters: [StepsInputFormatter()],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan peralatan';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _stepsController,
                decoration: InputDecoration(
                  labelText: 'Langkah-langkah',
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: InkWell(
                      onTap: _addStep,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey),
                          color: Colors.blue, // Warna tombol
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child:
                            Icon(Icons.add, color: Colors.white), // Warna ikon
                      ),
                    ),
                  ),
                ),
                maxLines: 8,
                inputFormatters: [StepsInputFormatter()],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan peralatan';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _submitForm(context),
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StepsInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.startsWith('1. ')) {
      return newValue;
    } else {
      return oldValue;
    }
  }
}
