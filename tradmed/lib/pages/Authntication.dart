import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tradmed/Features/Medapp/Presentation/upload_profile.dart';
import 'package:tradmed/pages/forgetpassword.dart';
import 'package:tradmed/pages/h_p.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tradmed/pages/registerdoctor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLogin = true;
  bool _loading = false;
  bool _passwordVisible = false;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _loadRecentCredentials();
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
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _registerAsDoctorButton(),
                const SizedBox(height: 50),
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
                _buildTextField(
                  _emailController,
                  'Email',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email.';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  _passwordController,
                  'Password',
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password.';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters.';
                    }
                    return null;
                  },
                ),
                // Center the "Forget Password" TextButton

                const SizedBox(height: 20),
                _loading
                    ? const CircularProgressIndicator()
                    : _buildActionButton(),
                const SizedBox(height: 10),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPasswordPage()));
                    },
                    child: const Text(
                      'Forget Password ?',
                      style: TextStyle(color: Colors.teal),
                    ),
                  ),
                ),

                _buildSwitchAuthMode(),
                const SizedBox(height: 10),
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

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    bool isPassword = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword && !_passwordVisible,
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
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.green[700],
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              )
            : null,
      ),
      validator: validator,
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
      onPressed: _submitForm,
      child: Text(
        _isLogin ? 'Log In' : 'Sign Up',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
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

  Widget _registerAsDoctorButton() {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 50, right: 16),
        child: OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.green[800]!),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          icon: Icon(Icons.local_hospital, color: Colors.green[800]),
          label: Text('Doctor', style: TextStyle(color: Colors.green[800])),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisterDoctorPage()),
            );
          },
        ),
      ),
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

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() != true) {
      return;
    }
    setState(() {
      _loading = true;
    });

    try {
      if (_isLogin) {
        await _loginUser();
      } else {
        await _signUpUser();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _signUpUser() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Extract username
      String username = _emailController.text.split('@')[0];

      // Save username to SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username);

      // Navigate to Home Page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign-up failed: $e')),
      );
    }
  }

  Future<void> _loginUser() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Extract username
      String username = _emailController.text.split('@')[0];

      // Save username to SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username);

      // Navigate to Home Page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $e')),
      );
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() {
      _loading = true;
    });
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return;
      }
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) =>HomePage(username: username)));
    } catch (e) {
      throw Exception('Google Sign-In failed: $e');
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }
}
