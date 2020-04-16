(function _Color_s_() {

'use strict';

/**
 * Collection of routines to operate colors conveniently. Color provides functions to convert color from one color space to another color space, from name to color and from color to the closest name of a color. The module does not introduce any specific storage format of color what is a benefit. Color has a short list of the most common colors. Use the module for formatted colorful output or other sophisticated operations with colors.
  @module Tools/mid/Color
*/

/**
 * @summary Collection of routines to operate colors conveniently.
 * @namespace "wTools.color"
 * @module Tools/mid/Color
*/

if( typeof module !== 'undefined' )
{

  require( '../../../dwtools/Tools.s' );

}

let _ = _global_.wTools;

//

/**
 * @summary Returns rgb value for color with provided `name`.
 * @param {String} name Target color name.
 * @param {} def Default value. Is used if nothing was found.
 * @example
 * _.color.rgbFromName( 'black' );
 * @example
 * _.color.rgbFromName( 'black', [ 0, 0, 0 ] );
 * @throws {Error} If no arguments provided.
 * @function rgbFromName
 * @namespace wTools.color
 * @module Tools/mid/Color
 */

function rgbFromName( name, def )
{
  let o = _.routineOptionsFromThis( rgbFromName, this, Self );

  _.routineOptions( rgbFromName, o );

  let result;
  if( !o.colorMap )
  o.colorMap = Self.ColorMap;

  _.assert( arguments.length <= 2 );
  _.assert( _.strIs( name ) );

  name = name.toLowerCase();
  name = name.trim();

  return _rgbFromName( name, def, o.colorMap );
}

rgbFromName.defaults =
{
  colorMap : null,
}

//

function _rgbFromName( name, def, map )
{
  let result = map[ name ];

  if( !result )
  result = def;

  return result;
}

//

/**
 * @summary Gets rgb values from bitmask `src`.
 * @param {Number} src Source bitmask.
 * @example
 * _.color.rgbByBitmask( 0xff00ff );
 * //[1, 0, 1]
 * @throws {Error} If no arguments provided.
 * @function rgbFromName
 * @namespace wTools.color
 * @module Tools/mid/Color
 */

function rgbByBitmask( src )
{

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.numberIs( src ) );

  return _rgbByBitmask( src );
}

//

function _rgbByBitmask( src )
{
  let result = [];

  result[ 0 ] = ( ( src >> 16 ) & 0xff ) / 255;
  result[ 1 ] = ( ( src >> 8 ) & 0xff ) / 255;
  result[ 2 ] = ( ( src >> 0 ) & 0xff ) / 255;

  return result;
}

//

function _rgbaFromNotName( src )
{

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.numberIs( src ) || _.longIs( src ) || _.mapIs( src ) );

  if( _.mapIs( src ) )
  {
    let result = [];
    result[ 0 ] = src.r === undefined ? 1 : src.r;
    result[ 1 ] = src.g === undefined ? 1 : src.g;
    result[ 2 ] = src.b === undefined ? 1 : src.b;
    result[ 3 ] = src.a === undefined ? 1 : src.a;
    return result;
  }

  if( _.numberIs( src ) )
  {
    let result = _rgbByBitmask( src );
    return _.longGrowInplace( result, [ 0, 4 ], 1 );
  }

  let result = [];

  /* */

  for( let r = 0 ; r < src.length ; r++ )
  result[ r ] = Number( src[ r ] );

  if( result.length < 4 )
  result[ 3 ] = 1;

  /* */

  return result;
}

//

/**
 * @summary Returns rgba color values for provided entity `src`.
 * @param {Number|Array|String|Object} src Source entity.
 * @example
 * _.color.rgbaFrom( 0xFF0080 );
 * //[ 1, 0, 0.5, 1 ]
 *
 * @example
 * _.color.rgbaFrom( { r : 0 } );
 * //[ 0, 1, 1, 1 ]
 *
 * @example
 * _.color.rgbaFrom( 'white' );
 * //[ 1, 1, 1, 1 ]
 *
 * @example
 * _.color.rgbaFrom( '#ffffff );
 * //[ 1, 1, 1, 1 ]
 *
 * @example
 * _.color.rgbaFrom( [ 1, 1, 1 ] );
 * //[ 1, 1, 1, 1 ]
 *
 * @throws {Error} If no arguments provided.
 * @function rgbaFrom
 * @namespace wTools.color
 * @module Tools/mid/Color
 */

