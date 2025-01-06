import 'package:url_launcher/url_launcher.dart';

class WhatsAppService {
  static Future<void> sendMessage(String phone, String message) async {
    // Remove qualquer caractere não numérico do número de telefone
    phone = phone.replaceAll(RegExp(r'[^\d]+'), '');
    
    // Codifica a mensagem para URL
    final encodedMessage = Uri.encodeComponent(message);
    
    // Cria a URL do WhatsApp
    final whatsappUrl = 'https://wa.me/$phone/?text=$encodedMessage';

    // Tenta abrir a URL
    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
      await launchUrl(Uri.parse(whatsappUrl));
    } else {
      throw 'Não foi possível abrir o WhatsApp.';
    }
  }
}

