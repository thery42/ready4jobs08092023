import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ready4jobs/pages/Dashboard_Page.dart';
import 'package:ready4jobs/widgets/login/email_form_field.dart';
import 'package:ready4jobs/widgets/login/password_form_field.dart';
import 'package:ready4jobs/widgets/login/login_button.dart';
import 'package:ready4jobs/widgets/login/GoogleLoginButton.dart';
import 'package:ready4jobs/widgets/login/form_validator.dart';
import 'package:ready4jobs/widgets/login/ForgotPasswordButton.dart';
import 'package:ready4jobs/widgets/login/resendConfirmationEmail.dart';
import 'package:ready4jobs/services/authentication_service.dart';
import 'package:ready4jobs/widgets/future_progress_dialog.dart';
import 'package:ready4jobs/widgets/app_scaffold.dart';
import 'package:ready4jobs/widgets/login/stay_connected_manager.dart';




class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showResendEmailButton = false;
  bool _isEmailUnrecognized = false;



  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool _stayLoggedIn = false;



  final AuthenticationService _authService = AuthenticationService();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => FutureProgressDialogWidget(
          future: () async {
            await _signInUser();
          },
        ),
      );
    }
  }

  Future<void> _signInUser() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    print("Attempting to sign in user with email: $email");

    String? errorMessage = await _authService.signInUserWithEmailAndPassword(email, password);

    if (errorMessage == null) {
      print("User signed in and email verified.");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DashboardPage()),
      );
    } else {
      print("Error during sign in: $errorMessage");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );

      // Vérifiez si l'erreur est celle que vous avez mentionnée et mettez à jour l'état en conséquence
      if (errorMessage == 'Veuillez vérifier votre e-mail avant de vous connecter.') {
        setState(() {
          _showResendEmailButton = true;
        });
      }
    }
  }









  Future<void> _signInWithGoogle() async {
    showDialog(
      context: context,
      builder: (context) => FutureProgressDialogWidget(
        future: () async {
          User? user = await _authService.signInWithGoogle();

          if (user != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DashboardPage()),
            );
          }
        },
      ),
    );
  }



  @override
  void initState() {
    super.initState();
    _emailController.addListener(_onTextFieldChanged);
    _passwordController.addListener(_onTextFieldChanged);

    // Chargement de la préférence
    StayConnectedManager.getStayLoggedIn().then((value) {
      setState(() {
        _stayLoggedIn = value;
      });
    });
  }

  void _onTextFieldChanged() {}

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 57),
                  Text(
                    'Connexion',
                    style: TextStyle(
                      fontFamily: 'Abhaya Libre',
                      fontSize: 48,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 30),
                  LoginEmailFormField(
                    controller: _emailController,
                    isFieldFocused: false,
                    validator: FormValidator.validateEmail,
                  ),
                  SizedBox(height: 10),
                  LoginPasswordFormField(
                    controller: _passwordController,
                    isFieldFocused: false,
                    validator: FormValidator.validatePassword,
                  ),
                  SizedBox(height: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _stayLoggedIn,
                            onChanged: (value) {
                              setState(() {
                                _stayLoggedIn = value ?? false;
                              });
                              StayConnectedManager.setStayLoggedIn(_stayLoggedIn);  // Ajout de cette ligne
                            },
                          ),

                          SizedBox(width: 5),
                            Text(
                              'Rester connecté',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      SizedBox(width: 80),
                      ForgotPasswordButton(),
                    ],
                  ),
                  SizedBox(height: 20),
                  if (_showResendEmailButton) ResendConfirmationEmailButton(),
                  LoginButton(
                    onPressed: _submitForm,
                  ),
                  SizedBox(height: 10),
                  GoogleLoginButton(
                    onPressed: _signInWithGoogle,
                  ),
                  SizedBox(height: 30),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: Text(
                      'Pas encore membre? Inscription',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}