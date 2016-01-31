# trivialslideshow1
This is an OS X app written in Swift 2.0 to perform the dissolving slide-show seen in the preroll for Invalidstream before the actual program begins.

![trivialslideshow1-animated-gif-demo](https://cloud.githubusercontent.com/assets/305140/12703296/ae4a6bd4-c80d-11e5-9c03-36503ecc9862.gif)

It's heavily based on the ImageTransition project from Apple's sample code, but ported to Swift 2.0 and with the addition of an OpenDocument implementation that lets you open multiple files to transition between.

The default animation is kCATransitionFade, but this could easily be replaced with any of the various CoreImage transition filters.
