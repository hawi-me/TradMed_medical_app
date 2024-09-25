import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tradmed/pages/home.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLogin = true;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              _buildLogo(),
              const SizedBox(height: 40),
              Text(
                _isLogin ? 'Welcome Back!' : 'Create Your Account',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                _isLogin
                    ? 'Log in to continue with personalized herbal medicine suggestions.'
                    : 'Sign up to explore natural herbal remedies and consult professionals.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.green[600],
                ),
              ),
              const SizedBox(height: 40),
              _buildTextField(_emailController, 'Email'),
              const SizedBox(height: 20),
              _buildTextField(_passwordController, 'Password',
                  isPassword: true),
              const SizedBox(height: 20),
              _loading ? const CircularProgressIndicator() : _buildActionButton(),
              const SizedBox(height: 10),
              _buildGoogleSignInButton(),
              const SizedBox(height: 10),
              _buildSwitchAuthMode(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 250,
      height: 150,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assests/images/log_1.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.green[700]),
        filled: true,
        fillColor: Colors.green[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildActionButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 16),
          backgroundColor: const Color.fromARGB(255, 2, 127, 127),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          minimumSize: const Size(300, 50)),
      onPressed: () => _isLogin ? _loginUser() : _signUpUser(),
      child: Text(
        _isLogin ? 'Log In' : 'Sign Up',
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget _buildGoogleSignInButton() {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.green[800]!),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        minimumSize: const Size(300, 50),
      ),
      icon: Icon(Icons.g_mobiledata_sharp, color: Colors.green[800]),
      label: Text(
        'Continue with Google',
        style: TextStyle(color: Colors.green[800]),
      ),
      onPressed: _signInWithGoogle,
    );
  }

  Widget _buildSwitchAuthMode() {
    return TextButton(
      onPressed: () {
        setState(() {
          _isLogin = !_isLogin;
        });
      },
      child: Text(
        _isLogin
            ? 'Don’t have an account? Sign up'
            : 'Already have an account? Log in',
        style: TextStyle(color: Colors.green[700]),
      ),
    );
  }

  Future<void> _signUpUser() async {
    setState(() {
      _loading = true;
    });
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Save user email to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({
        'email': _emailController.text,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Navigate to home page after successful sign-up
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign-up failed: $e')),
      );
    }
    setState(() {
      _loading = false;
    });
  }

  Future<void> _loginUser() async {
    setState(() {
      _loading = true;
    });
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Optionally, you could update user data upon login
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({
        'lastLogin': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      // Navigate to home page after successful login
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $e')),
      );
    }
    setState(() {
      _loading = false;
    });
  }

  Future<void> _signInWithGoogle() async {
    setState(() {
      _loading = true;
    });
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        setState(() {
          _loading = false;
        });
        return;
      }
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      // Navigate to home page after successful Google sign-in
      Navigator.pushReplacementNamed(context, '/home'); // Update to your route
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google sign-in failed: $e')),
      );
    }
    setState(() {
      _loading = false;
    });
  }
}
