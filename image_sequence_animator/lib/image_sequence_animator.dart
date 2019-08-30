//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// © Cosmos Software | Ali Yigit Bireroglu                                                                                                           /
// All material used in the making of this code, project, program, application, software et cetera (the "Intellectual Property")                     /
// belongs completely and solely to Ali Yigit Bireroglu. This includes but is not limited to the source code, the multimedia and                     /
// other asset files. If you were granted this Intellectual Property for personal use, you are obligated to include this copyright                   /
// text at all times.                                                                                                                                /
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//@formatter:off

import 'package:flutter/material.dart';

typedef ImageSequenceProcessCallback = void Function(ImageSequenceAnimatorState _imageSequenceAnimator);

class ImageSequenceAnimator extends StatefulWidget {
  ///The folder of your image sequence relative to your assets. For example, if you add your image sequence to
  ///'assets/ImageSequences/MyImageSequence'
  ///then the [folderName] should be 'ImageSequences/MyImageSequence'. This should be the same for all the images in your image sequence.
  final String folderName;

  ///The file name for each image in your image sequence excluding the suffix. For example, if the images in your image sequence are named as
  ///'Frame_00000.png', 'Frame_00001.png', 'Frame_00002.png', 'Frame_00003.png' ...
  ///then the [fileName] should be 'Frame_'. This should be the same for all the images in your image sequence.
  final String fileName;

  ///The suffix for the first image in your image sequence. For example, if the first image in your image sequence is named as
  ///'Frame_00001.png'
  ///then [suffixStart] should be 1.
  final int suffixStart;

  ///The suffix length for each image in your image sequence. Most software such as Adobe After Effects export image sequences with a suffix. For
  ///example, if the images in your image sequence are named as
  ///'Frame_00000.png', 'Frame_00001.png', 'Frame_00002.png', 'Frame_00003.png' ...
  ///then the [suffixCount] should be 5. This should be the same for all the images in your image sequence.
  final int suffixCount;

  ///The file format for each image in your image sequence. For example, if the images in your image sequence are named as
  ///'Frame_00000.png', 'Frame_00001.png', 'Frame_00002.png', 'Frame_00003.png' ...
  ///then the [fileFormat] should be 'png'. This should be the same for all the images in your image sequence.
  final String fileFormat;

  ///The total number of images in your image sequence.
  final double frameCount;

  ///The FPS for your image sequence. For example, if your [frameCount] is 60 and the animation is meant to run in 1 second, then your [fps] should
  /// be 60.
  final double fps;

  ///Use this value to determine whether your image sequence should loop or not. This will override [isBoomerang] if both are set to true.
  final bool isLooping;

  ///Use this value to determine whether your image sequence should boomerang or not.
  final bool isBoomerang;

  ///Use this value to determine whether your image sequence should start playing immediately or not.
  final bool isAutoPlay;

  ///Use this value to determine the color for your image sequence.
  final Color color;

  ///The callback for when the [ImageSequenceAnimatorState] is ready to start playing.
  final ImageSequenceProcessCallback onReadyToPlay;

  ///The callback for when the [ImageSequenceAnimatorState] starts playing.
  final ImageSequenceProcessCallback onStartPlaying;

  ///The callback for when the [ImageSequenceAnimatorState] is playing. This callback is continuously through the entire process.
  final ImageSequenceProcessCallback onPlaying;

  ///The callback for when the [ImageSequenceAnimatorState] finishes playing.
  final ImageSequenceProcessCallback onFinishPlaying;

  const ImageSequenceAnimator(
    this.folderName,
    this.fileName,
    this.suffixStart,
    this.suffixCount,
    this.fileFormat,
    this.frameCount, {
    Key key,
    this.fps: 60,
    this.isLooping: false,
    this.isBoomerang: false,
    this.isAutoPlay: true,
    this.color: Colors.white,
    this.onReadyToPlay,
    this.onStartPlaying,
    this.onPlaying,
    this.onFinishPlaying,
  }) : super(key: key);

  @override
  ImageSequenceAnimatorState createState() {
    return ImageSequenceAnimatorState(
      folderName,
      fileName,
      suffixStart,
      suffixCount,
      fileFormat,
      frameCount,
      fps,
      isLooping,
      isBoomerang,
      isAutoPlay,
      color,
      onReadyToPlay,
      onStartPlaying,
      onPlaying,
      onFinishPlaying,
    );
  }
}

class ImageSequenceAnimatorState extends State<ImageSequenceAnimator> with SingleTickerProviderStateMixin {
  final String folderName;
  final String fileName;
  final int suffixStart;
  final int suffixCount;
  String fileFormat;
  final double frameCount;
  final double fps;
  int get fpsInMilliseconds => (1.0 / fps * 1000.0).floor();

  bool isLooping;
  bool isBoomerang;
  final bool isAutoPlay;
  Color color;
  bool colorChanged = false;

