import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musique_application/MusiqueManager.dart';
import 'package:musique_application/music.dart';

class PlayerManager {
  PlayerManager({required this.index, required this.play}) {
    _player = AudioPlayer();
  }

  final progressNotifier = ValueNotifier<ProgressBarState>(
    ProgressBarState(
      current: Duration.zero,
      buffered: Duration.zero,
      total: Duration.zero,
    ),
  );
  late bool play;

  late int index;

  late final AudioPlayer _player;

  List<Music> myMusicList = MusiqueManager().myMusicList;

  late String duration;

  final buttonNotifier = ValueNotifier<ButtonState>(ButtonState.paused);

  void next() {
    if (index >= myMusicList.length - 1) {
      index = 0;
    } else {
      index++;
    }

    init();
  }

  void back() {
    if (index < 1) {
      index = myMusicList.length - 1;
    } else {
      index--;
    }

    init();
  }

  Future<String> init() async {
    return await _player
        .setAudioSource(AudioSource.uri(Uri.parse(myMusicList[index].urlSong)))
        .then((value) => duration =
            "${_player.duration!.inMinutes}:${_player.duration!.inSeconds % 60}");
  }

  void init2() async {
    _player.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        play = false;
      } else if (!isPlaying) {
        play = false;
      } else if (processingState != ProcessingState.completed) {
        play = true;
      } else {
        _player.seek(Duration.zero);
        _player.pause();
      }
    });

    _player.positionStream.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });

    _player.bufferedPositionStream.listen((bufferedPosition) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: bufferedPosition,
        total: oldState.total,
      );
    });

    _player.durationStream.listen((totalDuration) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: totalDuration ?? Duration.zero,
      );
    });
  }

  Music getMusic() {
    return myMusicList[index];
  }

  String getDuration() {
    return duration;
  }

  void playerStop() {
    _player.stop();
    play = false;
  }

  void playerStart() {
    _player.play();
    play = true;
  }

  void playerPause() {
    _player.pause();
    play = false;
  }

  void seek(Duration position) {
    _player.seek(position);
  }
}

class ProgressBarState {
  ProgressBarState({
    required this.current,
    required this.buffered,
    required this.total,
  });
  final Duration current;
  final Duration buffered;
  final Duration total;
}

enum ButtonState { paused, playing, loading }
