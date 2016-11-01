( function _Color_test_s_( ) {

'use strict';

/*

to run this test
from the project directory run

npm install
node ./staging/amid/z.test/Color.test.s

*/

if( typeof module !== 'undefined' )
{

  require( 'wTools' );
  require( '../color/Color.s' );

  if( require( 'fs' ).existsSync( __dirname + '/../../amid/diagnostic/Testing.debug.s' ) )
  require( '../../amid/diagnostic/Testing.debug.s' );
  else
  require( 'wTesting' );

}

var _ = wTools;
var Self = {};

//

var simplest = function( test )
{

  test.description = 'simple1';

  test.identical( 1,1 );

}

//

var Proto =
{

  name : 'Logger',

  tests :
  {

    simplest : simplest,

  },

  verbose : 1,

}

//

_.mapExtend( Self,Proto );

if( typeof module !== 'undefined' && !module.parent )
_.Testing.test( Self );

} )( );
