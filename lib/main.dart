  import 'package:flutter/material.dart';
  import 'package:firebase_core/firebase_core.dart';


  import 'package:flutter/foundation.dart';

  import 'package:provider/provider.dart';
  import 'package:ready4jobs/services/authentication_service.dart';
  import 'package:flutter_file_downloader/flutter_file_downloader.dart';


  
  import 'package:ready4jobs/models/profile_provider.dart';
  
  
  import 'package:ready4jobs/pages/welcome_page.dart';
  import 'package:ready4jobs/pages/sign_up_page.dart';

  import 'package:ready4jobs/pages/TermsAndConditionsPage.dart';
  import 'package:ready4jobs/pages/PasswordResetPage.dart';
  import 'package:ready4jobs/pages/Dashboard_Page.dart';
  import 'package:ready4jobs/pages/Cv_Page.dart';
  import 'package:ready4jobs/pages/New_Interviews.dart';
  import 'package:ready4jobs/pages/Entretiens_Page.dart';
  import 'package:ready4jobs/pages/Profil_page.dart';
  import 'package:ready4jobs/pages/login_page.dart';
  import 'package:ready4jobs/pages/Forum_Page.dart';



  Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize Firebase
    await Firebase.initializeApp();

    // Initialize FileDownloader
    FileDownloader(enableLog: true); // J'ai activé les logs pour le débogage. Vous pouvez l'enlever si vous le souhaitez.



    if (kIsWeb || defaultTargetPlatform == TargetPlatform.macOS) {
      // Initialize the Facebook javascript SDK if you decide to use it in the future.
      /*
    await FacebookAuth.instance.webAndDesktopInitialize(
      appId: "117101091433168",
      cookie: true,
      xfbml: true,
      version: "v15.0",
    );
    */
    }

    runApp(
      MultiProvider(
        providers: [
          Provider<AuthenticationService>(
            create: (_) => AuthenticationService(),
          ),
          ChangeNotifierProvider<ProfileProvider>(
            create: (_) => ProfileProvider(),
          ),
        ],
        child: Ready4JobsApp(),
      ),
    );
  }



  class Ready4JobsApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/signup': (context) => SignUpPage(),
          '/homepage': (context) => DashboardPage(),
          '/cv': (context) => CVPage(),
          '/terms': (context) => TermsAndConditionsPage(),
          '/forgot-password': (context) => PasswordResetPage(),
          '/chat': (context) => ChatPage(),
          '/entretiens': (context) => EntretiensPage(),
          '/profil': (context) => ProfilPage(),
          '/login': (context) => LoginPage(),
          '/forum': (context) => ForumPage(),
          // ...
        },
        home: WelcomePage(), // Définir la route par défaut ici
      );
    }
  }
  
  
  
  
  /*
  class WelcomePage extends StatelessWidget {
    const WelcomePage({Key? key}) : super(key: key);
  
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: const Color(0xFF08245A),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 57),
                  const WelcomeText(),
                  const SizedBox(height: 40),
                  const WelcomeImage(),
                  const SizedBox(height: 10),
                  const WelcomeDescription(),
                  const SizedBox(height: 110),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      WelcomeButton(
                        text: 'Se connecter',
                        route: LoginPage(),
                      ),
                      WelcomeButton(
                        text: 'S\'inscrire',
                        route: SignUpPage(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
  
  class WelcomeText extends StatelessWidget {
    const WelcomeText({Key? key}) : super(key: key);
  
    @override
    Widget build(BuildContext context) {
      return Text(
        'Bienvenue sur Ready4Jobs',
        style: const TextStyle(
          fontFamily: 'Abhaya Libre',
          fontSize: 48,
          color: Colors.white,
        ),
      );
    }
  }
  
  class WelcomeImage extends StatelessWidget {
    const WelcomeImage({Key? key}) : super(key: key);
  
    @override
    Widget build(BuildContext context) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: Container(
          width: 300,
          height: 200,
          child: Image.asset('images/Bienvenue.png', fit: BoxFit.cover),
        ),
      );
    }
  }
  
  class WelcomeDescription extends StatelessWidget {
    const WelcomeDescription({Key? key}) : super(key: key);
  
    @override
    Widget build(BuildContext context) {
      return Text(
        'Votre expérience, Votre entreprise cible, Notre technologie',
        style: const TextStyle(
          fontFamily: 'Abhaya Libre',
          fontSize: 12,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }
  
  class WelcomeButton extends StatelessWidget {
    final String text;
    final Widget route;
  
    const WelcomeButton({
      Key? key,
      required this.text,
      required this.route,
    }) : super(key: key);
  
    @override
    Widget build(BuildContext context) {
      return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF04CAE9)),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => route),
          );
        },
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 12,
            color: Colors.black,
          ),
        ),
      );
    }
  }
  */
  
  /*
  class LoginPage extends StatefulWidget {
    @override
    _LoginPageState createState() => _LoginPageState();
  }
  
  class _LoginPageState extends State<LoginPage> {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final AuthenticationService _authService = AuthenticationService();
  
    bool _isEmailFieldFocused = false;
  
    void sendPasswordResetEmail(BuildContext context, String email) async {
      try {
        await _authService.sendPasswordResetEmail(email);
  
        print('Password reset email sent');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An email with password reset instructions has been sent to $email')),
        );
      } catch (error) {
        print('Error sending password reset email: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send password reset email. Please try again.')),
        );
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
                      'Connectez-vous',
                      style: TextStyle(
                        fontFamily: 'Abhaya Libre',
                        fontSize: 48,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: _emailController,
                      onTap: () {
                        setState(() {
                          _isEmailFieldFocused = true;
                        });
                      },
                      validator: (value) => value!.isEmpty ? 'Veuillez entrer un email' : null,
                      decoration: InputDecoration(
                        labelText: _isEmailFieldFocused ? null : 'Email',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _passwordController,
                      onTap: () {
                        setState(() {
                          _isEmailFieldFocused = false;
                        });
                      },
                      validator: (value) => value!.isEmpty ? 'Veuillez entrer un mot de passe' : null,
                      decoration: InputDecoration(
                        labelText: _isEmailFieldFocused ? 'Mot de passe' : null,
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      obscureText: true,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 1),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          sendPasswordResetEmail(context, _emailController.text);
                        },
                        child: Text(
                          'Mot de passe oublié ?',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
  
                    SizedBox(height: 10),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF04CAE9)),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          User? user = await _authService.signInWithEmail(_emailController.text, _passwordController.text);
                          if (user != null) {
                            Navigator.pushReplacementNamed(context, '/homepage');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Une erreur s\'est produite lors de la connexion. Veuillez réessayer.')),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please fill out the form correctly')),
                          );
                        }
                      },
                      child: Text(
                        'Connexion',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    Text(
                      'Se connecter avec',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Votre bouton de connexion à Facebook sera ici
                        // Quand vous êtes prêt à l'implémenter
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () async {
                            User? user = await _authService.signInWithGoogle();
                            if (user != null) {
                              Navigator.pushReplacementNamed(context, '/homepage');
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Une erreur s\'est produite lors de la connexion. Veuillez réessayer.')),
                              );
                            }
                          },
                          child: Image.asset('images/google.png', height: 25, width: 25),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                          ),
                        ),
                      ],
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
  */
  
  
  /*
  class _SignUpPageState extends State<SignUpPage> {
    AuthenticationService _authService = AuthenticationService();
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
  
    void sendConfirmationEmail(String? email) async {
      if (email != null) {
        final Email emailMessage = Email(
          body: 'Merci de vous être inscrit. Veuillez cliquer sur le lien de confirmation pour activer votre compte.',
          subject: 'Confirmation d\'inscription',
          recipients: [email],
          isHTML: false,
        );
  
        try {
          await FlutterEmailSender.send(emailMessage);
          print('E-mail de confirmation envoyé à $email');
        } catch (error) {
          print('Erreur lors de l\'envoi de l\'e-mail de confirmation : $error');
        }
      } else {
        print('Adresse e-mail non disponible');
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
                    TextFormField(
                      controller: _emailController,
                      onTap: () {
                        setState(() {
                          _isEmailFieldFocused = true;
                        });
                      },
                      validator: (value) => value!.isEmpty ? 'Veuillez entrer un email' : null,
                      decoration: InputDecoration(
                        labelText: _isEmailFieldFocused ? null : 'Email',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _passwordController,
                      onTap: () {
                        setState(() {
                          _isPasswordFieldFocused = true;
                        });
                      },
                      validator: (value) => value!.isEmpty ? 'Veuillez entrer un mot de passe' : null,
                      decoration: InputDecoration(
                        labelText: _isPasswordFieldFocused ? null : 'Mot de passe',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      obscureText: true,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _confirmPasswordController,
                      onTap: () {
                        setState(() {
                          _isConfirmPasswordFieldFocused = true;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Veuillez confirmer le mot de passe';
                        }
                        if (value != _passwordController.text) {
                          return 'Le mot de passe et la confirmation du mot de passe ne correspondent pas';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: _isConfirmPasswordFieldFocused ? null : 'Confirmez le mot de passe',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      obscureText: true,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF04CAE9)),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          User? user = await _authService.signUpWithEmail(_emailController.text, _passwordController.text);
                          if (user != null) {
                            sendConfirmationEmail(user.email); // Retirer le mot-clé "await"
                            Navigator.pushReplacementNamed(context, '/homepage');
                          } else {
                            setState(() {
                              _errorMessage = 'Compte déjà existant';
                            });
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please fill out the form correctly')),
                          );
                        }
                      },
                      child: Text(
                        'Inscription',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'S\'inscrire avec',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        // Code pour se connecter avec Google
                      },
                      child: Image.asset('images/google.png', height: 25, width: 25),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                      ),
                    ),
                    SizedBox(height: 30),
                    if (_errorMessage != null)
                      Text(
                        _errorMessage!,
                        style: TextStyle(
                          color: Colors.red,
                        ),
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
  
  
  
  
  
  
  
  
  
  
  
  
  
  class SignUpPage extends StatefulWidget {
    @override
    _SignUpPageState createState() => _SignUpPageState();
  }
  
   */
  
  /*
  class DashboardPage extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Color(0xFF08245A),
        appBar: CustomAppBar(title: 'Dashboard'),
        body: SingleChildScrollView(
          child: Container(
            color: Color(0xFF08245A),
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: 160),
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage('assets/profile_photo.png'),
                          ),
                          SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Poste recherché',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'Description du profil',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFF08245A),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 20,
                            offset: Offset(0, -5),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 1.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                                minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 130)),
                                side: MaterialStateProperty.all<BorderSide>(BorderSide(color: Colors.white, width: 1.0)),
                                elevation: MaterialStateProperty.all<double>(3.0),
                                shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/cv');
                              },
                              child: Text(
                                'CV',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 6),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                                minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 130)),
                                side: MaterialStateProperty.all<BorderSide>(BorderSide(color: Colors.white, width: 1.0)),
                                elevation: MaterialStateProperty.all<double>(3.0),
                                shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/entretiens');
                              },
                              child: Text(
                                'Entretiens',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 6),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 45),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                                minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 130)),
                                side: MaterialStateProperty.all<BorderSide>(BorderSide(color: Colors.white, width: 1.0)),
                                elevation: MaterialStateProperty.all<double>(3.0),
                                shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/astuces');
                              },
                              child: Text(
                                'Astuces',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 6),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                                minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 130)),
                                side: MaterialStateProperty.all<BorderSide>(BorderSide(color: Colors.white, width: 1.0)),
                                elevation: MaterialStateProperty.all<double>(8.0),
                                shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/definir');
                              },
                              child: Text(
                                'À définir',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBarWidget(),
      );
    }
  }
  
  
  */
  
  /*
  class CVPage extends StatefulWidget {
    @override
    _CVPageState createState() => _CVPageState();
  }
  
  class _CVPageState extends State<CVPage> {
    User? user;
    String? selectedCV;
  
    @override
    void initState() {
      super.initState();
      user = FirebaseAuth.instance.currentUser;
    }
  
    Stream<QuerySnapshot<Map<String, dynamic>>> getUserResumes() {
      return FirebaseFirestore.instance
          .collection('cvs')
          .doc(user?.uid)
          .collection('cv')
          .snapshots();
    }
  
    Future<void> chooseCVAndUpload() async {
      final result = await FilePicker.platform.pickFiles();
  
      if (result != null) {
        final file = File(result.files.first.path!);
        final fileName = file.path.split('/').last;
  
        try {
          final storage = FirebaseStorage.instance;
          final cvRef = storage.ref().child('cvs/${user?.uid}/$fileName');
          final uploadTask = cvRef.putFile(file);
          final taskSnapshot = await uploadTask.whenComplete(() {});
          final downloadUrl = await taskSnapshot.ref.getDownloadURL();
  
          if (user == null || user?.uid == null) {
            print('User is not authenticated');
            return;
          }
  
          await FirebaseFirestore.instance.collection('cvs').doc(user?.uid).collection('cv').add({
            'fileName': fileName,
            'fileUrl': downloadUrl,
          });
  
          print('CV uploaded successfully. Download URL: $downloadUrl');
        } catch (e) {
          print('An error occurred while uploading the CV: $e');
        }
      }
    }
  
    Future<String> downloadFile(String url) async {
      Dio dio = Dio();
      try {
        var dir = await getApplicationDocumentsDirectory();
        String filename = basename(url);
        String path = "${dir.path}/$filename";
        await dio.download(url, path);
        return path;
      } catch (e) {
        throw e;
      }
    }
  
    Widget buildCVPreview(String fileUrl) {
      return FutureBuilder(
        future: downloadFile(fileUrl),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Expanded(
                child: PDFView(
                  filePath: snapshot.data as String,
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error while loading PDF');
            }
          }
  
          return Center(child: CircularProgressIndicator());
        },
      );
    }
  
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Color(0xFF08245A),
        appBar: AppBar(
          title: Text('Mes CVs'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: getUserResumes(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('An error occurred'));
                }
  
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
  
                final resumes = snapshot.data!.docs;
  
                if (resumes.isEmpty) {
                  return ElevatedButton(
                    onPressed: chooseCVAndUpload,
                    child: Text('Uploader un CV'),
                  );
                }
  
                return Expanded(
                  child: ListView.builder(
                    itemCount: resumes.length,
                    itemBuilder: (BuildContext context, int index) {
                      final data = resumes[index].data();
                      final fileUrl = data['fileUrl'];
  
                      return ListTile(
                        title: Text(data['fileName']),
                        onTap: () {
                          setState(() {
                            selectedCV = fileUrl;
                          });
                        },
                      );
                    },
                  ),
                );
              },
            ),
            if (selectedCV != null)
              buildCVPreview(selectedCV!),
            ElevatedButton(
              onPressed: chooseCVAndUpload,
              child: Text('Uploader un CV'),
            ),
          ],
        ),
      );
    }
  }
  
  
  */
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  //lien fb https://ready4job-4f54b.firebaseapp.com/__/auth/handler