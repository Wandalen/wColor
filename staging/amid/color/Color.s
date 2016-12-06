(function _Color_s_() {

'use strict';

if( typeof module !== 'undefined' )
{

  if( typeof wBase === 'undefined' )
  try
  {
    require( '../wTools.s' );
  }
  catch( err )
  {
    require( 'wTools' );
  }

}

var _ = wTools;

//

var colorByName = function colorByName( name,def )
{
  var o = _.routineOptionsFromThis( colorByName,this,Self );

  _.routineOptions( colorByName,o );

  var result;
  if( !o.colorMap )
  o.colorMap = Self.ColorMap;

  _.assert( arguments.length <= 2 );
  _.assert( _.strIs( name ) );

  name = name.toLowerCase();
  name = name.trim();

  return _colorByName( name,def,o.colorMap );
}

colorByName.defaults =
{
  colorMap : null,
}

//

var _colorByName = function( name,def,map )
{
  var result = map[ name ];

  if( !result )
  result = def;

  return result;
}
//

var rgbByBitmask = function rgbByBitmask( src )
{

  _.assert( arguments.length === 1 );
  _.assert( _.numberIs( src ) );

  return _rgbByBitmask( src );
}

//

var _rgbByBitmask = function _rgbByBitmask( src )
{
  var result = [];

  result[ 0 ] = ( ( src >> 16 ) & 0xff ) / 255;
  result[ 1 ] = ( ( src >> 8 ) & 0xff ) / 255;
  result[ 2 ] = ( ( src >> 0 ) & 0xff ) / 255;

  return result;
}

//

var _rgbaFromNotName = function _rgbaFromNotName( src )
{

  _.assert( arguments.length === 1 );
  _.assert( _.numberIs( src ) || _.arrayIs( src ) || _.mapIs( src ) );

  if( _.mapIs( src ) )
  {
    var result = [];
    result[ 0 ] = src.r === undefined ? 1 : src.r;
    result[ 1 ] = src.g === undefined ? 1 : src.g;
    result[ 2 ] = src.b === undefined ? 1 : src.b;
    result[ 3 ] = src.a === undefined ? 1 : src.a;
    return result;
  }

  if( _.numberIs( src ) )
  {
    result = _rgbByBitmask( src );
    debugger;
    return _.arrayGrow( result,0,4,1 );
  }

  var result = [];

  /* */

  for( var r = 0 ; r < src.length ; r++ )
  result[ r ] = Number( src[ r ] );

  if( result.length < 4 )
  result[ 3 ] = 1;

  /* */

  return result;
}

//

var rgbaFrom = function rgbaFrom( src )
{
  var result;

  _.assert( arguments.length === 1 );

  if( _.numberIs( src ) || _.arrayIs( src ) || _.mapIs( src ) )
  return _rgbaFromNotName( src );

  /* */

  if( _.strIs( src ) )
  result = colorByName.call( this,src );

  if( result )
  {
    if( result.length !== 4 )
    result = _.arrayGrow( result,0,4,1 );
    return result;
  }

  /* */

  if( _.strIs( src ) )
  result = _.color.hexToColor( src );

  if( result )
  {
    if( result.length !== 4 )
    result = _.arrayGrow( result,0,4,1 );

    return result;
  }

  /* */

  _.assert( 0,'unknown color',src );
}

rgbaFrom.defaults =
{
  colorMap : null,
}

//

var rgbFrom = function rgbFrom( src )
{
  _.assert( arguments.length === 1 );

  var result = rgbaFrom.call( this,src );

  return _.arraySlice( result,0,3 );
}

rgbFrom.defaults =
{
}

rgbFrom.defaults.__proto__ = rgbaFrom.defaults;

//

var rgbaFromTry = function rgbaFromTry( src,def )
{

  _.assert( arguments.length === 2 );

  try
  {
    return rgbaFrom.call( this,src );
  }
  catch( err )
  {
    return def;
  }

}

rgbaFromTry.defaults =
{
}

rgbaFromTry.defaults.__proto__ = rgbaFrom.defaults;

//

var rgbFromTry = function rgbFromTry( src,def )
{

  _.assert( arguments.length === 2 );

  try
  {
    return rgbFrom.call( this,src );
  }
  catch( err )
  {
    return def;
  }

}

rgbFromTry.defaults =
{
}

rgbFromTry.defaults.__proto__ = rgbaFrom.defaults;

//

var _colorDistance = function _colorDistance( c1,c2 )
{

  var a1 = c1[ 3 ] === undefined ? 1 : c1[ 3 ];
  var a2 = c2[ 3 ] === undefined ? 1 : c2[ 3 ];

  return  Math.pow( c1[ 0 ] - c2[ 0 ], 2 ) +
          Math.pow( c1[ 1 ] - c2[ 1 ], 2 ) +
          Math.pow( c1[ 2 ] - c2[ 2 ], 2 ) +
          Math.pow( a1 - a2, 2 );

}

//

var _colorNameNearest = function _colorNameNearest( color )
{
  var self = this;

  _.assert( arguments.length === 1 );

  if( _.strIs( color ) )
  {
    _.assert( self.ColorMap[ color ],'unknown color',color );
    return color;
  }

  color = _rgbaFromNotName( color );

  _.assert( color.length === 4 );

  for( var r = 0 ; r < 4 ; r++ )
  {
    color[ r ] = Number( color[ r ] );
    if( color[ r ] < 0 )
    color[ r ] = 0;
    else if( color[ r ] > 1 )
    color[ r ] = 1;
  }

  if( color[ 3 ] === undefined )
  color[ 3 ] = 1;

  /* */

  var names = Object.keys( self.ColorMap );
  var nearest = names[ 0 ];
  var max = _colorDistance( self.ColorMap[ names[ 0 ] ], color );

  for( var i = 1; i <= names.length - 1; i++ )
  {
    var d = _colorDistance( self.ColorMap[ names[ i ] ], color );
    if( d < max )
    {
      max = d;
      nearest = names[ i ];
    }

    if( d === 0 )
    return names[ i ];
  }

  return nearest;
}

//

var colorNameNearest = function colorNameNearest( color )
{
  var self = this;

  _.assert( arguments.length === 1 );

  if ( _.strIs( color ) )
  {
    var color2 = _.color.hexToColor( color );
    if( color2 )
    color = color2;
  }

  try
  {
    return self._colorNameNearest( color );
  }
  catch( err )
  {
    return;
  }

}

//

var colorToHex = function( rgb, def )
{

  _.assert( arguments.length === 1 || arguments.length === 2 )

  // if( arguments.length === 3 )
  // {
  //   return "#" + ( ( 1 << 24 ) + ( Math.floor(rgb*255) << 16) + ( Math.floor( g*255 ) << 8 ) + Math.floor( b*255 ) ).toString( 16 ).slice( 1 );
  // }
  // else

  if( _.arrayIs( rgb ) )
  {
    throw _.err( 'not tested' );
    return "#" + ( ( 1 << 24 ) + ( Math.floor( rgb[ 0 ]*255 ) << 16 ) + ( Math.floor( rgb[ 1 ]*255 ) << 8 ) + Math.floor( rgb[ 2 ]*255 ) )
    .toString( 16 ).slice( 1 );
  }
  else if( _.numberIs( rgb ) )
  {
    throw _.err( 'not tested' );
    return ( Math.floor( rgb ) )
    .toString( 16 );
  }
  else if( _.objectIs( rgb ) )
  {
    throw _.err( 'not tested' );
    return "#" + ( ( 1 << 24 ) + ( Math.floor( rgb.r*255 ) << 16 ) + ( Math.floor( rgb.g*255 ) << 8 ) + Math.floor( rgb.b*255 ) )
    .toString( 16 ).slice( 1 );
  }
  else if( _.strIs( rgb ) )
  {
    throw _.err( 'not tested' );
    if( !rgb.length )
    return def;
    else if( rgb[ 0 ] == '#' )
    return rgb;
    else
    return '#' + rgb;
  }

  return def;
}

//

var hexToColor = function hexToColor( hex )
{

  _.assert( arguments.length === 1 );
  _.assert( _.strIs( hex ) );

  var shorthandRegex = /^#?([a-f\d])([a-f\d])([a-f\d])$/i;
  hex = hex.replace( shorthandRegex, function( m, r, g, b )
  {
    return r + r + g + g + b + b;
  });

  var result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec( hex );
  if( !result )
  return null;

  result =
  [
    parseInt( result[ 1 ], 16) / 255,
    parseInt( result[ 2 ], 16) / 255,
    parseInt( result[ 3 ], 16) / 255,
  ]

  return result;
}

//

var colorToRgbHtml = function( src )
{
  var result = '';

  _.assert( _.strIs( src ) || _.objectIs( src ) || _.arrayIs( src ) );
  _.assert( arguments.length === 1 );


  if( _.strIs( src ) )
  return src;

  if( _.objectIs( src ) )
  src = [ src.r,src.g,src.b,src.a ];

  if( _.arrayIs( src ) )
  {
    result += 'rgb( ';
    result += String( Math.floor( src[ 0 ]*255 ) ) + ', ';
    result += String( Math.floor( src[ 1 ]*255 ) ) + ', ';
    result += String( Math.floor( src[ 2 ]*255 ) );
    result += ' )';
  }
  else result = src;

  //console.log( 'colorHtmlToRgbHtml',result );

  return result;
}

//

var colorToRgbaHtml = function( src )
{
  var result = '';

  _.assert( _.strIs( src ) || _.objectIs( src ) || _.arrayIs( src ) );
  _.assert( arguments.length === 1 );

  if( _.strIs( src ) )
  return src;

  if( _.objectIs( src ) )
  src = [ src.r,src.g,src.b,src.a ];

  if( _.arrayIs( src ) )
  {
    result += 'rgba( ';
    result += String( Math.floor( src[ 0 ]*255 ) ) + ', ';
    result += String( Math.floor( src[ 1 ]*255 ) ) + ', ';
    result += String( Math.floor( src[ 2 ]*255 ) );
    if( src[ 3 ] !== undefined )
    result += ', ' + String( src[ 3 ] );
    else
    result += ', ' + '1';
    result += ' )';
  }
  else if( _.numberIs( src ) )
  {
    result = colorToRgbaHtml
    ({
      r : ( ( src >> 16 ) & 0xff ) / 255,
      g : ( ( src >> 8 ) & 0xff ) / 255,
      b : ( ( src ) & 0xff ) / 255
    });
  }
  else result = src;

  return result;
}

//

var mulSaturation = function( rgb,factor )
{
  _.assert( arguments.length === 2 );
  _.assert( factor >= 0 );

  var hsl = rgbToHsl( rgb );

  hsl[ 1 ] *= factor;

  var result = hslToRgb( hsl );

  if( rgb.length === 4 )
  result[ 3 ] = rgb[ 3 ];

  return result;
}

//

var brighter = function( rgb,factor )
{
  if( factor === undefined )
  factor = 0.1;

  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( factor >= 0 );

  return mulSaturation( rgb,1 + factor );
}

//

/*
  ( 1+factor ) * c2 = c1
  ( 1-efactor ) * c1 = c2

  ( 1-efactor ) * ( 1+factor ) = 1
  1+factor-efactor-efactor*factor = 1
  factor-efactor-efactor*factor = 0
  -efactor( 1+factor ) = factor
  efactor = - factor / ( 1+factor )
*/

var paler = function( rgb,factor )
{
  if( factor === undefined )
  factor = 0.1;

  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( 0 <= factor && factor <= 1 );

  var efactor = factor / ( 1+factor );

  return mulSaturation( rgb,1 - efactor );
}

// --
// int
// --

var colorWidthForExponential = function( width )
{

  return 1 + 63 * width;

}

//

var rgbWithInt = function( srcInt )
{
  var result = [];

  _.assert( arguments.length === 1 );
  _.assert( _.numberIs( srcInt ),'rgbWithInt :','expects srcInt' );

  /* eval degree */

  var degree = 1;
  var left = srcInt;

  if( left >= 6 )
  {

    left -= 6;
    degree = 2;
    var n = 6;
    var d = 0;

    while( left >= n )
    {
      left -= n;
      degree += 1;
      d += 1;
      n *= degree;
      n /= d;
    }

  }

  /* compose set of elements */

  var set = [ 0.1 ];
  var e = 0.95;
  if( degree >= 2 ) e = 0.8;
  do
  {
    set.push( e );
    //e /= 2;

    if( set.length === 2 )
    {
      e = 0.5;
    }
    else if( set.length === 3 )
    {
      e = 0.35;
    }
    else if( set.length === 4 )
    {
      e = 0.75;
    }
    else
    {
      e *= 0.5;
    }

  }
  while( set.length <= degree );
  var last = set.length - 1;

  /* fill routine */

  var fillWithElements = function( i1,i2,i3 )
  {
    result[ left ] = set[ i1 ];
    result[ ( left+1 )%3 ] = set[ i2 ];
    result[ ( left+2 )%3 ] = set[ i3 ];

    return result;
  }

  /* fill result vector */

  if( degree === 1 )
  {

    if( left < 3 )
    return fillWithElements( last,0,0 );
    left -= 3;

    if( left < 3 )
    return fillWithElements( 0,last,last );
    left -= 3;

  }

  /* */

  for( var c1 = set.length - 2 ; c1 >= 0 ; c1-- )
  {

    for( var c2 = c1 - 1 ; c2 >= 0 ; c2-- )
    {

      if( left < 3 )
      return fillWithElements( last,c1,c2 );
      left -= 3;

      if( left < 3 )
      return fillWithElements( last,c2,c1 );
      left -= 3;

    }

  }

  /* */

  throw _.err( 'rgbWithInt :','No color for',srcInt );
}

//

var _rgbWithInt = function( srcInt )
{
  var result;

  _.assert( _.numberIs( srcInt ),'rgbWithInt :','expects srcInt' );

  var c = 9;

  srcInt = srcInt % c;
  srcInt -= 0.3;
  if( srcInt < 0 ) srcInt += c;
  //result = hslToRgb([ srcInt / 11, 1, 0.5 ]);

  result = hslToRgb([ srcInt / c, 1, 0.5 ]);

  return result;
}

// --
// hsl
// --

var hslToRgb = function( hsl,result )
{
  var result = result || [];
  var h = hsl[ 0 ];
  var s = hsl[ 1 ];
  var l = hsl[ 2 ];

  if( s === 0 )
  {
    result[ 0 ] = 1;
    result[ 1 ] = 1;
    result[ 2 ] = 1;
    return result;
  }

  var get = function( a, b, h )
  {

    if ( h < 0 ) h += 1;
    if ( h > 1 ) h -= 1;

    if ( h < 1 / 6 ) return b + ( a - b ) * 6 * h;
    if ( h < 1 / 2 ) return a;
    if ( h < 2 / 3 ) return b + ( a - b ) * 6 * ( 2 / 3 - h );

    return b;
  }

  var a = l <= 0.5 ? l * ( 1 + s ) : l + s - ( l * s );
  var b = ( 2 * l ) - a;

  result[ 0 ] = get( a, b, h + 1 / 3 );
  result[ 1 ] = get( a, b, h );
  result[ 2 ] = get( a, b, h - 1 / 3 );

  return result;
}

//

var rgbToHsl = function rgbToHsl( rgb,result )
{
  var result = result || [];
  var hue, saturation, lightness;
  var r = rgb[ 0 ];
  var g = rgb[ 1 ];
  var b = rgb[ 2 ];

  var max = Math.max( r, g, b );
  var min = Math.min( r, g, b );

  lightness = ( min + max ) / 2.0;

  if ( min === max )
  {

    hue = 0;
    saturation = 0;

  }
  else
  {

    var diff = max - min;

    if( lightness <= 0.5 )
    saturation = diff / ( max + min );
    else
    saturation = diff / ( 2 - max - min );

    switch( max )
    {
      case r : hue = ( g - b ) / diff + ( g < b ? 6 : 0 ); break;
      case g : hue = ( b - r ) / diff + 2; break;
      case b : hue = ( r - g ) / diff + 4; break;
    }

    hue /= 6;

  }

  result[ 0 ] = hue;
  result[ 1 ] = saturation;
  result[ 2 ] = lightness;

  return result;
}

// --
// random
// --

var randomRgbWithSl = function randomRgbWithSl( s,l )
{

  _.assert( arguments.length <= 2 );

  if( s === undefined )
  s = 1.0;
  if( l === undefined )
  l = 0.5;

  //this.setHSL( Math.random(), s, l );

  var rgb = hslToRgb([ Math.random(), s, l ]);

  return rgb;
}

// --
// var
// --

var ColorMap =
{

  'invisible'       : [ 0.0,0.0,0.0,0.0 ],
  'transparent'     : [ 1.0,1.0,1.0,0.5 ],

  'cyan'            : [ 0.0,1.0,1.0 ],
  'magenta'         : [ 1.0,0.0,1.0 ],
  'maroon'          : [ 0.5,0.0,0.0 ],
  'dark green'      : [ 0.0,0.5,0.0 ],
  'navy'            : [ 0.0,0.0,0.5 ],
  'olive'           : [ 0.5,0.5,0.0 ],
  'teal'            : [ 0.0,0.5,0.5 ],
  'bright green'    : [ 0.5,1.0,0.0 ],
  'spring green'    : [ 0.0,1.0,0.5 ],
  'pink'            : [ 1.0,0.0,0.5 ],
  'dark orange'     : [ 1.0,0.5,0.0 ],
  'azure'           : [ 0.0,0.5,1.0 ],
  'dark blue'       : [ 0.0,0.0,0.63 ],
  'brown'           : [ 0.65,0.16,0.16 ],

}

//

var ColorMapGreyscale =
{

  'white'           : [ 1.0,1.0,1.0 ],
  'silver'          : [ 0.75,0.75,0.75 ],
  'gray'            : [ 0.5,0.5,0.5 ],
  'dim'             : [ 0.35,0.35,0.35 ],
  'black'           : [ 0.0,0.0,0.0 ],

}

//

var ColorMapDistinguishable =
{

  'yellow'          : [ 1.0,1.0,0.0 ],
  'purple'          : [ 0.5,0.0,0.5 ],
  'orange'          : [ 1.0,0.65,0.0 ],
  'light blue'      : [ 0.68,0.85,0.9 ],
  'red'             : [ 1.0,0.0,0.0 ],
  'buff'            : [ 0.94,0.86,0.51 ],
  'gray'            : [ 0.5,0.5,0.5 ],
  'green'           : [ 0.0,1.0,0.0 ],
  'purplish pink'   : [ 0.96,0.46,0.56 ],
  'blue'            : [ 0.0,0.0,1.0 ],
  'yellowish pink'  : [ 1.0,0.48,0.36 ],
  'violet'          : [ 0.5,0.0,1.0 ],
  'orange yellow'   : [ 1.0,0.56,0.0 ],
  'purplish red'    : [ 0.7,0.16,0.32 ],
  'greenish yellow' : [ 0.96,0.78,0.0 ],
  'reddish brown'   : [ 0.5,0.1,0.05 ],
  'yellow green'    : [ 0.57,0.6,0.0 ],
  'yellowish brown' : [ 0.34,0.2,0.08 ],
  'reddish orange'  : [ 0.95,0.23,0.07 ],
  'olive green'     : [ 0.14,0.17,0.09 ],

}

//

var ColorMapShell =
{
  'black'           : [ 0.0,0.0,0.0 ],
  'red'             : [ 1.0,0.0,0.0 ],
  'green'           : [ 0.0,1.0,0.0 ],
  'yellow'          : [ 1.0,1.0,0.0 ],
  'blue'            : [ 0.0,0.0,1.0 ],
  'magenta'         : [ 1.0,0.0,1.0 ],
  'cyan'            : [ 0.0,1.0,1.0 ],
  'white'           : [ 1.0,1.0,1.0 ],
}

// --
// prototype
// --

var Self =
{

  //

  colorByName : colorByName,
  _colorByName : _colorByName,

  rgbByBitmask : rgbByBitmask,
  _rgbByBitmask : _rgbByBitmask,

  _rgbaFromNotName : _rgbaFromNotName,

  rgbaFrom : rgbaFrom,
  rgbFrom : rgbFrom,

  rgbaFromTry : rgbaFromTry,
  rgbFromTry : rgbFromTry,

  _colorDistance : _colorDistance,

  _colorNameNearest : _colorNameNearest,
  colorNameNearest : colorNameNearest,

  colorToHex : colorToHex,
  hexToColor : hexToColor,

  colorToRgbHtml : colorToRgbHtml,
  colorToRgbaHtml : colorToRgbaHtml,

  mulSaturation : mulSaturation,
  brighter : brighter,
  paler : paler,


  // int

  colorWidthForExponential : colorWidthForExponential,
  rgbWithInt : rgbWithInt,
  _rgbWithInt : _rgbWithInt,


  // hsl

  hslToRgb : hslToRgb,
  rgbToHsl : rgbToHsl,


  // random

  random : randomRgbWithSl,
  randomRgbWithSl : randomRgbWithSl,


  // var

  ColorMap : ColorMap,
  ColorMapGreyscale : ColorMapGreyscale,
  ColorMapDistinguishable : ColorMapDistinguishable,
  ColorMapShell : ColorMapShell

}

if( !wTools.color )
{
  wTools.color = Self;
}
else
{

  _.mapSupplement( wTools.color,Self );
  _.mapSupplement( wTools.color.ColorMap,ColorMap );
  _.mapSupplement( wTools.color.ColorMapGreyscale,ColorMapGreyscale );
  _.mapSupplement( wTools.color.ColorMapDistinguishable,ColorMapDistinguishable );
  _.mapSupplement( wTools.color.ColorMapShell,ColorMapShell );

}

_.mapSupplement( wTools.color.ColorMap,ColorMapGreyscale );
_.mapSupplement( wTools.color.ColorMap,ColorMapDistinguishable );
_.mapSupplement( wTools.color.ColorMap,ColorMapShell );

})();
