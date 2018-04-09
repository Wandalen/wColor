# wColor [![Build Status](https://travis-ci.org/Wandalen/wColor.svg?branch=master)](https://travis-ci.org/Wandalen/wColor)
The module in JavaScript provides convenient means for color conversion.
Contains map of predefined colors( ColorMap ) with rgb channels in [ 0,1 ] range and methods to convert colors between different formats and notations.

## Installation
```terminal
npm install wColor
```
## Usage
After installation module becomes a part of [ wTools ]( https://github.com/Wandalen/wTools ) package and can be used as its 'color' property:
> wTools.color

Colors map is avaible at:
> wTools.color.ColorMap

### Methods
* Find color in colors map - [ colorByName ]()
* Extract rgb values from bitmask - [ rgbByBitmask ]()
* Get rgba color by name or hex value - [ rgbaFrom ]()
* Get rgb color by name or hex value - [ rgbFrom ]()
* Get name of nearest color - [ colorNameNearest ]()
* Convert rgb to hex - [ colorToHex ]()
* Convert hex to rgb - [ hexToColor ]()
* Convert rgb values from 0-1 range to browser compatible notation - [ colorToRgbHtml ]()
* Convert rgba values from 0-1 range to browser compatible notation - [ colorToRgbaHtml ]()
* Convert from rgb to hsl - [ rgbToHsl ]()
* Convert from hsl to rgb - [ hslToRgb ]()

##### Example #1
```javascript
/*Get color by name*/
var _ = wTools;
var rgb = _.color.colorByName( 'red' );
console.log( rgb );
/*
[ 1, 0, 0 ]
*/
```
##### Example #2
```javascript
/*Get color by name directly*/
var _ = wTools;
var rgb = _.color.ColorMap['red'];
console.log( rgb );
/*
[ 1, 0, 0 ]
*/
```
##### Example #3
```javascript
/*Get color by hex value*/
var _ = wTools;
var rgb = _.color.rgbFrom( 'ffffff' )
console.log( rgb );
/*
[ 1, 1, 1 ]
*/
```
##### Example #4
```javascript
/*Get color by bitmask*/
var _ = wTools;
var rgb = _.color.rgbByBitmask( 0x00ff00 )
console.log( rgb );
/*
[ 0, 1, 0 ]
*/
```
##### Example #5
```javascript
/*Find nearest color*/
var _ = wTools;
var name = _.color.colorNameNearest( 'ff0032' );
var rgb = _.color.ColorMap[ name ];
console.log( name, rgb );
/*
  red [ 1, 0, 0 ]
*/
```
##### Example #6
```javascript
/*Convert color to browser compatible rgb notation*/
var _ = wTools;
var rgb = _.color.ColorMap[ 'red' ];
var browser = _.color.colorToRgbHtml( rgb );
console.log( rgb, browser );
/*
  [ 1, 0, 0 ] 'rgb( 255, 0, 0 )'
*/
```


















