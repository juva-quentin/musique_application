import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musique_application/MusiqueManager.dart';
import 'package:musique_application/PlayerManager.dart';
import 'package:musique_application/music.dart';
import 'package:musique_application/player.dart';

class ListMusique extends StatefulWidget {
  const ListMusique({Key? key}) : super(key: key);

  @override
  State<ListMusique> createState() => _ListMusiqueState();
}

class _ListMusiqueState extends State<ListMusique> {
  List<Music> myMusicList = MusiqueManager().myMusicList;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: myMusicList.length,
        itemBuilder: (context, index) {
          return musiqueCard(myMusicList[index], index);
        },
      ),
    );
  }
}

class musiqueCard extends StatelessWidget {
  musiqueCard(this.musique, this.index);

  final Music musique;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return Player(index1: index);
          }),
        )
      },
      child: Card(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(musique.imagePath, width: 40, height: 40),
              Column(
                children: [
                  Text(
                    musique.title,
                    style: GoogleFonts.lato(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    musique.singer,
                    style: GoogleFonts.lato(
                        fontStyle: FontStyle.italic, color: Colors.white70),
                  )
                ],
              ),
              Text(
                "",
                style: GoogleFonts.lato(
                    fontStyle: FontStyle.italic, color: Colors.white70),
              )
            ],
          ),
        ),
      ),
    );
  }
}
