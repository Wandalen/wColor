(function _ColorHsla_s_()
{

'use strict';

/**
 * Collection of cross-platform routines to convert from hsla into rgb.
 * @module Tools/mid/Color
*/

/**
 * @summary Collection of cross-platform routines to operate colors conveniently.
 * @namespace wTools.color.hsla
 * @module Tools/mid/Color
*/

let _ = _global_.wTools;
let Self = _.color.hsla = _.color.hsla || Object.create( null );

// --
// implement
// --

function _strToRgba( dst, src )
{
  /*
    hsla(H, S, L, A)
  */

  _.assert( arguments.length === 2, 'Expects 2 arguments' );
  _.assert( _.strIs( src ) );
  _.assert( dst === null || _.vectorIs( dst ) );

  let hslaColors = _.color.hsla._formatStringParse( src );

  _.assert
  (
    hslaColors.length === 3 || hslaColors.length === 4,
    `{-src-} string must contain exactly 3 or 4 numbers, but got ${hslaColors.length}`
  );

  return _.color.hsla._longToRgba( dst, hslaColors );

}

//

function _longToRgba( dst, src )
{
  _.assert( src.length === 3 || src.length === 4, `{-src-} length must be 3 or 4, but got : ${src.length}` );

  if( !_.color.hwba._validate( src ) )
  return null;

  let r, g, b;
  let a = 1;

  if( dst === null || _.longIs( dst ) )
  {
    dst = dst || new Array( 4 );
    _.assert( dst.length === 4, `{-dst-} container length must be 4, but got : ${dst.length}` );

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
    [ r, g, b ] = _.color.hslToRgb( src );
    let alpha = src[ 3 ];
    if( alpha !== undefined )
    a = alpha / 100;
  }


}

//

function _validate ( src )
{
  if
  (
    !_.cinterval.has( [ 0, 360 ], src[ 0 ] )
    || !_.cinterval.has( [ 0, 100 ], src[ 1 ] )
    || !_.cinterval.has( [ 0, 100 ], src[ 2 ] )
    || src[ 3 ] !== undefined && !_.cinterval.has( [ 0, 100 ], src[ 3 ] )
  )
  return false;

  return true;
}

//

function _formatStringParse( src )
{
  _.assert( /^hsla\(\d{1,3}, ?\d{1,3}%, ?\d{1,3}%(, ?\d{1,3}%)?\)$/g.test( src ), 'Wrong source string pattern' );
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

_.mapSupplement( _.color.hsla, Extension );

// --
// export
// --

if( typeof module !== 'undefined' )
module[ 'exports' ] = _;

})();
