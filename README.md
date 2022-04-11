# image_sequence_animator

[comment]: <> (Badges)
<a href="https://www.cosmossoftware.coffee">
   <img alt="Cosmos Software" src="https://img.shields.io/badge/Cosmos%20Software-Love%20Code-red" />
</a>

[![Pub](https://img.shields.io/pub/v/image_sequence_animator?color=g)](https://pub.dev/packages/image_sequence_animator)
[![License](https://img.shields.io/github/license/aliyigitbireroglu/flutter-image-sequence-animator?color=blue)](https://github.com/aliyigitbireroglu/flutter-image-sequence-animator/blob/master/LICENSE)

[comment]: <> (Introduction)
A simple widget for animating a set of images with full custom controls as an alternative to using a GIF file.

**If you have a GIF file you would like to use with this package, I recommend [EZGIF](https://ezgif.com/split) to convert your GIF file to an image
 sequence.**

**It is highly recommended to read the documentation and run the example project on a real device to fully understand and inspect the full range
 of capabilities.**

[comment]: <> (ToC)
[Media](#media) | [Description](#description) | [How-to-Use](#howtouse)

[comment]: <> (Recent)
## Recent
* **[isOnline] is added. If your [folderName] is an online path, this value should be set to true.**
    
* **[waitUntilCacheIsComplete] is added. If you want the [ImageSequenceAnimator] to wait until the entire image sequence is cached, this value should be set
  to true i. Otherwise, the [ImageSequenceAnimator] will invoke [onReadyToPlay] and start playing if [isAutoPlay] is set to true when it approximates that the 
  remaining caching can be completed without causing stutters. This value is only used if [isOnline] is set to true.**
  
* **[cacheProgressIndicatorBuilder] is added. If you want to display a widget until the [ImageSequenceAnimator] is ready to be played, use this function.**
* * *


[comment]: <> (Media)
<a name="media"></a>
## Media

Watch on **Youtube**:

<a href="https://youtu.be/xZ9vdVkI4Vc">
   <img alt="Image Sequence Animator" src="https://user-images.githubusercontent.com/51419598/162646149-e9dbe6bc-7663-4dd5-918a-44aa56a1fc5c.png" height="450" max-height="450"/>
</a>


[comment]: <> (Description)
<a name="description"></a>
## Description
This simple widget for animating a set of images **(a.k.a an image sequence)** with full custom controls as an alternative to using a GIF file.

GIF files are, as far as I know, not possible to control. With this package, you will have full control over your image sequence like controlling a
video. You can loop, boomerang, change the color, play, pause, stop, skip, rewind, restart and more. 


[comment]: <> (How-to-Use)
<a name="howtouse"></a>
## How-to-Use
First, add your image sequence to your assets and update the "pubspec.yaml" accordingly. 

Then create an ImageSequenceAnimator widget as shown in the example:

```dart
ImageSequenceAnimator(
  "assets/ImageSequences/MyImageSequence", /// folderName 
  "Frame_", /// fileName
  0, /// suffixStart
  5, /// suffixCount 
  "png", /// fileFormat 
  60, /// frameCount
  {
    Key key,
    fps: 60,
    isLooping: false,
    isBoomerang: false,
    isAutoPlay: true,
    color: Colors.white,
    onReadyToPlay: _onReadyToPlay,
    onStartPlaying: _onStartPlaying,
    onPlaying: _onPlaying,
    onFinishPlaying: _onFinishPlaying
  },
)

ImageSequenceAnimator(
  "https://www.domain.com/ImageSequences/MyImageSequence", /// folderName 
  "Frame_", /// fileName
  0, /// suffixStart
  5, /// suffixCount 
  "png", /// fileFormat 
  60, /// frameCount
  /// Named parameters
  {
    Key key,
    fps:60,
    isLooping: false,
    isBoomerang: false,
    isAutoPlay: true,
    isOnline: true,
    waitUntilCacheIsComplete: true,
    cacheProgressIndicatorBuilder: _cacheProgressIndicatorBuilder,
    color: Colors.white,
    onReadyToPlay: _onReadyToPlay,
    onStartPlaying: _onStartPlaying,
    onPlaying: _onPlaying,
    onFinishPlaying: _onFinishPlaying,
  },
)

Widget _cacheProgressIndicatorBuilder(BuildContext _context , double _progress);  
void   _onReadyToPlay(ImageSequenceAnimatorState _imageSequenceAnimator);
void   _onStartPlaying(ImageSequenceAnimatorState _imageSequenceAnimator);
void   _onPlaying(ImageSequenceAnimatorState _imageSequenceAnimator);
void   _onFinishPlaying(ImageSequenceAnimatorState _imageSequenceAnimator); 
```

**Further Explanations:**

*For a complete set of descriptions for all parameters and methods, see the [documentation](https://pub.dev/documentation/image_sequence_animator/latest/).*

* [isLooping] will override [isBoomerang] if both are set to true.
* All [ImageSequenceProcessCallback] callbacks will return a reference to the created [ImageSequenceAnimator] state. You can save this instance for
 further actions.
* Use [ImageSequenceAnimatorState]'s 
[void setIsLooping(bool isLooping)], [void setIsBoomerang(bool isBoomerang)], [void setColor(Color color)], [void play({double from: -1.0})],
[void rewind({double from: -1.0})], [void pause()], [void skip(double value, {double percentage: -1.0})], [void restart()], [void stop()] 
methods for the corresponding actions.
* Use [ImageSequenceAnimatorState]'s [bool get isLooping], [bool get isBoomerang], [double get currentProgress], [double get totalProgress], 
[double get currentTime] and [double get totalTime] methods to get the respective values.


[comment]: <> (Notes)
## Notes
I started using and learning Flutter only some weeks ago so this package might have some parts that don't make sense, that should be completely 
different, that could be much better, etc. Please let me know! Nicely! 

Any help, suggestion or criticism is appreciated! 

Cheers.

[comment]: <> (CosmosSoftware)
<br><br>
<img align="right" src="https://user-images.githubusercontent.com/51419598/162646125-f0ee782c-0911-4175-b20b-61cf65604b42.png" width="150" height="150"/>
<br><br>