  ///The [AnimationController] used to control the image sequence.
  AnimationController animationController;

  final ValueNotifier<int> changeNotifier = ValueNotifier<int>(0);

  int previousFrame = 0;
  Image currentFrame;

  final ImageSequenceProcessCallback onReadyToPlay;
  final ImageSequenceProcessCallback onStartPlaying;
  final ImageSequenceProcessCallback onPlaying;
  final ImageSequenceProcessCallback onFinishPlaying;

  ///Use this value to get the total time of the animation in milliseconds.
  double get totalTime => animationController.upperBound * fpsInMilliseconds;

  ///Use this value to get the current time of the animation in milliseconds.
  double get currentTime => animationController.value * fpsInMilliseconds;

  ImageSequenceAnimatorState(
    this.folderName,
    this.fileName,
    this.suffixStart,
    this.suffixCount,
    this.fileFormat,
    this.frameCount,
    this.fps,
    this.isLooping,
    this.isBoomerang,
    this.isAutoPlay,
    this.color,
    this.onReadyToPlay,
    this.onStartPlaying,
    this.onPlaying,
    this.onFinishPlaying,
  );

  void animationListener() {
    changeNotifier.value += 1;

    if (onPlaying != null) onPlaying(this);
  }

  void animationStatusListener(AnimationStatus animationStatus) {
    switch (animationStatus) {
      case AnimationStatus.completed:
        if (onFinishPlaying != null) onFinishPlaying(this);

        if (isLooping) restart();
        if (isBoomerang) rewind();
        break;
      case AnimationStatus.dismissed:
        if (onFinishPlaying != null) onFinishPlaying(this);

        if (isLooping || isBoomerang) play();
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: frameCount,
      duration: Duration(milliseconds: frameCount.ceil() * fpsInMilliseconds),
    )
      ..addListener(animationListener)
      ..addStatusListener(animationStatusListener);

    if (isLooping) isBoomerang = false;

    if (fileFormat.startsWith(".")) fileFormat = fileFormat.substring(1);

    if (onReadyToPlay != null) onReadyToPlay(this);

    if (isAutoPlay) play();
  }

  @override
  void dispose() {
    reset();

    animationController.removeListener(animationListener);
    animationController.removeStatusListener(animationStatusListener);
    animationController.dispose();

    super.dispose();
  }

  ///Use this function to set the value for [ImageSequenceAnimator.isLooping] at runtime.
  void setIsLooping(bool isLooping) {
    this.isLooping = isLooping;
    if (this.isLooping) {
      isBoomerang = false;
      if (!animationController.isAnimating) restart();
    }
  }

  ///Use this function to set the value for [ImageSequenceAnimator.isBoomerang] at runtime.
  void setIsBoomerang(bool isBoomerang) {
    this.isBoomerang = isBoomerang;
    if (this.isBoomerang) {
      isLooping = false;
      if (!animationController.isAnimating) restart();
    }
  }

  ///Use this function to set the value for [ImageSequenceAnimator.color] at runtime.
  void changeColor(Color color) {
    this.color = color;
    colorChanged = true;
    changeNotifier.value += 1;
  }

  void play({double from: -1.0}) {
    if (!animationController.isAnimating && onStartPlaying != null) onStartPlaying(this);

    if (from == -1.0)
      animationController.forward();
    else
      animationController.forward(from: from);
  }

  void rewind({double from: -1.0}) {
    if (!animationController.isAnimating && onStartPlaying != null) onStartPlaying(this);

    if (from == -1.0)
      animationController.reverse();
    else
      animationController.reverse(from: from);
  }

  void pause() {
    animationController.stop();
  }

  ///Only use either value or percentage.
  void skip(double value, {double percentage: -1.0}) {
    if (percentage != -1.0)
      animationController.value = totalTime * percentage;
    else
      animationController.value = value;
  }

  void restart() {
    stop();
    play();
  }

  void stop() {
    reset();
  }

  void reset() {
    animationController.value = 0;
    animationController.stop(canceled: true);
    previousFrame = 0;
    currentFrame = null;
  }

  String getSuffix(String value) {
    while (value.length < suffixCount) value = "0" + value;
    return value;
  }

  String getDirectory() {
    return folderName + "/" + fileName + getSuffix((suffixStart + previousFrame).toString()) + "." + fileFormat;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder: (BuildContext context, int change, Widget cachedChild) {
        if (currentFrame == null || animationController.value.floor() != previousFrame || colorChanged) {
          colorChanged = false;
          previousFrame = animationController.value.floor();
          if (previousFrame < frameCount)
            currentFrame = Image.asset(
              getDirectory(),
              color: color,
              gaplessPlayback: true,
            );
        }

        return currentFrame;
      },
      valueListenable: changeNotifier,
    );
  }
}
