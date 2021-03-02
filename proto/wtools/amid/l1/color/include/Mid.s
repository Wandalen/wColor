( function _Mid_s_( )
{

'use strict';

/* color */

if( typeof module !== 'undefined' )
{
  let _ = require( './Basic.s' );
  require( '../l3/Color.s' );
  require( '../l3/Cmyk.s' );
  require( '../l3/Cmyka.s' );
  require( '../l3/Hwb.s' );
  require( '../l3/Hwba.s' );
  require( '../l3/Hsl.s' );
  require( '../l3/Hsla.s' );
  module[ 'exports' ] = _global_.wTools;
}

} )();
