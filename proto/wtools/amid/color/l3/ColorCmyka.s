(function _ColorCmyka_s_()
{

'use strict';

/**
 * Collection of cross-platform routines to convert from cmyka ( a - alpha channel ) into rgba.
 * @module Tools/mid/Color
*/

/**
 * @summary Collection of cross-platform routines to operate colors conveniently.
 * @namespace wTools.color.cmyka
 * @module Tools/mid/Color
*/

if( typeof module !== 'undefined' )
{
  require( '../../../../wtools/Tools.s' );
  require( './Color.s' );
}

let _ = _global_.wTools;
let Self = _.color.cmyka = _.color.cmyka || Object.create( null );

// --
// implement
// --

function _strToRgba( dst, src )
{
  /*
    cmyk(C, M, Y, K)
  */

  _.assert( arguments.length === 2, 'Expects 2 arguments' );
  _.assert( _.strIs( src ) );
  _.assert( dst === null || _.vectorIs( dst ) );

  let cmykColors = _.color.cmyka._formatStringParse( src );
  _.assert( cmykColors.length === 5, `{-src-} string must contain exactly 5 numbers, but got ${cmykColors.length}` );

  if( !_.color.cmyka._validate( cmykColors ) )
  return null;

  return _.color.cmyka._longToRgba( dst, cmykColors );

}

//

function _longToRgba( dst, src )
{

  _.assert( src.length === 5, `{-src-} length must be 5, but got : ${src.length}` );

  let r, g, b, a;
  /* qqq : bad!
  assert
  alpha channel

  aaa : Added
  */

  if( dst === null || _.longIs( dst ) )
  {
    dst = dst || new Array( 4 );

    _.assert( dst.length === 4, `{-dst-} container length must be 4, but got : ${dst.length}` );

    convert( src );

    /*
      TypedArray:

      For non-basic colors with r, g, b values range ( 0, 1 )
      only instances of those constructors can be used
      Float32Array,
      Float64Array,
    */

    dst[ 0 ] = r;
    dst[ 1 ] = g;
    dst[ 2 ] = b;
    dst[ 3 ] = a;

  }
  else if( _.vadIs( dst ) )
  {
    /* optional dependency */

    _.assert( dst.length === 4, `{-dst-} container length must be 4, but got : ${dst.length}` );

    convert( src );

    dst.eSet( 0, r );
    dst.eSet( 1, g );
    dst.eSet( 2, b );
    dst.eSet( 3, a );

  }
  else _.assert( 0, '{-dts-} container must be of type Vector' );

  return dst;

  /* - */

  function convert( src )
  {
    r = ( 1 - src[ 0 ] / 100 ) * ( 1 - src[ 3 ] / 100 );
    g = ( 1 - src[ 1 ] / 100 ) * ( 1 - src[ 3 ] / 100 );
    b = ( 1 - src[ 2 ] / 100 ) * ( 1 - src[ 3 ] / 100 );
    a = src[ 4 ] / 100;
  }

}

//

function _validate ( src )
{
  if
  (
    !_.cinterval.has( [ 0, 100 ], src[ 0 ] )
    || !_.cinterval.has( [ 0, 100 ], src[ 1 ] )
    || !_.cinterval.has( [ 0, 100 ], src[ 2 ] )
    || !_.cinterval.has( [ 0, 100 ], src[ 3 ] )
    || !_.cinterval.has( [ 0, 100 ], src[ 4 ] )
  )
  return false;

  return true;
}

//

function _formatStringParse( src )
{
  /* qqq : not safe! does not assert string consists of numbers | aaa : Fixed */
  _.assert( /^cmyka\(\d{1,3}%,\d{1,3}%,\d{1,3}%,\d{1,3}%,\d{1,3}%\)$/g.test( src ), 'Wrong source string pattern' );
  return src.match( /\d+(\.\d+)?/g ).map( ( el ) => +el );
}


// --
// declare
// --

let Extension =
{

  // to rgb/a

  _strToRgba,
  _longToRgba,
  _validate,
  _formatStringParse

}

_.mapSupplement( _.color.cmyka, Extension );

// --
// export
// --

if( typeof module !== 'undefined' )
module[ 'exports' ] = _;

})();
