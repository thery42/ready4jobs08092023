    import 'package:flutter/material.dart';
    import 'package:ready4jobs/pages/login_page.dart';
    import 'package:google_sign_in/google_sign_in.dart';
    import 'package:firebase_auth/firebase_auth.dart';

    import 'package:ready4jobs/widgets/signup/email_form_field.dart';
    import 'package:ready4jobs/widgets/signup/password_form_field.dart';
    import 'package:ready4jobs/widgets/signup/confirm_password_form_field.dart';
    import 'package:ready4jobs/widgets/signup/sign_up_button.dart';
    import 'package:ready4jobs/widgets/signup/GoogleSignUpButton.dart';
    import 'package:ready4jobs/widgets/signup/form_validator.dart';
    import 'package:ready4jobs/widgets/signup/ErrorDialogWidget.dart';

    import 'package:ready4jobs/widgets/future_progress_dialog.dart';
    import 'package:ready4jobs/widgets/error_message_widget.dart';
    import 'package:ready4jobs/widgets/terms_and_conditions_widget.dart';
    import 'package:ready4jobs/widgets/app_scaffold.dart';


      class SignUpPage extends StatefulWidget {
        @override
        _SignUpPageState createState() => _SignUpPageState();
      }

      class _SignUpPageState extends State<SignUpPage> {
        final _formKey = GlobalKey<FormState>();
        final TextEditingController _emailController = TextEditingController();
        final TextEditingController _passwordController = TextEditingController();
        final TextEditingController _confirmPasswordController = TextEditingController();
        bool _acceptedTerms = false;
        String? _errorMessage;

        // Google Sign In instance
        final GoogleSignIn _googleSignIn = GoogleSignIn();

        bool _isEmailFieldFocused = false;
        bool _isPasswordFieldFocused = false;
        bool _isConfirmPasswordFieldFocused = false;



        // Method to show the FutureProgressDialogWidget
        Future<void> _showProgressDialog(Future<void> Function() futureFunction) async {
          showDialog(
            context: context,
            builder: (context) => FutureProgressDialogWidget(
              future: futureFunction,
            ),
          );
        }

        Future<void> _submitForm() async {
          // Clear any previous error message
          setState(() {
            _errorMessage = null;
          });

          // Check if the Terms and Conditions have been accepted
          if (!_acceptedTerms) {
            setState(() {
              _errorMessage = 'Veuillez accepter les Conditions Générales d\'Utilisation pour créer un compte.';
            });

            return;
          }

          if (_formKey.currentState!.validate()) {
            // Afficher le FutureProgressDialogWidget lors de la soumission du formulaire
            showDialog(
              context: context,
              builder: (context) => FutureProgressDialogWidget(
                future: () => _processForm(),
              ),
            );
          }
        }
        Future<void> _processForm() async {
          // Le formulaire est valide, vous pouvez traiter la soumission ici

          // Vérifiez si le mot de passe et la confirmation du mot de passe correspondent
          if (_passwordController.text != _confirmPasswordController.text) {
            setState(() {
              _errorMessage = 'Le mot de passe et la confirmation du mot de passe ne correspondent pas';
            });

            return;
          }

          try {
            // Créez un nouvel utilisateur avec l'adresse e-mail et le mot de passe
            UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: _emailController.text,
              password: _passwordController.text,
            );

            // Envoyer l'e-mail de vérification
            User? user = userCredential.user;
            if (user != null && !user.emailVerified) {
              await user.sendEmailVerification();
              print('E-mail de vérification envoyé à ${_emailController.text}');
            }



            // Le traitement est terminé
            // Vous pouvez effectuer d'autres actions après l'envoi de l'e-mail de confirmation ici
            // ...

            // Fermez le dialogue après le traitement
            Navigator.pop(context);

            // Une fois que tout est terminé, vous pouvez effectuer la navigation
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false,
            );
          } catch (e) {
            print('Erreur lors de la création de l\'utilisateur: $e');
            setState(() {
              _errorMessage = 'Erreur lors de la création de l\'utilisateur: $e';
            });

          }
        }



    // Fonction de connexion avec Google
        Future<void> _signInWithGoogle() async {
          // Afficher le FutureProgressDialogWidget lors de la connexion avec Google
          showDialog(
            context: context,
            builder: (context) => FutureProgressDialogWidget(
              future: _signInGoogle,
            ),
          );
        }

    // Fonction de connexion avec Google (étape 2 : authentification Firebase)
        Future<void> _signInGoogle() async {
          try {

            final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

            // Check if googleUser is not null before proceeding
            if (googleUser == null) {
              setState(() {
                _errorMessage = 'Erreur de connexion avec Google';
              });
              // Fermez le dialogue après le traitement
              Navigator.pop(context);
              return;
            }

            final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

            final AuthCredential credential = GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken,
              idToken: googleAuth.idToken,
            );

            final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
            final User? user = userCredential.user;

            if (user != null) {
              // L'utilisateur s'est connecté avec succès
              // Effectuez les opérations nécessaires après la connexion avec Google
              // Par exemple, vous pouvez appeler une fonction de traitement ici
              _handleSuccessfulSignIn();
            } else {
              setState(() {
                _errorMessage = 'Erreur de connexion avec Google';
              });
            }
          } catch (e) {
            print('Erreur lors de la connexion avec Google: $e');
          }

          // Fermez le dialogue après le traitement
          Navigator.pop(context);
        }

        void showErrorDialog(String message, {VoidCallback? retry}) {
          showDialog(
            context: context,
            builder: (context) => ErrorDialogWidget(
              message: message,
              onRetry: retry ?? () {},
            ),
          );
        }
    // Fonction de traitement des opérations après une connexion réussie avec Google
        void _handleSuccessfulSignIn() {
          // Code pour les opérations après la connexion réussie avec Google
          // Par exemple, vous pouvez mettre en œuvre le code pour une navigation vers une autre page
          // ou tout autre traitement nécessaire.

          // Naviguer vers la page de connexion en remplaçant la page actuelle
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        }


  // Fonction d'initialisation de la page
      @override
      void initState() {
        super.initState();

        // Ajouter des écouteurs pour suivre les changements dans les champs de texte
        _emailController.addListener(_onTextFieldChanged);
        _passwordController.addListener(_onTextFieldChanged);
        _confirmPasswordController.addListener(_onTextFieldChanged);
      }

  // Fonction de nettoyage lors de la destruction du widget
      @override
      void dispose() {
        // Supprimer les écouteurs lorsque le widget est détruit
        _emailController.removeListener(_onTextFieldChanged);
        _passwordController.removeListener(_onTextFieldChanged);
        _confirmPasswordController.removeListener(_onTextFieldChanged);
        super.dispose();
      }

  // Fonction appelée lorsque l'utilisateur interagit avec le formulaire à nouveau
      void _onTextFieldChanged() {
        // Effacer le message d'erreur lorsque l'utilisateur interagit à nouveau avec le formulaire
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
                        'Inscription',
                        style: TextStyle(
                          fontFamily: 'Abhaya Libre',
                          fontSize: 48,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 30),
                      EmailFormField(
                        controller: _emailController,
                        isFieldFocused: _isEmailFieldFocused,
                        validator: FormValidator.validateEmail,
                      ),
                      SizedBox(height: 10),
                      PasswordFormField(
                        controller: _passwordController,
                        isFieldFocused: _isPasswordFieldFocused,
                        validator: FormValidator.validatePassword,
                      ),
                      SizedBox(height: 10),
                      ConfirmPasswordFormField(
                        controller: _confirmPasswordController,
                        isFieldFocused: _isConfirmPasswordFieldFocused,
                        validator: (value) => FormValidator.validateConfirmPassword(_passwordController.text, value),
                      ),
                      SizedBox(height: 10),
                      if (_errorMessage != null)
                        ErrorMessage(message: _errorMessage!),  // Utiliser le widget ErrorMessage ici
                      SignUpButton(
                        onPressed: _submitForm,
                      ),
                      SizedBox(height: 10),
                      GoogleSignUpButton(
                        onPressed: _signInWithGoogle,
                      ),

                      SizedBox(height: 10),
                      // Add the TermsAndConditionsWidget here
                      TermsAndConditionsWidget(
                        acceptedTerms: _acceptedTerms,
                        onChanged: (bool? value) { // Utiliser bool? ici pour correspondre au type attendu
                          if (value != null) { // Vérifier que la valeur n'est pas null avant de l'utiliser
                            setState(() {
                              _acceptedTerms = value;
                            });
                          }
                        },
                      ),

                      SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                        },
                        child: Text(
                          'Déjà membre? Connexion',
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


/*
// MISE A JOUR LE 22/07/2023
  import 'package:flutter/material.dart';
  import 'package:ready4jobs/pages/login_page.dart';
  import 'package:google_sign_in/google_sign_in.dart';
  import 'package:firebase_auth/firebase_auth.dart';

  import 'package:ready4jobs/widgets/signup/email_form_field.dart';
  import 'package:ready4jobs/widgets/signup/password_form_field.dart';
  import 'package:ready4jobs/widgets/signup/confirm_password_form_field.dart';
  import 'package:ready4jobs/widgets/signup/sign_up_button.dart';
  import 'package:ready4jobs/widgets/signup/GoogleSignUpButton.dart';
  import 'package:ready4jobs/widgets/signup/form_validator.dart';

  import 'package:ready4jobs/widgets/future_progress_dialog.dart';
  import 'package:ready4jobs/widgets/error_message_widget.dart';
  import 'package:ready4jobs/widgets/terms_and_conditions_widget.dart';



  class SignUpPage extends StatefulWidget {
    @override
    _SignUpPageState createState() => _SignUpPageState();
  }

  class _SignUpPageState extends State<SignUpPage> {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _confirmPasswordController = TextEditingController();
    bool _acceptedTerms = false;
    String? _errorMessage;

    // Google Sign In instance
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    bool _isEmailFieldFocused = false;
    bool _isPasswordFieldFocused = false;
    bool _isConfirmPasswordFieldFocused = false;



    Future<void> _submitForm() async {
      // Clear any previous error message
      setState(() {
        _errorMessage = null;
      });

      // Check if the Terms and Conditions have been accepted
      if (!_acceptedTerms) {
        setState(() {
          _errorMessage = 'Veuillez accepter les Conditions Générales d\'Utilisation pour créer un compte.';
        });

        return;
      }

      if (_formKey.currentState!.validate()) {
        // Afficher le FutureProgressDialogWidget lors de la soumission du formulaire
        showDialog(
          context: context,
          builder: (context) => FutureProgressDialogWidget(
            future: () => _processForm(),
          ),
        );
      }
    }
    Future<void> _processForm() async {
      // Le formulaire est valide, vous pouvez traiter la soumission ici

      // Vérifiez si le mot de passe et la confirmation du mot de passe correspondent
      if (_passwordController.text != _confirmPasswordController.text) {
        setState(() {
          _errorMessage = 'Le mot de passe et la confirmation du mot de passe ne correspondent pas';
        });

        return;
      }

      try {
        // Créez un nouvel utilisateur avec l'adresse e-mail et le mot de passe
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        // Envoyer l'e-mail de vérification
        User? user = userCredential.user;
        if (user != null && !user.emailVerified) {
          await user.sendEmailVerification();
          print('E-mail de vérification envoyé à ${_emailController.text}');
        }



        // Le traitement est terminé
        // Vous pouvez effectuer d'autres actions après l'envoi de l'e-mail de confirmation ici
        // ...

        // Fermez le dialogue après le traitement
        Navigator.pop(context);

        // Une fois que tout est terminé, vous pouvez effectuer la navigation
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
              (route) => false,
        );
      } catch (e) {
        print('Erreur lors de la création de l\'utilisateur: $e');
        setState(() {
          _errorMessage = 'Erreur lors de la création de l\'utilisateur: $e';
        });

      }
    }



    Future<void> _signInWithGoogle() async {
      // Afficher le FutureProgressDialogWidget lors de la connexion avec Google
      showDialog(
        context: context,
        builder: (context) => FutureProgressDialogWidget(
          future: _signInGoogle,
        ),
      );
    }

    Future<void> _signInGoogle() async {
      try {
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          // L'utilisateur s'est connecté avec succès
          // Effectuez les opérations nécessaires après la connexion avec Google
        } else {
          setState(() {
            _errorMessage = 'Erreur de connexion avec Google';
          });

        }
      } catch (e) {
        print('Erreur lors de la connexion avec Google: $e');
      }

      // Fermez le dialogue après le traitement
      Navigator.pop(context);
    }



    @override
    void initState() {
      super.initState();

      // Add listeners to track changes in the text fields
      _emailController.addListener(_onTextFieldChanged);
      _passwordController.addListener(_onTextFieldChanged);
      _confirmPasswordController.addListener(_onTextFieldChanged);
    }

    @override
    void dispose() {
      // Remove the listeners when the widget is disposed
      _emailController.removeListener(_onTextFieldChanged);
      _passwordController.removeListener(_onTextFieldChanged);
      _confirmPasswordController.removeListener(_onTextFieldChanged);
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
      return Scaffold(
        backgroundColor: Color(0xFF08245A),
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
                      'Inscription',
                      style: TextStyle(
                        fontFamily: 'Abhaya Libre',
                        fontSize: 48,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 30),
                    EmailFormField(
                      controller: _emailController,
                      isFieldFocused: _isEmailFieldFocused,
                      validator: FormValidator.validateEmail,
                    ),
                    SizedBox(height: 10),
                    PasswordFormField(
                      controller: _passwordController,
                      isFieldFocused: _isPasswordFieldFocused,
                      validator: FormValidator.validatePassword,
                    ),
                    SizedBox(height: 10),
                    ConfirmPasswordFormField(
                      controller: _confirmPasswordController,
                      isFieldFocused: _isConfirmPasswordFieldFocused,
                      validator: (value) => FormValidator.validateConfirmPassword(_passwordController.text, value),
                    ),
                    SizedBox(height: 10),
                    if (_errorMessage != null)
                      ErrorMessage(message: _errorMessage!),  // Utiliser le widget ErrorMessage ici
                    SignUpButton(
                      onPressed: _submitForm,
                    ),
                    SizedBox(height: 10),
                    GoogleSignUpButton(
                      onPressed: _signInWithGoogle,
                    ),

                    SizedBox(height: 10),
                    // Add the TermsAndConditionsWidget here
                    TermsAndConditionsWidget(
                      acceptedTerms: _acceptedTerms,
                      onChanged: (bool? value) { // Utiliser bool? ici pour correspondre au type attendu
                        if (value != null) { // Vérifier que la valeur n'est pas null avant de l'utiliser
                          setState(() {
                            _acceptedTerms = value;
                          });
                        }
                      },
                    ),

                    SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                      },
                      child: Text(
                        'Déjà membre? Connexion',
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

*/











