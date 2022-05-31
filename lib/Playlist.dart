import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:musique_application/components/MusiqueList.dart';
import 'package:musique_application/player.dart';

class MyPlaylistPage extends StatefulWidget {
  const MyPlaylistPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyPlaylistPage> createState() => _MyPlaylistPageState();
}

class _MyPlaylistPageState extends State<MyPlaylistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Color.fromARGB(255, 34, 34, 34),
      ),
      body: const Center(child: ListMusique()),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 52, 186, 57),
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return Player(index1: 0);
            }),
          )
        },
        child: const Icon(Icons.play_arrow),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
