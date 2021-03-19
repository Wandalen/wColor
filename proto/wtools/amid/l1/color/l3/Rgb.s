(function _ColorRgb_s_()
{

'use strict';

/**
 * Collection of cross-platform routines to convert from hex into rgb.
 * @module Tools/mid/Color
*/

/**
 * @summary Collection of cross-platform routines to operate colors conveniently.
 * @namespace wTools.color.rgb
 * @module Tools/mid/Color
*/

let _ = _global_.wTools;
let Self = _.color.rgb = _.color.rgb || Object.create( null );

// --
// implement
// --

function fromHexStr( hex )
{
  let result = _.color.rgba.fromHexStr( hex );

  if( result === null )
  return null;

  _.assert( result[ 3 ] === undefined || result[ 3 ] === 1 );

  if( result[ 3 ] )
  result.pop();

  return result;
}

// --
// declare
// --

let Extension =
{

  // to rgb/a

  fromHexStr

}

_.mapSupplement( _.color.rgb, Extension );

// --
// export
// --

if( typeof module !== 'undefined' )
module[ 'exports' ] = _;

})();
