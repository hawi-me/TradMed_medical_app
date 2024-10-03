import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tradmed/pages/forgetpassword.dart';
import 'package:tradmed/pages/h_p.dart';
import 'package:tradmed/pages/home.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController =
      ScrollController(); // ScrollController
  bool _isLogin = true;
  bool _loading = false;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _loadRecentCredentials(); // Load recent email and password
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Dispose the ScrollController
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loadRecentCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? recentEmail = prefs.getString('recentEmail');
    String? recentPassword = prefs.getString('recentPassword');

    // Set recent credentials to the text fields
    if (recentEmail != null) {
      _emailController.text = recentEmail;
    }
    if (recentPassword != null) {
      _passwordController.text = recentPassword;
    }
  }

  Future<void> _saveRecentCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('recentEmail', _emailController.text);
    await prefs.setString('recentPassword', _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        controller: _scrollController, // Attach the ScrollController here
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey, // Wrap with Form widget and assign key
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
                _loading
                    ? const CircularProgressIndicator()
                    : _buildActionButton(),
                const SizedBox(height: 10),
                _buildGoogleSignInButton(),
                const SizedBox(height: 10),
                _buildSwitchAuthMode(),
                const SizedBox(height: 10),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPasswordPage()));
                    },
                    child: const Text('Forget Password')),
              ],
            ),
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
          image: AssetImage('assets/log_1.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool isPassword = false}) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword && !_isPasswordVisible,
      validator: (value) {
        if (label == 'Email') {
          return _validateEmail(value);
        } else if (label == 'Password') {
          return _validatePassword(value);
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.green[700]),
        filled: true,
        fillColor: Colors.green[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.green[700],
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
            : null,
      ),
    );
  }

  Widget _buildActionButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 16),
        backgroundColor: const Color.fromARGB(255, 2, 127, 127),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        minimumSize: const Size(300, 50),
      ),
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          if (_isLogin) {
            await _loginUser();
          } else {
            await _signUpUser();
          }
        }
      },
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

      // Save recent credentials
      await _saveRecentCredentials();

      // Navigate to home page after successful sign-up
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
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

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({
        'email': _emailController.text,
        'lastLoggedIn': FieldValue.serverTimestamp(),
      });

      // Save recent credentials
      await _saveRecentCredentials();

      // Navigate to home page after successful login
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
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
        // The user canceled the sign-in
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
      Navigator.pushReplacementNamed(
          context, '/home'); // Ensure this route exists
    } catch (e) {
      // Handle the error gracefully and show a message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google sign-in failed: $e')),
      );
      print('Google sign-in error: $e'); // Log the error for debugging
    }
    setState(() {
      _loading = false;
    });
  }

  // Email validation logic
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    String pattern =
        r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,}$'; // Regular expression for email format
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  // Password validation logic
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}