function rgbaFrom( src )
{
  let result;

  _.assert( arguments.length === 1, 'Expects single argument' );

  if( _.numberIs( src ) || _.longIs( src ) || _.mapIs( src ) )
  return _rgbaFromNotName( src );

  /* */

  if( _.strIs( src ) )
  result = rgbFromName.call( this, src );

  if( result )
  {
    if( result.length !== 4 )
    result = _.longGrowInplace( result, [ 0, 4 ], 1 );
    return result;
  }

  /* */

  if( _.strIs( src ) )
  result = _.color.hexToColor( src );

  if( result )
  {
    if( result.length !== 4 )
    result = _.longGrowInplace( result, [ 0, 4 ], 1 );

    return result;
  }

  /* */

  _.assertWithoutBreakpoint( 0, 'Unknown color', _.strQuote( src ) );
}

rgbaFrom.defaults =
{
  colorMap : null,
}

//

/**
 * @summary Short-cut for {@link module:Tools/mid/Color.wTools.color.rgbaFrom}.
 * @description Returns rgb color values for provided entity `src`.
 * @param {Number|Array|String|Object} src Source entity.
 * @example
 * _.color.rgbFrom( 0xFF0080 );
 * //[ 1, 0, 0.5 ]
 *
 * @example
 * _.color.rgbFrom( { r : 0 } );
 * //[ 0, 1, 1 ]
 *
 * @example
 * _.color.rgbFrom( 'white' );
 * //[ 1, 1, 1 ]
 *
 * @example
 * _.color.rgbFrom( '#ffffff );
 * //[ 1, 1, 1 ]
 *
 * @example
 * _.color.rgbFrom( [ 1, 1, 1 ] );
 * //[ 1, 1, 1 ]
 *
 * @throws {Error} If no arguments provided.
 * @function rgbFrom
 * @namespace wTools.color
 * @module Tools/mid/Color
 */

function rgbFrom( src )
{
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( _.longIs( src ) )
  return _.longSlice( src, 0, 3 );

  let result = rgbaFrom.call( this, src );

  return _.longSlice( result, 0, 3 );
}

rgbFrom.defaults =
{
}

rgbFrom.defaults.__proto__ = rgbaFrom.defaults;

//

/**
 * @summary Short-cut for {@link module:Tools/mid/Color.wTools.color.rgbaFrom}.
 * @description Returns rgba color values for provided entity `src` or default value if nothing was found.
 * @param {Number|Array|String|Object} src Source entity.
 * @param {Array} def Default value.
 *
 * @example
 * _.color.rgbaFrom( 'some_color', [ 1, 0, 0.5, 1 ] );
 * //[ 1, 0, 0.5, 1 ]
 *
 * @throws {Error} If no arguments provided.
 * @function rgbaFromTry
 * @namespace wTools.color
 * @module Tools/mid/Color
 */

