import 'dart:convert';
import 'dart:io';
import 'package:http/io_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Quote {
  final String content;
  final String author;

  Quote({required this.content, required this.author});

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      content: json['content'] ?? 'No quote found.',
      author: json['author'] ?? 'Unknown',
    );
  }
}

final quoteProvider = FutureProvider<Quote>((ref) async {
  // Bypass SSL certificate validation as api.quotable.io's certificate is currently expired
  final ioc = HttpClient();
  ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  final client = IOClient(ioc);

  try {
    final response = await client.get(Uri.parse('https://api.quotable.io/random'));
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return Quote.fromJson(data);
    } else {
      throw Exception('Failed to load quote');
    }
  } finally {
    client.close();
  }
});
