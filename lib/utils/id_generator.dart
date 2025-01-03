import 'dart:math';

String generateUniqueId() {
  final random = Random();
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  return List.generate(20, (index) => chars[random.nextInt(chars.length)]).join();
}

