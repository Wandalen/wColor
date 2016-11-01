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

  test.description = 'colorFrom bitmask';
  var color = 0xff0000;
  var got = _.colorFrom( color );
  var expected = [ 1,0,0 ];
  test.identical( got,expected );

  test.description = 'colorFrom name';
  var color = 'red';
  var got = _.colorFrom( color );
  var expected = [ 1,0,0 ];
  test.identical( got,expected );

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
