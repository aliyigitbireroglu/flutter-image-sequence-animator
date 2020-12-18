## [1.0.10] - 18.12.2020

* [fullPaths] is added. If you would like to specify a list of endpoints for the frames in your image sequence animator, use this value. If set, values for 
  [folderName], [fileName], [suffixStart], [suffixCount], [fileFormat] and [frameCount] will be ignored.

## [1.0.9] - 16.10.2020

* Minor changes.

## [1.0.8] - 16.10.2020

* [isOnline] is added. If your [folderName] is an online path, this value should be set to true.

* [waitUntilCacheIsComplete] is added. If you want the [ImageSequenceAnimator] to wait until the entire image sequence is cached, this value should be set
  to true i. Otherwise, the [ImageSequenceAnimator] will invoke [onReadyToPlay] and start playing if [isAutoPlay] is set to true when it approximates that the 
  remaining caching can be completed without causing stutters. This value is only used if [isOnline] is set to true.

* [cacheProgressIndicatorBuilder] is added. If you want to display a widget until the [ImageSequenceAnimator] is ready to be played, use this function.

* Improved documentation.

## [1.0.7] - 11.10.2020

* Regular maintenance.

## [1.0.6] - 21.11.2019

* Minor changes.

## [1.0.5] - 30.08.2019

* Minor changes.

* Improved code style.

* [1.0.5+1] Updated README.

## [1.0.4] - 23.08.2019

* Minor changes.

* Improved code style with trailing commas.

* [1.0.4+1] Minor changes.

## [1.0.3] - 21.08.2019

* Minor changes.

* Updated README.

## [1.0.2] - 20.08.2019

* Improved code style.

* Code excerpt added to the README.

## [1.0.1] - 18.08.2019

* Improved documentation.

## [1.0.0] - 17.08.2019

* Initial release.
