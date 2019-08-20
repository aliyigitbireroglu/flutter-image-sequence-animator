# image_sequence_animator

A simple widget for animating a set of images with full custom controls as an alternative to using a GIF file.

**It is highly recommended to read the documentation and run the example project on a real device to fully understand and inspect the full range
 of capabilities.**

[Media](#media) | [Description](#description) | [How-to-Use](#howtouse)

<img src="https://img.shields.io/badge/Cosmos%20Software-Love%20Code-red"/>
<br>

[![Pub](https://img.shields.io/pub/v/image_sequence_animator?color=g)](https://pub.dev/packages/image_sequence_animator)
[![License](https://img.shields.io/github/license/aliyigitbireroglu/flutter-image-sequence-animator?color=blue)](https://github.com/aliyigitbireroglu/flutter-image-sequence-animator/blob/master/LICENSE)


<a name="media"></a>
## Media
*Videos*

[![Image Sequence Animator](https://www.cosmossoftware.coffee/Common/Portfolio/GIFs/FlutterImageSequenceAnimator.jpg)](https://youtu.be/xZ9vdVkI4Vc)


<a name="description"></a>
## Description
This is a very simple widget for animating a set of images (a.k.a: an image sequence) as an alternative to using a GIF file. GIF files are, as far 
as I know, not possible to control. With this package, you will have full control over your image sequence. You can loop, boomerang, change the 
color, play, pause, stop, skip, rewind, restart and more. 


<a name="howtouse"></a>
## How-to-Use
First, add your image sequence to your assets and update the "pubspec.yaml" accordingly. 

Then create an ImageSequenceAnimator widget as shown in the example:

```
ImageSequenceAnimator(
  "ImageSequence", 
  "Frame_", 
  0, 
  5, 
  "png", 
  60,
  isAutoPlay: false, 
  color: color1, 
  onReadyToPlay: onReadyToPlay, 
  onPlaying: onPlaying)
```

In this excerpt, the ImageSequenceAnimator animates the frames from the directory

*assets/ImageSequence/* 

Based on the second to fifth parameters, the ImageSequenceAnimator constructs the name format for each image file to be as:

Frame_00000.png, Frame_00001.png, Frame_00002.png, Frame_00003.png ...

The total number of frames is 60. As isAutoPlay set to false, the ImageSequenceAnimator will not start playing 
immediately. Instead, this example uses onReadyToPlay callback for receiving a reference to the instance of the 
ImageSequenceAnimator once it is created and then calls functions to loop, boomerang, change the color, play, pause, 
stop, skip, rewind, restart, etc.


## Notes
I started using and learning Flutter only some weeks ago so this package might have some parts that don't make sense, 
that should be completely different, that could be much better, etc. Please let me know! Nicely! 

Any help, suggestion or criticism is appreciated! 

Cheers.

<br><br>
<img align="right" src="https://www.cosmossoftware.coffee/Common/Images/CosmosSoftwareIconTransparent.png" width="150" height="150"/>
<br><br>