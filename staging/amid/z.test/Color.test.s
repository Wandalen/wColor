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

var colorToRgbHtml = function( test )
{
  var cases =
  [
    {
      description : "color as string #1",
      arg : '#ff0000',
      expected : '#ff0000'
    },
    {
      description : "color as obj #1",
      arg : { r : 0, g : 1, b : 0 },
      expected : 'rgb( 0, 255, 0 )'
    },
    {
      description : "color as obj #3",
      arg : { r : 255, g : 0, b : 0 },
      expected : ''
    },
    {
      description : "color as array #1",
      arg : [ 0, 1, 0 ],
      expected : 'rgb( 0, 255, 0 )'
    }
  ]

  cases.forEach( function( element )
  {
    test.description = element.description;
    var got = _.color.colorToRgbHtml( element.arg );
    test.identical( got, element.expected );
  });

  if( Config.debug )
  {
    test.shouldThrowError(function ()
    {
      test.description = 'incorrect type';
      _.color.colorToRgbHtml( 1 );
    });
    test.shouldThrowError(function ()
    {
      test.description = 'no arguments';
      _.color.colorToRgbHtml( );
    });
  }
}

//

var colorToRgbaHtml = function ( test )
{
  var cases =
  [
    {
      description : "color as string #1",
      arg : '#ff0000',
      expected : '#ff0000'
    },
    {
      description : "color as obj #1",
      arg : { r : 0, g : 1, b : 0, a : 1 },
      expected : 'rgba( 0, 255, 0, 1 )'
    },
    {
      description : "color as obj, incorrect value #3",
      arg : { r : 255, g : 0, b : 0 },
      expected : ''
    },
    {
      description : "color as array #1",
      arg : [ 0, 1, 0, 0.5],
      expected : 'rgba( 0, 255, 0, 0.5 )'
    },
    {
      description : "color as number #1",
      arg : 0x00FFFF,
      expected : 'rgba( 0, 255, 255, 1 )'
    }
  ]

  cases.forEach( function( element )
  {
    test.description = element.description;
    var got = _.color.colorToRgbaHtml( element.arg );
    test.identical( got, element.expected );
  });

  if( Config.debug )
  {
    test.shouldThrowError(function ()
    {
      test.description = 'incorrect type';
      _.color.colorToRgbaHtml( function () {} );
    });
    test.shouldThrowError(function ()
    {
      test.description = 'no arguments';
      _.color.colorToRgbaHtml( );
    });
  };
}

//

var rgbByBitmask = function ( test )
{
  var cases =
  [
    {
      description : "#1",
      arg : 0xff00ff,
      expected : [ 1, 0, 1 ]
    },
    {
      description : "#2",
      arg : 0x8000ff,
      expected : [ 0.5, 0, 1 ]
    },
    {
      description : "#3",
      arg : 0xff,
      expected : [ 0, 0, 1 ]
    },
    {
      description : "#4",
      arg : 255,
      expected : [ 0, 0, 1 ]
    },
    {
      description : "#5",
      arg : -1,
      expected : [ 1, 1, 1 ]
    },

  ]

  cases.forEach( function( element )
  {
    test.description = element.description;
    var got = _.color.rgbByBitmask( element.arg );
    test.equivalent( got, element.expected, .05 );
  });

  if( Config.debug )
  {
    test.shouldThrowError(function ()
    {
      test.description = 'incorrect type';
      _.color.rgbByBitmask( 'str' );
    });
    test.shouldThrowError(function ()
    {
      test.description = 'no arguments';
      _.color.rgbByBitmask( );
    });
  };
}

//

var rgbaFrom = function( test )
{
  var cases =
  [
    {
      description : "map #1",
      arg : { r : 0 },
      expected : [ 0, 1, 1, 1 ]
    },
    {
      description : "map #2",
      arg : { r : 0, g : 1, b : 1, a : 0 },
      expected : [ 0, 1, 1, 0 ]
    },
    {
      description : "number #1",
      arg : -1,
      expected : [ 1, 1, 1, 1 ]
    },
    {
      description : "number #2",
      arg : 0xFF0080,
      expected : [ 1, 0, 0.5, 1 ]
    },
    {
      description : "array #1",
      arg : [ -1, 0, 1, 1 ],
      expected : [ 1, 0, 1, 1 ]
    },
    {
      description : "array #2",
      arg : [ 0, 0, 0 ],
      expected : [ 0, 0, 0, 1 ]
    },
    {
      description : "str name#1",
      arg : 'white',
      expected : [ 1, 1, 1, 1 ]
    },
    {
      description : "str hex #2",
      arg : '#ffffff',
      expected : [ 1, 1, 1, 1 ]
    }
  ]

  cases.forEach( function( element )
  {
    test.description = element.description;
    var got = _.color.rgbaFrom( element.arg );
    test.equivalent( got, element.expected, .05 );
  });

  if( Config.debug )
  {
    test.shouldThrowError( function()
    {
      _.color.rgbaFrom( 'unknown' )
    })
    test.shouldThrowError( function()
    {
      _.color.rgbaFrom( function(){} )
    })
  };
}

//

var rgbFrom = function( test )
{
  var cases =
  [
    {
      description : "map #1",
      arg : { r : 0 },
      expected : [ 0, 1, 1 ]
    },
    {
      description : "map #2",
      arg : { r : 0, g : 1, b : 1, a : 0 },
      expected : [ 0, 1, 1 ]
    },
    {
      description : "number #1",
      arg : -1,
      expected : [ 1, 1, 1 ]
    },
    {
      description : "number #2",
      arg : 0xFF0080,
      expected : [ 1, 0, 0.5 ]
    },
    {
      description : "array #1",
      arg : [ -1, 0, 1, 1 ],
      expected : [ 1, 0, 1 ]
    },
    {
      description : "array #2",
      arg : [ 0, 0, 0 ],
      expected : [ 0, 0, 0 ]
    },
    {
      description : "str name#1",
      arg : 'white',
      expected : [ 1, 1, 1 ]
    },
    {
      description : "str hex #2",
      arg : '#ffffff',
      expected : [ 1, 1, 1 ]
    }
  ]

  cases.forEach( function( element )
  {
    test.description = element.description;
    var got = _.color.rgbFrom( element.arg );
    test.equivalent( got, element.expected, .05 );
  });

  if( Config.debug )
  {
    test.shouldThrowError( function()
    {
      _.color.rgbFrom( 'unknown' )
    })
    test.shouldThrowError( function()
    {
      _.color.rgbFrom( function(){} )
    })
  };
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
    colorToRgbHtml : colorToRgbHtml,
    colorToRgbaHtml : colorToRgbaHtml,
    rgbByBitmask : rgbByBitmask,
    rgbaFrom : rgbaFrom,
    rgbFrom : rgbFrom,

  },

  verbose : 1,

}

//

_.mapExtend( Self,Proto );

if( typeof module !== 'undefined' && !module.parent )
_.Testing.test( Self );

} )( );
