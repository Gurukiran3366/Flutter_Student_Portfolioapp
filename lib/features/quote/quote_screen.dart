import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QuoteScreen extends StatefulWidget {
const QuoteScreen({super.key});

@override
State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
String quote = 'Fetching quote...';
String author = '';

@override
void initState() {
super.initState();
fetchQuote();
}

Future<void> fetchQuote() async {
final url = Uri.parse('https://zenquotes.io/api/today');
try {
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    setState(() {
      quote = data[0]['q'];
      author = data[0]['a'];
    });
  } else {
    setState(() {
      quote = 'Failed to load quote';
    });
  }
} catch (e) {
  setState(() {
    quote = 'Error fetching quote';
  });
}
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text('Quote of the Day')),
body: Padding(
padding: const EdgeInsets.all(20),
child: Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Text(
'"$quote"',
style: const TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
textAlign: TextAlign.center,
),
const SizedBox(height: 10),
Text(
author.isNotEmpty ? '- $author' : '',
style: const TextStyle(fontSize: 16),
textAlign: TextAlign.center,
),
],
),
),
),
);
}
}