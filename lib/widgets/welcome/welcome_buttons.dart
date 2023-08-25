import 'package:flutter/material.dart';
import 'package:ready4jobs/pages/login_page.dart';
import 'package:ready4jobs/pages/sign_up_page.dart';
import 'package:ready4jobs/widgets/welcome/welcome_button.dart';
import '../constants.dart';


class WelcomeButtons extends StatelessWidget {
  const WelcomeButtons({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}


// WelcomeButtons est un widget qui affiche une rangée de boutons de bienvenue.
// Ces boutons sont utilisés généralement pour les options de connexion et d'inscription.
// Les boutons sont créés en utilisant le widget personnalisé WelcomeButton, qui est importé depuis welcome_button.dart.
// Le premier bouton est "Se connecter" et lorsqu'il est pressé, il navigue vers la page LoginPage.
// Le deuxième bouton est "S'inscrire" et lorsqu'il est pressé, il navigue vers la page SignUpPage.
// Les boutons sont disposés dans une rangée avec un espacement uniforme entre eux grâce à MainAxisAlignment.spaceEvenly.

