(function _ColorCmyk_s_()
{

'use strict';

/**
 * Collection of cross-platform routines to convert from cmyk into rgb.
 * @module Tools/mid/Color
*/

/**
 * @summary Collection of cross-platform routines to operate colors conveniently.
 * @namespace wTools.color.cmyk
 * @module Tools/mid/Color
*/

if( typeof module !== 'undefined' )
{
  require( '../../../../wtools/Tools.s' );
  require( './Color.s' );
}

let _ = _global_.wTools;
let Self = _.color.cmyk = _.color.cmyk || Object.create( null );

// --
// implement
// --


function _cmykStrToRgb( dst, src )
{
  /*
    cmyk(C, M, Y, K)
  */

  _.assert( arguments.length === 2, 'Expects 2 arguments' );
  _.assert( _.strIs( src ) );
  _.assert( dst === null || _.vectorIs( dst ) );

  let cmykColors = _.color._formatStringParse( src );
  _.assert( cmykColors.length === 4, `{-src-} string must contain exactly 4 numbers, but got ${cmykColors.length}` );

  if( !_.color.cmyk._сmykValidate( cmykColors ) )
  return null;

  return _.color.cmyk._cmykLongToRgb( dst, cmykColors );

}

//

function _cmykLongToRgb( dst, src )
{
  let r, g, b;

  if( dst === null || _.longIs( dst ) )
  {
    dst = dst || new Array( 3 );

    _.assert( dst.length === 3, `{-dst-} container length must be 3, but got : ${dst.length}` );

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
    r = ( 1 - src[ 0 ] / 100 ) * ( 1 - src[ 3 ] / 100 );
    g = ( 1 - src[ 1 ] / 100 ) * ( 1 - src[ 3 ] / 100 );
    b = ( 1 - src[ 2 ] / 100 ) * ( 1 - src[ 3 ] / 100 );
  }


}

//

function _сmykValidate ( src )
{
  if
  (
    !_.cinterval.has( [ 0, 100 ], src[ 0 ] )
    || !_.cinterval.has( [ 0, 100 ], src[ 1 ] )
    || !_.cinterval.has( [ 0, 100 ], src[ 2 ] )
    || !_.cinterval.has( [ 0, 100 ], src[ 3 ] )
  )
  return false;

  return true;
}

// --
// declare
// --

let Extension =
{

  // to rgb/a

  _cmykStrToRgb,
  _cmykLongToRgb,
  _сmykValidate,

}

_.mapSupplement( _.color.cmyk, Extension );

// --
// export
// --

if( typeof module !== 'undefined' )
module[ 'exports' ] = _;

})();
