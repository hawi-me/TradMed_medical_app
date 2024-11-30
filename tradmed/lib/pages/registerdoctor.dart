import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RegisterDoctorPage extends StatefulWidget {
  @override
  _RegisterDoctorPageState createState() => _RegisterDoctorPageState();
}

class _RegisterDoctorPageState extends State<RegisterDoctorPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _specialtyController = TextEditingController();
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

  void submitForm() async {
    if (_formKey.currentState!.validate() && selectedFilePath != null) {
      try {
        // Upload file to Firebase Storage
        final fileName = selectedFilePath!.split('/').last;
        final storageRef =
            FirebaseStorage.instance.ref().child('certificates/$fileName');
        final uploadTask = await storageRef.putFile(File(selectedFilePath!));

        // Get the uploaded file's download URL
        final fileUrl = await uploadTask.ref.getDownloadURL();

        // Save form data to Firestore
        final data = {
          'name': _nameController.text,
          'specialty': _specialtyController.text,
          'working_status': _selectedStatus,
          'certificate_url': fileUrl,
          'timestamp': FieldValue.serverTimestamp(),
        };


        await FirebaseFirestore.instance.collection('doctors').add(data);

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Form submitted successfully!')));

        // Clear the form
        _formKey.currentState!.reset();
        _nameController.clear();
        _specialtyController.clear();
        setState(() {
          selectedFilePath = null;
          _selectedStatus = "Part-time";
        });
        print(data);
      } catch (e) {
        print('Error submitting form: $e');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Failed to submit the form. Please try again.')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please complete the form and upload a file.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register as Doctor')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter your name'
                      : null,
                ),
                TextFormField(
                  controller: _specialtyController,
                  decoration: InputDecoration(labelText: 'Specialty'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter your specialty'
                      : null,
                ),
                ElevatedButton(
                  onPressed: pickFile,
                  child: Text(selectedFilePath == null
                      ? 'Upload Certificate'
                      : 'Selected: ${selectedFilePath!.split('/').last}'),
                ),
                const SizedBox(height: 20),
                experiance(context),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: submitForm,
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget experiance(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Working Status",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        RadioListTile<String>(
          title: const Text("Part-time"),
          value: "Part-time",
          groupValue: _selectedStatus,
          onChanged: (value) {
            setState(() {
              _selectedStatus = value;
            });
          },
        ),
        RadioListTile<String>(
          title: const Text("Full-time"),
          value: "Full-time",
          groupValue: _selectedStatus,
          onChanged: (value) {
            setState(() {
              _selectedStatus = value;
            });
          },
        ),
        RadioListTile<String>(
          title: const Text("Unemployed"),
          value: "Unemployed",
          groupValue: _selectedStatus,
          onChanged: (value) {
            setState(() {
              _selectedStatus = value;
            });
          },
        ),
        const SizedBox(height: 16),
        Text(
          "Selected: $_selectedStatus",
          style: TextStyle(fontSize: 16, color: Colors.blue),
        ),
      ],
    );
  }
}
