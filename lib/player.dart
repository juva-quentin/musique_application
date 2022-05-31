import 'package:flutter/material.dart';

import 'package:musique_application/PlayerManager.dart';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

class Player extends StatefulWidget {
  Player({Key? key, required this.index1}) : super(key: key);

  int index1;
  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> with TickerProviderStateMixin {
  late PlayerManager player;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    player = PlayerManager(index: widget.index1, play: false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  next() {
    setState(() {
      player.next();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 34, 34, 34),
        title: Text(
          player.getMusic().title,
          style: TextStyle(fontSize: 30),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => {Navigator.of(context).pop(), player.playerStop()},
        ),
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: player.init(),
          builder: (context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              player.init2();
              return Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(30),
                    child: Image.asset(player.getMusic().imagePath,
                        width: 400, fit: BoxFit.fill),
                  ),
                  Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(5),
                      child: Text(
                        player.getMusic().title,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style:
                            const TextStyle(fontSize: 35, color: Colors.white),
                      )),
                  Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(10),
                      child: Text(
                        player.getMusic().singer,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      )),
                  ValueListenableBuilder<ProgressBarState>(
                    valueListenable: player.progressNotifier,
                    builder: (_, value, __) {
                      return Padding(
                          padding: EdgeInsets.all(16.0),
                          child: ProgressBar(
                              progress: value.current,
                              buffered: value.buffered,
                              total: value.total,
                              onSeek: player.seek,
                              baseBarColor: Colors.black,
                              progressBarColor:
                                  Color.fromARGB(255, 39, 179, 44),
                              thumbColor: Color.fromARGB(255, 39, 179, 44),
                              bufferedBarColor: Color.fromARGB(255, 66, 99, 67),
                              timeLabelTextStyle:
                                  TextStyle(color: Colors.white)));
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            child: const Icon(
                              Icons.skip_previous,
                              color: Colors.white,
                              size: 40,
                            ),
                            onPressed: () {
                              setState(() {
                                player.back();
                              });
                            }),
                        GestureDetector(
                          onTap: () {
                            if (player.play == false) {
                              _controller.forward();
                              player.play = true;
                              setState(() {
                                player.playerStart();
                              });
                            } else {
                              _controller.reverse();
                              player.play = false;
                              setState(() {
                                player.playerPause();
                              });
                            }
                          },
                          child: AnimatedIcon(
                            icon: AnimatedIcons.play_pause,
                            progress: _controller,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                        TextButton(
                            child: const Icon(
                              Icons.skip_next,
                              color: Colors.white,
                              size: 40,
                            ),
                            onPressed: () {
                              setState(() {
                                player.next();
                              });
                            }),
                      ],
                    ),
                  ),
                ],
              );
            }
            return const CircularProgressIndicator(
              backgroundColor: Colors.cyanAccent,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            );
          },
        ),
      ),
      backgroundColor: Color.fromARGB(255, 34, 34, 34),
    );
  }
}
