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

  test.description = 'colorNameNearest bitmask';
  var color = 0xff0000;
  var got = _.color.rgbaFrom( color );
  var expected = [ 1,0,0,1 ];
  test.identical( got,expected );

  test.description = 'colorNameNearest name';
  var color = 'red';
  var got = _.color.rgbaFrom( color );
  var expected = [ 1,0,0,1 ];
  test.identical( got,expected );

}

//

var colorNameNearest = function( test )
{
  test.description = 'white1';
  var color = [ 1, 1, 1 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'white';
  test.identical( got,expected );

  test.description = 'white2';
  var color = 'ffffff';
  var got = _.color.colorNameNearest( color );
  var expected = 'white';
  test.identical( got,expected );

  test.description = 'rgba a1 ';
  var color =  [ 1, 1, 1, 0.3 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'transparent';
  test.identical( got,expected );

  test.description = 'rgba a2';
  var color =  [ 1, 1, 1, 0.9 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'white';
  test.identical( got,expected );

  test.description = 'rgb a1';
  var color =  [ 0.5, 0, 0.1 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'maroon';
  test.identical( got,expected );

  test.description = 'rgb a2';
  var color =  [ 255, 0, 1 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'magenta';
  test.identical( got,expected );

  test.description = 'rgb a3';
  var color =  [ 0.2, 0, 0.3 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'olive green';
  test.identical( got,expected );

  test.description = 'rgb a4';
  var color =  [ 0.3, 0, 0.3 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'purple';
  test.identical( got,expected );

  test.description = 'hex a1';
  var color = 'aaaaaa';
  var got = _.color.colorNameNearest( color );
  var expected = 'silver';
  test.identical( got,expected );

  test.description = 'empty string';
  var color = '';
  var got = _.color.colorNameNearest( color );
  var expected = undefined;
  test.identical( got,expected );

  test.description = 'empty array';
  var color = [];
  var got = _.color.colorNameNearest( color );
  var expected = undefined;
  test.identical( got,expected );

  test.description = 'no args';
  test.shouldThrowError( function()
  {
    _.color.colorNameNearest();
  });

  test.description = 'no args';
  test.shouldThrowError( function()
  {
    _.color.colorNameNearest();
  });

}

//

var colorToHex = function( test )
{
  var cases =
  [
    {
      description : "rgb as array#1",
      arg : [ 0, 0, 0 ],
      expected : "#000000"
    },
    {
      description : "rgb as array#2",
      arg : [ 1, 0, 1 ],
      expected : "#ff00ff"
    },
    {
      description : "rgb as array#3",
      arg : [ 0.5, 0, 1 ],
      expected : "#7f00ff"
    },
    {
      description : "rgb as num#1",
      arg : 0xFF00FF,
      expected : "#ff00ff"
    },
    {
      description : "rgb as num#2",
      arg : 255,
      expected : "#0000ff"
    },
    {
      description : "rgb as num#3",
      arg : 65535,
      expected : "#00ffff"
    },
    {
      description : "rgb as obj#1",
      arg : { r : 0, g : 0, b : 1.0 },
      expected : "#0000ff"
    },
    {
      description : "rgb as obj#2",
      arg : { r : 0, g : 0, b : 0.5 },
      expected : "#00007f"
    },
    {
      description : "rgb as str#1",
      arg : '',
      expected : undefined
    },
    {
      description : "rgb as str#2",
      arg : '#ffffff',
      expected : '#ffffff'
    },
    {
      description : "rgb as str#3",
      arg : 'ffffff',
      expected : '#ffffff'
    },

  ]

  cases.forEach( function( element )
  {
    test.description = element.description;
    var got = _.color.colorToHex( element.arg );
    test.identical( got, element.expected );
  });
}

//

var hexToColor = function ( test )
{
  var cases =
  [
    {
      description : "#1",
      arg : '#ff0000',
      expected : [ 1, 0, 0 ]
    },
    {
      description : "#2",
      arg : '#80007f',
      expected : [ 0.5, 0, 0.49 ]
    },
    {
      description : "#3",
      arg : '252525',
      expected : [ 0.14, 0.14, 0.14 ]
    },
    {
      description : "shorthand test#1",
      arg : 'fff',
      expected : [ 1, 1, 1 ]
    },
    {
      description : "shorthand test#2",
      arg : '#f00',
      expected : [ 1, 0, 0 ]
    },
    {
      description : "shorthand test#3",
      arg : '555',
      expected : [ 0.3, 0.3, 0.3 ]
    },
    {
      description : "incorrect shorthand test",
      arg : '#0fff',
      expected : null
    },
    {
      description : "incorrect data#1",
      arg : '#255255255',
      expected : null
    },
    {
      description : "incorrect data#2",
      arg : '#-5-5-5',
      expected : null
    }
  ]

  cases.forEach( function( element )
  {
    test.description = element.description;
    var got = _.color.hexToColor( element.arg );
    test.equivalent( got, element.expected, 0.05 );
  });
}

//

var Proto =
{

  name : 'Logger',

  tests :
  {

    simplest : simplest,
    colorNameNearest : colorNameNearest,
    colorToHex : colorToHex,
    hexToColor : hexToColor,

  },

  verbose : 1,

}

//

_.mapExtend( Self,Proto );

if( typeof module !== 'undefined' && !module.parent )
_.Testing.test( Self );

} )( );
