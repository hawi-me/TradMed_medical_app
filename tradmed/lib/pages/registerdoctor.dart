import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class RegisterDoctorPage extends StatefulWidget {
  @override
  _RegisterDoctorPageState createState() => _RegisterDoctorPageState();
}

class _RegisterDoctorPageState extends State<RegisterDoctorPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _specialtyController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  String? selectedFilePath;
  String? _selectedStatus = "Part-time";

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['pdf', 'jpg', 'png']);
    if (result != null) {
      setState(() {
        selectedFilePath = result.files.single.path;
      });
    }
  }

  void submitForm() {
    if (_formKey.currentState!.validate() && selectedFilePath != null) {
      // Simulate success without Firebase
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Form submitted successfully!')),
      );

      // Clear the form
      _formKey.currentState!.reset();
      _nameController.clear();
      _specialtyController.clear();
      _emailController.clear();
      _phoneController.clear();
      setState(() {
        selectedFilePath = null;
        _selectedStatus = "Part-time";
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please complete the form and upload a file.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register as Doctor'),
        // automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Check if there is a previous screen
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              // Optionally handle cases where there's no screen to pop
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('No previous screen!')),
              );
            }
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Register as Doctor',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter your name'
                            : null,
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _specialtyController,
                        decoration: InputDecoration(
                          labelText: 'Specialty',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter your specialty'
                            : null,
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value == null ||
                                value.isEmpty ||
                                !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)
                            ? 'Please enter a valid email'
                            : null,
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter your phone number'
                            : null,
                      ),
                      SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: pickFile,
                        child: Text(selectedFilePath == null
                            ? 'Upload Certificate'
                            : 'Selected: ${selectedFilePath!.split('/').last}'),
                      ),
                      SizedBox(height: 20),
                      workingStatus(context),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: submitForm,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget workingStatus(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Working Status",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        RadioListTile<String>(
          title: Text("Part-time"),
          value: "Part-time",
          groupValue: _selectedStatus,
          onChanged: (value) {
            setState(() {
              _selectedStatus = value;
            });
          },
        ),
        RadioListTile<String>(
          title: Text("Full-time"),
          value: "Full-time",
          groupValue: _selectedStatus,
          onChanged: (value) {
            setState(() {
              _selectedStatus = value;
            });
          },
        ),
        RadioListTile<String>(
          title: Text("Unemployed"),
          value: "Unemployed",
          groupValue: _selectedStatus,
          onChanged: (value) {
            setState(() {
              _selectedStatus = value;
            });
          },
        ),
        SizedBox(height: 8),
        Text(
          "Selected: $_selectedStatus",
          style: TextStyle(fontSize: 16, color: Colors.blue),
        ),
      ],
    );
  }
}
