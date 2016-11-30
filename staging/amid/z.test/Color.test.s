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

var colorNearest = function( test )
{
  test.description = 'white1';
  var color = [ 1, 1, 1 ];
  var got = _.colorNearest( color );
  var expected = 'white';
  test.identical( got,expected );

  test.description = 'white2';
  var color = 'ffffff';
  var got = _.colorNearest( color );
  var expected = 'white';
  test.identical( got,expected );

  test.description = 'rgba a1 ';
  var color =  [ 1, 1, 1, 0.3 ];
  var got = _.colorNearest( color );
  var expected = 'transparent';
  test.identical( got,expected );

  test.description = 'rgba a2';
  var color =  [ 1, 1, 1, 0.9 ];
  var got = _.colorNearest( color );
  var expected = 'white';
  test.identical( got,expected );

  test.description = 'rgb a1';
  var color =  [ 0.5, 0, 0.1 ];
  var got = _.colorNearest( color );
  var expected = 'maroon';
  test.identical( got,expected );

  test.description = 'rgb a2';
  var color =  [ 255, 0, 1 ];
  var got = _.colorNearest( color );
  var expected = 'blue';
  test.identical( got,expected );

  test.description = 'rgb a3';
  var color =  [ 0.2, 0, 0.3 ];
  var got = _.colorNearest( color );
  var expected = 'olive green';
  test.identical( got,expected );

  test.description = 'rgb a4';
  var color =  [ 0.3, 0, 0.3 ];
  var got = _.colorNearest( color );
  var expected = 'purple';
  test.identical( got,expected );

  test.description = 'hex a1';
  var color =  'aaaaaa';
  var got = _.colorNearest( color );
  var expected = 'silver';
  test.identical( got,expected );

  test.description = 'empty string';
  var color =  '';
  var got = _.colorNearest( color );
  var expected =  false;
  test.identical( got,expected );

  test.description = 'empty array';
  var color =  [];
  var got = _.colorNearest( color );
  var expected =  false;
  test.identical( got,expected );

  test.description = 'no args';
  test.shouldThrowError( function()
  {
    _.colorNearest(  );
  })
}

//

var Proto =
{

  name : 'Logger',

  tests :
  {

    simplest : simplest,
    colorNearest : colorNearest

  },

  verbose : 1,

}

//

_.mapExtend( Self,Proto );

if( typeof module !== 'undefined' && !module.parent )
_.Testing.test( Self );

} )( );
