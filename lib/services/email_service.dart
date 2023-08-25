import 'package:flutter_email_sender/flutter_email_sender.dart';

class EmailService {
  void sendConfirmationEmail(String email) async {
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
  }
}
