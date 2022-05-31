import 'package:flutter/material.dart';
import 'package:musique_application/Playlist.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Musique',
      home: SplashScreenPage(),
    );
  }
}

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds: const MyPlaylistPage(
        title: 'Spoti fiat 500XL',
      ),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      title: const Text(
        'Spoti fiat 500XL',
        style: TextStyle(color: Colors.white),
        textScaleFactor: 2,
      ),
      image: Image.network(
          'https://www.fiat.fr/content/dam/fiat/com/models/family_page_500X/design-gallery/Fiat-500X-RED-trim-mobile-288x220.jpg'),
      loadingText: const Text("Loading", style: TextStyle(color: Colors.white)),
      photoSize: 110.0,
      loaderColor: const Color.fromARGB(255, 43, 219, 34),
    );
  }
}
