(function _ColorRgba_s_()
{

'use strict';

/**
 * Collection of cross-platform routines to convert from hex into rgba.
 * @module Tools/mid/Color
*/

/**
 * @summary Collection of cross-platform routines to operate colors conveniently.
 * @namespace wTools.color.rgba
 * @module Tools/mid/Color
*/

let _ = _global_.wTools;
let Self = _.color.rgba = _.color.rgba || Object.create( null );

// --
// implement
// --

function fromHexStr( hex )
{
  let result;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( hex ) );

  result = /^#?([a-f\d])([a-f\d])([a-f\d])$/i.exec( hex );
  if( result )
  {
    result =
    [
      parseInt( result[ 1 ], 16 ) / 15,
      parseInt( result[ 2 ], 16 ) / 15,
      parseInt( result[ 3 ], 16 ) / 15,
    ]
    return result;
  }

  result = /^#?([a-f\d])([a-f\d])([a-f\d])([a-f\d])$/i.exec( hex );
  if( result )
  {
    result =
    [
      parseInt( result[ 1 ], 16 ) / 15,
      parseInt( result[ 2 ], 16 ) / 15,
      parseInt( result[ 3 ], 16 ) / 15,
      parseInt( result[ 4 ], 16 ) / 15,
    ]
    return result;
  }

  result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec( hex );
  if( result )
  {
    result =
    [
      parseInt( result[ 1 ], 16 ) / 255,
      parseInt( result[ 2 ], 16 ) / 255,
      parseInt( result[ 3 ], 16 ) / 255,
    ]
    return result;
  }

  result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec( hex );
  if( result )
  {
    result =
    [
      parseInt( result[ 1 ], 16 ) / 255,
      parseInt( result[ 2 ], 16 ) / 255,
      parseInt( result[ 3 ], 16 ) / 255,
      parseInt( result[ 4 ], 16 ) / 255,
    ]
    return result;
  }

  return null;
}

// --
// declare
// --

let Extension =
{

  // to rgba/a

  fromHexStr

}

_.mapSupplement( _.color.rgba, Extension );

// --
// export
// --

if( typeof module !== 'undefined' )
module[ 'exports' ] = _;

})();
