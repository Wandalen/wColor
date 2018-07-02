( function _Color_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  if( typeof _global_ === 'undefined' || !_global_.wBase )
  {
    let toolsPath = '../../../dwtools/Base.s';
    let toolsExternal = 0;
    try
    {
      require.resolve( toolsPath );
    }
    catch( err )
    {
      toolsExternal = 1;
      require( 'wTools' );
    }
    if( !toolsExternal )
    require( toolsPath );
  }

  require( '../color/Color.s' );

  var _ = wTools;
  _.include( 'wTesting' );

}

var _ = wTools;

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
  test.description = 'black';
  var color = [ 0, 0, 0, 1 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'black';
  test.identical( got,expected );

  test.description = 'close to invisible';
  var color = [ 0, 0, 0, 0 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'invisible';
  test.identical( got,expected );

  test.description = 'dim';
  var color = [ 0.3, 0.3, 0.3 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'dim';
  test.identical( got,expected );

  test.description = 'invisible';
  var color = [ 0.3, 0.3, 0.3, 0 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'invisible';
  test.identical( got,expected );

  test.description = 'close to transparent';
  var color = [ 1, 1, 1, 0 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'transparent';
  test.identical( got,expected );

  test.description = 'white with 0.8 transparency is closer to white';
  var color = [ 1, 1, 1, 0.8 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'white';
  test.identical( got,expected );

  test.description = 'white 0.7 transparency is still closer to transparent';
  var color = [ 1, 1, 1, 0.7 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'transparent';
  test.identical( got,expected );

  test.description = 'close to brown';
  var color = [ 0.6, 0.1, 0.1 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'brown';
  test.identical( got,expected );

  test.description = 'close to dark blue';
  var color = [ 0.1, 0.1, 0.6 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'dark blue';
  test.identical( got,expected );

  test.description = 'close to pink#1';
  var color = [ 0.9, 0.4, 0.6 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'purplish pink';
  test.identical( got,expected );

  test.description = 'close to pink#2';
  var color = [ 0.9, 0.4, 0.4 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'yellowish pink';
  test.identical( got,expected );

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
  var expected = 'white';
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

var hexToColor = function( test )
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
    test./*eps*/accuracy = 1e-1;
    test.equivalent( got, element.expected );
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
      description : "color as obj #2",
      arg : { r : 255, g : 0, b : 0 },
      err : true,
    },
    {
      description : "color as obj #3",
      arg : { r : -1, g : 0, b : 0 },
      err : true,
    },
    {
      description : "color as array #1",
      arg : [ 0, 1, 0 ],
      expected : 'rgb( 0, 255, 0 )'
    },
    {
      description : "color as array #2",
      arg : [ 0, -1, 0 ],
      err : true
    },
    {
      description : "color as array #3",
      arg : [ 0, 255, 0 ],
      err : true
    }
  ]

  cases.forEach( function( element )
  {
    test.description = element.description;
    if( element.err )
    {
      test.shouldThrowErrorSync( function()
      {
        _.color.colorToRgbHtml( element.arg )
      })
    }
    else
    {
      var got = _.color.colorToRgbHtml( element.arg );
      test.identical( got, element.expected );
    }

  });

  if( Config.debug )
  {
    test.shouldThrowError(function()
    {
      test.description = 'incorrect type';
      _.color.colorToRgbHtml( 1 );
    });
    test.shouldThrowError(function()
    {
      test.description = 'no arguments';
      _.color.colorToRgbHtml( );
    });
  }
}

//

var colorToRgbaHtml = function( test )
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
      description : "color as obj, incorrect value #2",
      arg : { r : 255, g : 0, b : 0 },
      err : true,
    },
    {
      description : "color as obj #3",
      arg : { r : -1, g : 0, b : 0 },
      err : true,
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
    },
    {
      description : "color as array #2",
      arg : [ 0, -1, 0 ],
      err : true
    },
    {
      description : "color as array #3",
      arg : [ 0, 255, 0 ],
      err : true
    }
  ]

  cases.forEach( function( element )
  {
    if( element.err )
    {
      test.shouldThrowErrorSync( function()
      {
        _.color.colorToRgbaHtml( element.arg )
      })
    }
    else
    {
      var got = _.color.colorToRgbaHtml( element.arg );
      test.identical( got, element.expected );
    }
  });

  if( Config.debug )
  {
    test.shouldThrowErrorSync(function()
    {
      test.description = 'incorrect type';
      _.color.colorToRgbaHtml( function() {} );
    });
    test.shouldThrowErrorSync(function()
    {
      test.description = 'no arguments';
      _.color.colorToRgbaHtml( );
    });
  };
}

//

var rgbByBitmask = function( test )
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
    test./*eps*/accuracy = 1e-2;
    test.equivalent( got, element.expected );
  });

  if( Config.debug )
  {
    test.shouldThrowErrorSync(function()
    {
      test.description = 'incorrect type';
      _.color.rgbByBitmask( 'str' );
    });
    test.shouldThrowErrorSync(function()
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
      expected : [ -1, 0, 1, 1 ]
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
    },
    {
      description : "rgb component > 1",
      arg : [ 10,10,10 ],
      expected : [ 10, 10, 10, 1 ]
    },
    {
      description : "rgba component > 1",
      arg : [ 10,10,10,10 ],
      expected : [ 10, 10, 10, 10 ]
    },
    {
      description : "all negative, no alpha",
      arg : [ -10, -10, -10 ],
      expected : [ -10, -10, -10, 1 ]
    },
    {
      description : "all negative",
      arg : [ -10, -10, -10, -10 ],
      expected : [ -10, -10, -10, -10 ]
    }
  ]

  cases.forEach( function( element )
  {
    test.description = element.description;
    var got = _.color.rgbaFrom( element.arg );
    test./*eps*/accuracy = 1e-2;
    test.equivalent( got, element.expected );
  });

  if( Config.debug )
  {
    test.shouldThrowErrorSync( function()
    {
      _.color.rgbaFrom( 'unknown' )
    })
    test.shouldThrowErrorSync( function()
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
      expected : [ -1, 0, 1 ]
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
    },
    {
      description : "rgb component > 1",
      arg : [ 10,10,10 ],
      expected : [ 10, 10, 10 ]
    },
    {
      description : "all negative",
      arg : [ -10, -10, -10 ],
      expected : [ -10, -10, -10 ]
    }
  ]

  cases.forEach( function( element )
  {
    test.description = element.description;
    var got = _.color.rgbFrom( element.arg );
    test./*eps*/accuracy = 1e-2;
    test.equivalent( got, element.expected );
  });

  if( Config.debug )
  {
    test.shouldThrowErrorSync( function()
    {
      _.color.rgbFrom( 'unknown' )
    })
    test.shouldThrowErrorSync( function()
    {
      _.color.rgbFrom( function(){} )
    })
  };
}

//

var Self =
{

  name : 'Tools/amid/Color',
  silencing : 1,
  // verbosity : 1,

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

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
_.Tester.test( Self.name );

} )( );