function rgbaFromTry( src, def )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  try
  {
    return rgbaFrom.call( this, src );
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

/**
 * @summary Short-cut for {@link module:Tools/mid/Color.wTools.color.rgbaFrom}.
 * @description Returns rgb color values for provided entity `src` or default value if nothing was found.
 * @param {Number|Array|String|Object} src Source entity.
 * @param {Array} def Default value.
 *
 * @example
 * _.color.rgbFrom( 'some_color', [ 1, 0, 0.5 ] );
 * //[ 1, 0, 0.5 ]
 *
 * @throws {Error} If no arguments provided.
 * @function rgbFromTry
 * @namespace wTools.color
 * @module Tools/mid/Color
 */

function rgbFromTry( src, def )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  try
  {
    return rgbFrom.call( this, src );
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

function _colorDistance( c1, c2 )
{
  _.assert( _.longIs( c1 ) );
  _.assert( _.longIs( c2 ) );

  let a = c1.slice();
  let b = c2.slice();

  // function _definedIs( src )
  // {
  //   return src !== undefined && src !== null && !isNaN( src )
  // }

  for( let  i = 0 ; i < 4 ; i++ )
  {
    if( !_.numberIsFinite( a[ i ] ) )
    // a[ i ] = _definedIs( b[ i ] ) ? b[ i ] : 1;
    a[ i ] = 1;

    if( !_.numberIsFinite( b[ i ] ) )
    // b[ i ] = _definedIs( a[ i ] ) ? a[ i ] : 1;
    b[ i ] = 1;
  }

  // a[ 3 ] = _definedIs( a[ 3 ] ) ? a[ i ] : 1;
  // b[ 3 ] = _definedIs( b[ 3 ] ) ? b[ i ] : 1;

  return  Math.pow( a[ 0 ] - b[ 0 ], 2 ) +
          Math.pow( a[ 1 ] - b[ 1 ], 2 ) +
          Math.pow( a[ 2 ] - b[ 2 ], 2 ) +
          Math.pow( a[ 3 ] - b[ 3 ], 2 )
}

//

function _colorNameNearest( color, map )
{
  let self = this;

  _.assert( arguments.length === 1 || arguments.length === 2 );

  if( arguments.length === 1 )
  map = _.color.ColorMap;

  _.assert( _.objectIs( map ) );

  if( _.strIs( color ) )
  {
    _.assertWithoutBreakpoint( map[ color ], 'Unknown color', _.strQuote( color ) );

    if( _.objectLike( map[ color ] ) )
    {
      _.assert( map[ color ].name );
      return self._colorNameNearest( map[ color ].name, map );
    }

    return color;
  }

  color = _rgbaFromNotName( color );

  _.assert( color.length === 4 );

  for( let r = 0 ; r < 4 ; r++ )
  {
    color[ r ] = Number( color[ r ] );
    if( color[ r ] < 0 )
    color[ r ] = 0;
    else if( color[ r ] > 1 )
    color[ r ] = 1;
  }

  // if( color[ 3 ] === undefined )
  // color[ 3 ] = 1;

  /* */

  let names = Object.keys( map );
  let nearest = names[ 0 ];
  let max = _colorDistance( map[ names[ 0 ] ], color );

  if( max === 0 )
  return nearest;

  for( let i = 1; i <= names.length - 1; i++ )
  {
    let d = _colorDistance( map[ names[ i ] ], color );
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

/**
 * @summary Returns name of color that is nearest to provided `color`.
 * @param {Number|Array|String|Object} color Source color.
 *
 * @example
 * _.color.colorNameNearest( [ 1, 1, 1, 0.8 ] );
 * //'white'
 *
 * @example
 * _.color.colorNameNearest( [ 1, 1, 1, 0.3 ] );
 * //'transparent'
 *
 * @throws {Error} If no arguments provided.
 * @function colorNameNearest
 * @namespace wTools.color
 * @module Tools/mid/Color
 */

function colorNameNearest( color )
{
  let self = this;

  _.assert( arguments.length === 1, 'Expects single argument' );

  if( _.strIs( color ) )
  {
    let color2 = _.color.hexToColor( color );
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

function colorNearestCustom( o )
{
  let self = this;

  _.assert( arguments.length === 1, 'Expects single argument' );

  _.routineOptions( colorNearestCustom, o );

  if( _.strIs( o.color ) )
  {
    let _color = _.color.hexToColor( o.color );
    if( _color )
    o.color = _color;
  }

  try
  {
    let name = self._colorNameNearest( o.color, o.colorMap );
    return o.colorMap[ name ];
  }
  catch( err )
  {
    return;
  }
}

colorNearestCustom.defaults =
{
  color : null,
  colorMap : null
}

//

/**
 * @summary Returns value of color that is nearest to provided `color`.
 * @param {Number|Array|String|Object} color Source color.
 *
 * @example
 * _.color.colorNearest( [ 1, 1, 1, 0.8 ] );
 * //[ 1, 1, 1, 1 ]
 *
 * @throws {Error} If no arguments provided.
 * @function colorNameNearest
 * @namespace wTools.color
 * @module Tools/mid/Color
 */

function colorNearest( color )
{
  let self = this;

  let name = self.colorNameNearest( color );
  if( name )
  return self.ColorMap[ name ];
}

//

/**
 * @summary Returns hex value for provided color `rgb`.
 * @param {Number|Array|String|Object} color Source color.
 * @param {Array} def Default value.
 *
 * @example
 * _.color.colorToHex( [ 1, 0, 1 ] );
 * //'#ff00ff'
 *
 * @throws {Error} If no arguments provided.
 * @function colorToHex
 * @namespace wTools.color
 * @module Tools/mid/Color
 */

function colorToHex( rgb, def )
{

  _.assert( arguments.length === 1 || arguments.length === 2 )

  // if( arguments.length === 3 )
  // {
  //   return "#" + ( ( 1 << 24 ) + ( Math.floor(rgb*255) << 16) + ( Math.floor( g*255 ) << 8 ) + Math.floor( b*255 ) ).toString( 16 ).slice( 1 );
  // }
  // else

  if( _.arrayIs( rgb ) )
  {
    // throw _.err( 'not tested' );
    return "#" + ( ( 1 << 24 ) + ( Math.floor( rgb[ 0 ]*255 ) << 16 ) + ( Math.floor( rgb[ 1 ]*255 ) << 8 ) + Math.floor( rgb[ 2 ]*255 ) )
    .toString( 16 ).slice( 1 );
  }
  else if( _.numberIs( rgb ) )
  {
    // throw _.err( 'not tested' );
    let hex = Math.floor( rgb ).toString( 16 );
    return '#' + _.strDup( '0', 6 - hex.length  ) + hex;
  }
  else if( _.objectIs( rgb ) )
  {
    // throw _.err( 'not tested' );
    return "#" + ( ( 1 << 24 ) + ( Math.floor( rgb.r*255 ) << 16 ) + ( Math.floor( rgb.g*255 ) << 8 ) + Math.floor( rgb.b*255 ) )
    .toString( 16 ).slice( 1 );
  }
  else if( _.strIs( rgb ) )
  {
    // throw _.err( 'not tested' );
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

/**
 * @summary Returns rgb value for provided `hex` value.
 * @param {String} hex Source color.
 *
 * @example
 * _.color.colorToHex( '#ff00ff' );
 * //[ 1, 0, 1 ]
 *
 * @throws {Error} If no arguments provided.
 * @function hexToColor
 * @namespace wTools.color
 * @module Tools/mid/Color
 */

function hexToColor( hex )
{

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( hex ) );

  let shorthandRegex = /^#?([a-f\d])([a-f\d])([a-f\d])$/i;
  hex = hex.replace( shorthandRegex, function( m, r, g, b )
  {
    return r + r + g + g + b + b;
  });

  let result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec( hex );
  if( !result )
  return null;

  result =
  [
    parseInt( result[ 1 ], 16 ) / 255,
    parseInt( result[ 2 ], 16 ) / 255,
    parseInt( result[ 3 ], 16 ) / 255,
  ]

  return result;
}

//

function colorToRgbHtml( src )
{
  let result = '';

  _.assert( _.strIs( src ) || _.objectIs( src ) || _.arrayIs( src ) );
  _.assert( arguments.length === 1, 'Expects single argument' );


  if( _.strIs( src ) )
  return src;

  if( _.objectIs( src ) )
  src = [ src.r, src.g, src.b, src.a ];

  if( _.arrayIs( src ) )
  {
    for( let i = 0; i < 3; i++ )
    _.assert( src[ i ] >= 0 && src[ i ] <= 1 )

    result += 'rgb( ';
    result += String( Math.floor( src[ 0 ]*255 ) ) + ', ';
    result += String( Math.floor( src[ 1 ]*255 ) ) + ', ';
    result += String( Math.floor( src[ 2 ]*255 ) );
    result += ' )';
  }
  else result = src;

  //console.log( 'colorHtmlToRgbHtml', result );

  return result;
}

//

function colorToRgbaHtml( src )
{
  let result = '';

  _.assert( _.strIs( src ) || _.objectIs( src ) || _.arrayIs( src ) || _.numberIs( src ) );
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( _.strIs( src ) )
  return src;

  if( _.objectIs( src ) )
  src = [ src.r, src.g, src.b, src.a ];

  if( _.arrayIs( src ) )
  {
    for( let i = 0; i < 3; i++ )
    _.assert( src[ i ] >= 0 && src[ i ] <= 1 )

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

function mulSaturation( rgb, factor )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( factor >= 0 );

  let hsl = rgbToHsl( rgb );

  hsl[ 1 ] *= factor;

  let result = hslToRgb( hsl );

  if( rgb.length === 4 )
  result[ 3 ] = rgb[ 3 ];

  return result;
}

//

function brighter( rgb, factor )
{
  if( factor === undefined )
  factor = 0.1;

  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( factor >= 0 );

  return mulSaturation( rgb, 1 + factor );
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

function paler( rgb, factor )
{
  if( factor === undefined )
  factor = 0.1;

  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( 0 <= factor && factor <= 1 );

  let efactor = factor / ( 1+factor );

  return mulSaturation( rgb, 1 - efactor );
}

//

// --
// int
// --

function colorWidthForExponential( width )
{

  return 1 + 63 * width;

}

//

function rgbWithInt( srcInt )
{
  let result = [];

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.numberIs( srcInt ), 'rgbWithInt :', 'Expects srcInt' );

  /* eval degree */

  let degree = 1;
  let left = srcInt;

  if( left >= 6 )
  {

    left -= 6;
    degree = 2;
    let n = 6;
    let d = 0;

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

  let set = [ 0.1 ];
  let e = 0.95;
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
  let last = set.length - 1;

  /* fill routine */

  function fillWithElements( i1, i2, i3 )
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
    return fillWithElements( last, 0, 0 );
    left -= 3;

    if( left < 3 )
    return fillWithElements( 0, last, last );
    left -= 3;

  }

  /* */

  for( let c1 = set.length - 2 ; c1 >= 0 ; c1-- )
  {

    for( let c2 = c1 - 1 ; c2 >= 0 ; c2-- )
    {

      if( left < 3 )
      return fillWithElements( last, c1, c2 );
      left -= 3;

      if( left < 3 )
      return fillWithElements( last, c2, c1 );
      left -= 3;

    }

  }

  /* */

  throw _.err( 'rgbWithInt :', 'No color for', srcInt );
}

//

function _rgbWithInt( srcInt )
{
  let result;

  _.assert( _.numberIs( srcInt ), 'rgbWithInt :', 'Expects srcInt' );

  let c = 9;

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

function hslToRgb( hsl, result )
{
  result = result || [];
  let h = hsl[ 0 ];
  let s = hsl[ 1 ];
  let l = hsl[ 2 ];

  if( s === 0 )
  {
    result[ 0 ] = 1;
    result[ 1 ] = 1;
    result[ 2 ] = 1;
    return result;
  }

  function get( a, b, h )
  {

    if( h < 0 ) h += 1;
    if( h > 1 ) h -= 1;

    if( h < 1 / 6 ) return b + ( a - b ) * 6 * h;
    if( h < 1 / 2 ) return a;
    if( h < 2 / 3 ) return b + ( a - b ) * 6 * ( 2 / 3 - h );

    return b;
  }

  let a = l <= 0.5 ? l * ( 1 + s ) : l + s - ( l * s );
  let b = ( 2 * l ) - a;

  result[ 0 ] = get( a, b, h + 1 / 3 );
  result[ 1 ] = get( a, b, h );
  result[ 2 ] = get( a, b, h - 1 / 3 );

  return result;
}

//

function rgbToHsl( rgb, result )
{
  result = result || [];
  let hue, saturation, lightness;
  let r = rgb[ 0 ];
  let g = rgb[ 1 ];
  let b = rgb[ 2 ];

  let max = Math.max( r, g, b );
  let min = Math.min( r, g, b );

  lightness = ( min + max ) / 2.0;

  if( min === max )
  {

    hue = 0;
    saturation = 0;

  }
  else
  {

    let diff = max - min;

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

function randomHsl( s, l )
{

  _.assert( arguments.length <= 2 );

  if( s === undefined )
  s = 1.0;
  if( l === undefined )
  l = 0.5;

  let hsl = [ Math.random(), s, l ];

  return hsl;
}

//

function randomRgbWithSl( s, l )
{

  _.assert( arguments.length <= 2 );

  if( s === undefined )
  s = 1.0;
  if( l === undefined )
  l = 0.5;

  let rgb = hslToRgb([ Math.random(), s, l ]);

  return rgb;
}

// --
// etc
// --

function gammaToLinear( dst )
{

  if( Object.isFrozen( dst ) )
  debugger;

  _.assert( dst.length === 3 || dst.length === 4 );

  dst[ 0 ] = dst[ 0 ]*dst[ 0 ];
  dst[ 1 ] = dst[ 1 ]*dst[ 1 ];
  dst[ 2 ] = dst[ 2 ]*dst[ 2 ];

  return dst;
}

//

function linearToGamma( dst )
{

  _.assert( dst.length === 3 || dst.length === 4 );

  dst[ 0 ] = _.math.sqrt( dst[ 0 ] );
  dst[ 1 ] = _.math.sqrt( dst[ 1 ] );
  dst[ 2 ] = _.math.sqrt( dst[ 2 ] );

  return dst;
}

// --
// str
// --

// function _strDirectiveBackgroundFor( color )
// {
//   let result = Object.create( null );
//
//   _.assert( arguments.length === 1, 'Expects single argument' );
//   _.assert( _.strIs( color ) );
//
//   result.pre = `#background : ${color}#`;
//   result.post = `#background : default#`;
//
//   return result;
// }
//
// //
//
// function strFormatBackground( srcStr, color )
// {
//
//   if( _.numberIs( color ) )
//   color = _.color.colorNameNearest( color );
//
//   _.assert( arguments.length === 2, 'Expects 2 arguments' );
//   _.assert( _.strIs( srcStr ) );
//   _.assert( _.strIs( color ) );
//
//   return `#background : ${color}#${srcStr}#background : default#`;
// }
//
// //
//
// function _strDirectiveForegroundFor( color )
// {
//   let result = Object.create( null );
//
//   _.assert( arguments.length === 1, 'Expects single argument' );
//   _.assert( _.strIs( color ) );
//
//   result.pre = `#foreground : ${color}#`;
//   result.post = `#foreground : default#`;
//
//   return result;
// }
//
// //
//
// function strFormatForeground( srcStr, color )
// {
//
//   if( _.numberIs( color ) )
//   color = _.color.colorNameNearest( color );
//
//   _.assert( arguments.length === 2, 'Expects 2 arguments' );
//   _.assert( _.strIs( srcStr ), 'Expects string {-src-}' );
//   _.assert( _.strIs( color ), 'Expects string {-color-}' );
//
//   return `#foreground : ${color}#${srcStr}#foreground : default#`;
// }

//

function _strFormat( srcStr, style )
{
  let result = srcStr;

  if( _.numberIs( result ) )
  result = result + '';
  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.strIs( result ), 'Expects string got', _.strType( result ) );

  let r = this.strDirectivesFor( style );

  result = r.pre + result + r.post;

  return result;
}

//

let strFormatEach = _.routineVectorize_functor( _strFormat );
let strFormat = strFormatEach;

// //
//
// function _strEscape( srcStr )
// {
//   let result = srcStr;
//   if( _.numberIs( result ) )
//   result = result + '';
//   _.assert( arguments.length === 1 || arguments.length === 2 );
//   _.assert( _.strIs( result ), 'Expects string got', _.strType( result ) );
//   return '#inputRaw:1#' + srcStr + '#inputRaw:0#'
// }
//
// let strEscape = _.routineVectorize_functor( _strEscape );
//
// //
//
// function _strUnescape( srcStr )
// {
//   let result = srcStr;
//   if( _.numberIs( result ) )
//   result = result + '';
//   _.assert( arguments.length === 1 || arguments.length === 2 );
//   _.assert( _.strIs( result ), 'Expects string got', _.strType( result ) );
//   return '#inputRaw:0#' + srcStr + '#inputRaw:1#'
// }
//
// let strUnescape = _.routineVectorize_functor( _strUnescape );

// //
//
// function strDirectivesFor( style )
// {
//   let result = Object.create( null );
//   result.pre = '';
//   result.post = '';
//
//   let StyleObjectOptions =
//   {
//     fg : null,
//     bg : null,
//   }
//
//   let style = _.arrayAs( style );
//
//   _.assert( arguments.length === 1, 'Expects single argument' );
//   _.assert( _.arrayIs( style ) , 'Expects string or array of strings ( style )' );
//
//   for( let s = 0 ; s < style.length ; s++ )
//   {
//
//     if( _.objectIs( style[ s ] ) )
//     {
//       let obj = style[ s ];
//       _.assertMapHasOnly( obj, StyleObjectOptions );
//       if( obj.fg )
//       result = join( result, _.color._strDirectiveForegroundFor( obj.fg ) );
//       if( obj.bg )
//       result = join( result, _.color._strDirectiveBackgroundFor( obj.bg ) );
//       continue;
//     }
//
//     _.assert( _.strIs( style[ s ] ) , 'Expects string or array of strings { style }' );
//
//     let styleObject = this.strColorStyle( style[ s ] );
//
//     _.assert( !!styleObject, 'Unknown style', _.strQuote( style[ s ] ) );
//
//     if( styleObject.fg )
//     result = join( result, _.color._strDirectiveForegroundFor( styleObject.fg ) );
//
//     if( styleObject.bg )
//     result = join( result, _.color._strDirectiveBackgroundFor( styleObject.bg ) );
//
//   }
//
//   return result;
//
//   /* */
//
//   function join()
//   {
//     for( let a = 1 ; a < arguments.length ; a++ )
//     {
//       arguments[ 0 ].pre = arguments[ a ].pre + arguments[ 0 ].pre;
//       arguments[ 0 ].post = arguments[ 0 ].post + arguments[ a ].post;
//     }
//     return arguments[ 0 ];
//   }
//
// }

//

function strColorStyle( style )
{
  return _.ct.styleObjectFor( style );
  // _.assert( arguments.length === 1, 'Expects single argument' );
  // _.assert( _.strIs( style ), 'Expects string got', _.strType( style ) );
  //
  // let result = this.Style[ style ];
  //
  // return result;
}

//

function strStrip( srcStr )
{
  return _.ct.strip( srcStr );
  // let result = '';
  //
  // _.assert( _.strIs( srcStr ) );
  //
  // let splitted = _.strSplitInlined
  // ({
  //   src : srcStr,
  //   preservingEmpty : 0,
  //   stripping : 0,
  // });
  //
  // for( let i = 0 ; i < splitted.length ; i++ )
  // {
  //   if( _.strIs( splitted[ i ] ) )
  //   result += splitted[ i ];
  // }
  //
  // return result;
}

// --
// let
// --

let ColorMap =
{

  'invisible'       : [ 0.0, 0.0, 0.0, 0.0 ],
  'transparent'     : [ 1.0, 1.0, 1.0, 0.5 ],

  'cyan'            : [ 0.0, 1.0, 1.0 ],
  'magenta'         : [ 1.0, 0.0, 1.0 ],
  'maroon'          : [ 0.5, 0.0, 0.0 ],
  'dark green'      : [ 0.0, 0.5, 0.0 ],
  'navy'            : [ 0.0, 0.0, 0.5 ],
  'olive'           : [ 0.5, 0.5, 0.0 ],
  'teal'            : [ 0.0, 0.5, 0.5 ],
  'bright green'    : [ 0.5, 1.0, 0.0 ],
  'spring green'    : [ 0.0, 1.0, 0.5 ],
  'pink'            : [ 1.0, 0.0, 0.5 ],
  'dark orange'     : [ 1.0, 0.5, 0.0 ],
  'azure'           : [ 0.0, 0.5, 1.0 ],
  'dark blue'       : [ 0.0, 0.0, 0.63 ],
  'brown'           : [ 0.65, 0.16, 0.16 ],

}

//

let ColorMapGreyscale =
{

  'white'           : [ 1.0, 1.0, 1.0 ],
  'smoke'           : [ 0.9, 0.9, 0.9 ],
  'silver'          : [ 0.75, 0.75, 0.75 ],
  'gray'            : [ 0.5, 0.5, 0.5 ],
  'dim'             : [ 0.35, 0.35, 0.35 ],
  'black'           : [ 0.0, 0.0, 0.0 ],

}

//

let ColorMapDistinguishable =
{

  'yellow'          : [ 1.0, 1.0, 0.0 ],
  'purple'          : [ 0.5, 0.0, 0.5 ],
  'orange'          : [ 1.0, 0.65, 0.0 ],
  'bright blue'     : [ 0.68, 0.85, 0.9 ],
  'red'             : [ 1.0, 0.0, 0.0 ],
  'buff'            : [ 0.94, 0.86, 0.51 ],
  'gray'            : [ 0.5, 0.5, 0.5 ],
  'green'           : [ 0.0, 1.0, 0.0 ],
  'purplish pink'   : [ 0.96, 0.46, 0.56 ],
  'blue'            : [ 0.0, 0.0, 1.0 ],
  'yellowish pink'  : [ 1.0, 0.48, 0.36 ],
  'violet'          : [ 0.5, 0.0, 1.0 ],
  'orange yellow'   : [ 1.0, 0.56, 0.0 ],
  'purplish red'    : [ 0.7, 0.16, 0.32 ],
  'greenish yellow' : [ 0.96, 0.78, 0.0 ],
  'reddish brown'   : [ 0.5, 0.1, 0.05 ],
  'yellow green'    : [ 0.57, 0.6, 0.0 ],
  'yellowish brown' : [ 0.34, 0.2, 0.08 ],
  'reddish orange'  : [ 0.95, 0.23, 0.07 ],
  'olive green'     : [ 0.14, 0.17, 0.09 ],

}

//

let ColorMapShell =
{
  'white'           : [ 1.0, 1.0, 1.0 ],
  'black'           : [ 0.0, 0.0, 0.0 ],
  'green'           : [ 0.0, 1.0, 0.0 ],
  'red'             : [ 1.0, 0.0, 0.0 ],
  'yellow'          : [ 1.0, 1.0, 0.0 ],
  'blue'            : [ 0.0, 0.0, 1.0 ],
  'cyan'            : [ 0.0, 1.0, 1.0 ],
  'magenta'         : [ 1.0, 0.0, 1.0 ],

  'bright black'    : [ 0.5, 0.5, 0.5 ],

  'dark yellow'     : [ 0.5, 0.5, 0.0 ],
  'dark red'        : [ 0.5, 0.0, 0.0 ],
  'dark magenta'    : [ 0.5, 0.0, 0.5 ],
  'dark blue'       : [ 0.0, 0.0, 0.5 ],
  'dark cyan'       : [ 0.0, 0.5, 0.5 ],
  'dark green'      : [ 0.0, 0.5, 0.0 ],
  'dark white'      : [ 0.9, 0.9, 0.9 ],

  'bright white'    : [ 1.0, 1.0, 1.0 ], /* white */
  'bright green'    : [ 0.0, 1.0, 0.0 ], /* green */
  'bright red'      : [ 1.0, 0.0, 0.0 ], /* red */
  'bright yellow'   : [ 1.0, 1.0, 0.0 ], /* yellow */
  'bright blue'     : [ 0.0, 0.0, 1.0 ], /* blue */
  'bright cyan'     : [ 0.0, 1.0, 1.0 ], /* cyan */
  'bright magenta'  : [ 1.0, 0.0, 1.0 ], /* magenta */

  'dark black'      : [ 0.0, 0.0, 0.0 ], /* black */

  'silver'          : [ 0.9, 0.9, 0.9 ] /* dark white */
}
//
// let Style =
// {
//
//   'positive' : { fg : 'green' },
//   'negative' : { fg : 'red' },
//
//   'path' : { fg : 'dark cyan' },
//   'code' : { fg : 'dark green' },
//   'entity' : { fg : 'bright blue' }, /* qqq : why cant i specify [ 0,0,0 ] ? */
//
//   'topic.up' : { fg : 'white', bg : 'dark blue' },
//   'topic.down' : { fg : 'dark black', bg : 'dark blue' },
//
//   'head' : { fg : 'dark black', bg : 'white' },
//   'tail' : { fg : 'white', bg : 'dark black' },
//
//   'highlighted' : { fg : 'white', bg : 'dark black' },
//   'selected' : { fg : 'dark yellow', bg : 'dark blue' },
//   'neutral' : { fg : 'smoke', bg : 'dim' },
//
//   // 'pipe.neutral' : { fg : 'dark black', bg : 'dark yellow' },
//   // 'pipe.negative' : { fg : 'dark red', bg : 'dark yellow' },
//
//   'pipe.neutral' : { fg : 'dark magenta' },
//   'pipe.negative' : { fg : 'dark red' },
//
//   'exclusiveOutput.neutral' : { fg : 'dark black', bg : 'dark yellow' },
//   'exclusiveOutput.negative' : { fg : 'dark red', bg : 'dark yellow' },
//
//   'info.neutral' : { fg : 'white', bg : 'magenta' },
//   'info.negative' : { fg : 'dark red', bg : 'magenta' },
//
// }

// --
// declare
// --

let Self =
{

  //

  rgbFromName,
  _rgbFromName,

  rgbByBitmask,
  _rgbByBitmask,

  _rgbaFromNotName,

  rgbaFrom,
  rgbFrom,

  rgbaFromTry,
  rgbFromTry,

  _colorDistance,

  _colorNameNearest,
  colorNameNearest,

  colorNearestCustom,
  colorNearest,

  colorToHex,
  hexToColor,

  colorToRgbHtml,
  colorToRgbaHtml,

  mulSaturation,
  brighter,
  paler,

  // int

  colorWidthForExponential,
  rgbWithInt,
  _rgbWithInt,

  // hsl

  hslToRgb,
  rgbToHsl,

  // random

  randomHsl,
  randomRgb : randomRgbWithSl,
  randomRgbWithSl,

  // etc

  gammaToLinear,
  linearToGamma,

  // str

  // _strDirectiveBackgroundFor,
  // strFormatBackground,
  // strBg : strFormatBackground,
  strBg : _.ct.bg,

  // _strDirectiveForegroundFor,
  // strFormatForeground,
  // strFg : strFormatForeground,
  strFg : _.ct.fg,

  strFormat : _.ct.format,
  strFormatEach : _.ct.format,

  // strFormat,
  // strFormatEach,

  strEscape : _.ct.escape,
  strUnescape : _.ct.unescape,
  // strDirectivesFor,
  strColorStyle,

  strStrip,

  // let

  ColorMap,
  ColorMapGreyscale,
  ColorMapDistinguishable,
  ColorMapShell,
  // Style,

}

if( !_.color )
{
  _.color = Self;
}
else
{

  _.mapSupplement( _.color, Self );
  _.mapSupplement( _.color.ColorMap, ColorMap );
  _.mapSupplement( _.color.ColorMapGreyscale, ColorMapGreyscale );
  _.mapSupplement( _.color.ColorMapDistinguishable, ColorMapDistinguishable );
  _.mapSupplement( _.color.ColorMapShell, ColorMapShell );
  // _.mapExtend( _.color.Style, Style );

}

_.mapSupplement( _.color.ColorMap, ColorMapGreyscale );
_.mapSupplement( _.color.ColorMap, ColorMapDistinguishable );
_.mapSupplement( _.color.ColorMap, ColorMapShell );

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
