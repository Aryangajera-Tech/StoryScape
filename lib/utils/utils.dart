import 'package:flutter/material.dart';

var Green = Color.fromRGBO(31, 67, 57, 1);
var Yellow = Color.fromRGBO(254, 254, 241, 1);
var Brown = Color.fromRGBO(177, 133, 109, 1);

List<String> items = [
  "arts",
  "us",
  "world",
  "opinion",
  "politics",
  "sports",
  "automobiles",
  "books",
  "business",
  "fashion",
  "food",
  "home",
  "insider",
  "movies",
  "nyregion",
  "obituaries",
  "realestate",
  "sundayreview",
  "technology",
  "theater",
  "t-magazine",
  "travel",
  "upshot",

];

void nextScreen(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenReplace(context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

void showSnackbar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontSize: 14),
      ),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: "OK",
        onPressed: () {},
        textColor: Colors.white,
      ),
    ),
  );
}



