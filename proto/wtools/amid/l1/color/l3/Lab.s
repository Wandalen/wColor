(function _ColorLab_s_()
{

'use strict';

/**
 * Collection of cross-platform routines to convert from lab into rgb.
 * @module Tools/mid/Color
*/

/**
 * @summary Collection of cross-platform routines to operate colors conveniently.
 * @namespace wTools.color.lab
 * @module Tools/mid/Color
*/

let _ = _global_.wTools;
let Self = _.color.lab = _.color.lab || Object.create( null );

// --
// implement
// --

function _strToRgb( dst, src )
{
  /*
    lab(H, S, L)
  */

  _.assert( arguments.length === 2, 'Expects 2 arguments' );
  _.assert( _.strIs( src ) );
  _.assert( dst === null || _.vectorIs( dst ) );

  let labColors = _.color.lab._formatStringParse( src );

  _.assert
  (
    labColors.length === 3 || labColors.length === 4,
    `{-src-} string must contain exactly 3 or 4 numbers, but got ${labColors.length}`
  );
  _.assert
  (
    labColors[ 3 ] === undefined || labColors[ 3 ] === 100,
    `alpha channel must be 100, but got ${labColors[ 3 ]}`
  );

  if( !_.color.lab._validate( labColors ) )
  return null;

  /* normalize ranges */
  // labColors[ 0 ] = labColors[ 0 ] / 360;
  // labColors[ 1 ] = labColors[ 1 ] / 100;
  // labColors[ 2 ] = labColors[ 2 ] / 100;
  if( labColors[ 3 ] )
  labColors[ 3 ] = labColors[ 3 ] / 100;

  return _.color.lab._longToRgb( dst, labColors );

}

//

function _longToRgb( dst, src )
{
  _.assert( src.length === 3 || src.length === 4, `{-src-} length must be 3 or 4, but got : ${src.length}` );
  _.assert( src[ 3 ] === undefined || src[ 3 ] === 1, `alpha channel must be 1, but got : ${src[ 3 ]}` );

  // if( !_.color._validateNormalized( src ) )
  // return null;

  let r, g, b;

  if( dst === null || _.longIs( dst ) )
  {
    dst = dst || new Array( 3 );
    _.assert( dst.length === 3, `{-dst-} container length must be 3, but got : ${dst.length}` );

    convert( src );

    /*
      TypedArray:

      For non-basic colors with r, g, b values in range ( 0, 1 )
      only instances of those constructors can be used
      Float32Array,
      Float64Array,
    */

    dst[ 0 ] = r;
    dst[ 1 ] = g;
    dst[ 2 ] = b;

  }
  else if( _.vadIs( dst ) )
  {
    /* optional dependency */

    _.assert( dst.length === 3, `{-dst-} container length must be 3, but got : ${dst.length}` );

    convert( src );

    dst.eSet( 0, r );
    dst.eSet( 1, g );
    dst.eSet( 2, b );
  }
  else _.assert( 0, '{-dts-} container must be of type Vector' );

  return dst;

  /* - */

  function convert( src )
  {
    let xyz = _.color.lab._labToXyz( src );

    [ r, g, b ] = _.color.xyz._longToRgb( null, xyz );
  }


}

//

function _validate ( src )
{
  if
  (
    !_.cinterval.has( [ 0, 100 ], src[ 0 ] )
    || !_.cinterval.has( [ -128, 127 ], src[ 1 ] )
    || !_.cinterval.has( [ -128, 127 ], src[ 2 ] )
  )
  return false;

  return true;
}

//

function _labToXyz( lab )
{
  /*
    CIE-L*ab ( not Hunter Lab )
    l : [ 0, 100 ]
    a : [ -128, 127 ]
    b : [ -128, 127 ]
  */

  let y = ( lab[ 0 ] + 16 ) / 116;
  let x = lab[ 1 ] / 500 + y;
  let z = y - lab[ 2 ] / 200;

  [ x, y, z ] = [ x, y, z ].map( ( v ) =>
  {
    return v ** 3 > 0.008856 ? v ** 3 : (v - 16 / 116) / 7.787;
  });

  const D65 = [ 95.047, 100, 108.883 ];
  x = ( x * D65[ 0 ] ) / 100;
  y = ( y * D65[ 1 ] ) / 100;
  z = ( z * D65[ 2 ] ) / 100;

  return [ x, y, z ];

}

//

function _formatStringParse( src )
{
  _.assert( /^lab\(-?\d{1,3}.?\d*?, ?-?\d{1,3}.?\d*?, ?-?\d{1,3}.?\d*?(, ?\d{1,3}%?)?\)$/g.test( src ), 'Wrong source string pattern' );
  return src.match( /-?\d+(\.\d+)?/g ).map( ( el ) => +el );
}

// --
// declare
// --

let Extension =
{

  // to rgb/a

  _strToRgb,
  _longToRgb,
  _validate,

  _labToXyz,

  _formatStringParse

}

_.mapSupplement( _.color.lab, Extension );

// --
// export
// --

if( typeof module !== 'undefined' )
module[ 'exports' ] = _;

})();
