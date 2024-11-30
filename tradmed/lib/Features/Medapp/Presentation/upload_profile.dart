import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileUploadPage extends StatefulWidget {
  @override
  _ProfileUploadPageState createState() => _ProfileUploadPageState();
}

class _ProfileUploadPageState extends State<ProfileUploadPage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  bool _isUploading = false;
  String? _downloadUrl;

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_image == null) return;

    setState(() {
      _isUploading = true;
    });

    try {
      // Get a reference to Firebase Storage
      final userId = FirebaseAuth.instance.currentUser?.uid;
      final storageRef = FirebaseStorage.instance.ref().child('profile_pictures/$userId.jpg');

      // Ensure the file exists before uploading
      File imageFile = File(_image!.path);

      // Check if the file exists at the path
      if (!imageFile.existsSync()) {
        print('File does not exist at path: ${_image!.path}');
        throw Exception('File does not exist at path: ${_image!.path}');
      }

      // Upload the file to Firebase Storage
      await storageRef.putFile(
        imageFile,
        SettableMetadata(contentType: 'image/jpeg'),
      );

      // Get the download URL of the uploaded image
      final downloadUrl = await storageRef.getDownloadURL();
      setState(() {
        _downloadUrl = downloadUrl;
      });

      // Optionally, store the URL in Firestore for the user
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'profile_picture': downloadUrl,
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile updated successfully!')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Profile Picture'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_image != null)
              CircleAvatar(
                radius: 50,
                backgroundImage: FileImage(File(_image!.path)),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image from Gallery'),
            ),
            const SizedBox(height: 20),
            _isUploading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _uploadImage,
                    child: Text('Upload Profile Picture'),
                  ),
            const SizedBox(height: 20),
            if (_downloadUrl != null) Text('Profile Picture URL: $_downloadUrl'),
            Image.network(_downloadUrl ?? 'default_image_url'),
          ],
        ),
      ),
    );
  }
}
