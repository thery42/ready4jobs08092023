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
  import 'package:ready4jobs/widgets/error_message_widget.dart';
  import 'package:ready4jobs/widgets/app_scaffold.dart';


  class LoginPage extends StatefulWidget {
    @override
    _LoginPageState createState() => _LoginPageState();
  }

  class _LoginPageState extends State<LoginPage> {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    String? _errorMessage;


    final GoogleSignIn _googleSignIn = GoogleSignIn();
    bool _stayLoggedIn = false;
    bool _isEmailUnrecognized = false;

    final AuthenticationService _authService = AuthenticationService(); // Instancier le service d'authentification

    Future<void> _submitForm() async {
      setState(() {
        _errorMessage = null;
        _isEmailUnrecognized = false;
      });

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

      print('Sur le point d\'appeler  signInWithEmail');

      try {
        User? user = await _authService.signInWithEmail(email, password);
        print('Terminé d\'appeler signInWithEmail');

        if (user == null) {
          setState(() {
            _errorMessage = "Erreur inattendue lors de la connexion";
          });
        } else {
          if (!user.emailVerified) {
            await _authService.signOut();
            setState(() {
              _errorMessage = "Veuillez vérifier votre e-mail avant de vous connecter";
            });
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DashboardPage()),
            );
            setState(() {
              _errorMessage = null;
            });
          }
        }
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case 'user-not-found':
            setState(() {
              _errorMessage = "Aucun utilisateur trouvé pour cet e-mail";
            });
            break;
          case 'wrong-password':
            setState(() {
              _errorMessage = "Mot de passe incorrect";
            });
            break;
          default:
            setState(() {
              _errorMessage = "Erreur lors de la connexion.";
            });
            break;
        }
      }
    }




    Future<void> _signInWithGoogle() async {
      showDialog(
        context: context,
        builder: (context) => FutureProgressDialogWidget(
          future: () async {
            print('About to call signInWithGoogle'); // Ajout d'un message de log avant l'appel

            User? user = await _authService.signInWithGoogle();

            print('Finished calling signInWithGoogle'); // Ajout d'un message de log après l'appel

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

      // Add listeners to track changes in the text fields
      _emailController.addListener(_onTextFieldChanged);
      _passwordController.addListener(_onTextFieldChanged);
    }

    @override
    void dispose() {
      // Remove the listeners when the widget is disposed
      _emailController.removeListener(_onTextFieldChanged);
      _passwordController.removeListener(_onTextFieldChanged);
      super.dispose();
    }

    void _onTextFieldChanged() {
      // Clear the error message when the user interacts with the form again
      if (_errorMessage != null) {
        setState(() {
          _errorMessage = null;
        });
      }
    }



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
                    // Utilize your custom widget LoginEmailFormField here
                    LoginEmailFormField(
                      controller: _emailController,
                      isFieldFocused: false, // You need to set this value based on the focus state of the field
                      validator: FormValidator.validateEmail,
                    ),
                    SizedBox(height: 10),
                    // Utilize your custom widget LoginPasswordFormField here
                    LoginPasswordFormField(
                      controller: _passwordController,
                      isFieldFocused: false, // You need to set this value based on the focus state of the field
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
                              },
                            ),
                            SizedBox(width: 5), // Espacement supplémentaire entre le Checkbox et le Text
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
                    if (_isEmailUnrecognized) // Affichez le bouton seulement si l'email n'est pas reconnu
                      ResendConfirmationEmailButton(),
                    if (_errorMessage != null)
                      ErrorMessage(message: _errorMessage!),
                    LoginButton(
                      onPressed: _submitForm,
                    ),

                    SizedBox(height: 10),
                    GoogleLoginButton(
                      onPressed: _signInWithGoogle,
                    ),
                    SizedBox(height: 30), // Ajout du SizedBox ici
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







