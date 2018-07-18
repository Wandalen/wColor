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

function colorNameNearest( test )
{

  test.case = 'black';
  var color = [ 0, 0, 0, 1 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'black';
  test.identical( got,expected );

  test.case = 'close to invisible';
  var color = [ 0, 0, 0, 0 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'invisible';
  test.identical( got,expected );

  test.case = 'dim';
  var color = [ 0.3, 0.3, 0.3 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'dim';
  test.identical( got,expected );

  test.case = 'invisible';
  var color = [ 0.3, 0.3, 0.3, 0 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'invisible';
  test.identical( got,expected );

  test.case = 'close to transparent';
  var color = [ 1, 1, 1, 0 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'transparent';
  test.identical( got,expected );

  test.case = 'white with 0.8 transparency is closer to white';
  var color = [ 1, 1, 1, 0.8 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'white';
  test.identical( got,expected );

  test.case = 'white 0.7 transparency is still closer to transparent';
  var color = [ 1, 1, 1, 0.7 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'transparent';
  test.identical( got,expected );

  test.case = 'close to brown';
  var color = [ 0.6, 0.1, 0.1 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'brown';
  test.identical( got,expected );

  test.case = 'close to dark blue';
  var color = [ 0.1, 0.1, 0.6 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'dark blue';
  test.identical( got,expected );

  test.case = 'close to pink#1';
  var color = [ 0.9, 0.4, 0.6 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'purplish pink';
  test.identical( got,expected );

  test.case = 'close to pink#2';
  var color = [ 0.9, 0.4, 0.4 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'yellowish pink';
  test.identical( got,expected );

  test.case = 'white1';
  var color = [ 1, 1, 1 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'white';
  test.identical( got,expected );

  test.case = 'white2';
  var color = 'ffffff';
  var got = _.color.colorNameNearest( color );
  var expected = 'white';
  test.identical( got,expected );

  test.case = 'rgba a1 ';
  var color =  [ 1, 1, 1, 0.3 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'transparent';
  test.identical( got,expected );

  test.case = 'rgba a2';
  var color =  [ 1, 1, 1, 0.9 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'white';
  test.identical( got,expected );

  test.case = 'rgb a1';
  var color =  [ 0.5, 0, 0.1 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'maroon';
  test.identical( got,expected );

  test.case = 'rgb a2';
  var color =  [ 255, 0, 1 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'magenta';
  test.identical( got,expected );

  test.case = 'rgb a3';
  var color =  [ 0.2, 0, 0.3 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'olive green';
  test.identical( got,expected );

  test.case = 'rgb a4';
  var color =  [ 0.3, 0, 0.3 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'purple';
  test.identical( got,expected );

  test.case = 'hex a1';
  var color = 'aaaaaa';
  var got = _.color.colorNameNearest( color );
  var expected = 'silver';
  test.identical( got,expected );

  test.case = 'empty string';
  var color = '';
  var got = _.color.colorNameNearest( color );
  var expected = undefined;
  test.identical( got,expected );

  test.case = 'empty array';
  var color = [];
  var got = _.color.colorNameNearest( color );
  var expected = 'white';
  test.identical( got,expected );

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.color.colorNameNearest();
  });

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.color.colorNameNearest();
  });

}

//

function colorToHex( test )
{
  var cases =
  [
    {
      case : 'rgb as array#1',
      arg : [ 0, 0, 0 ],
      expected : '#000000'
    },
    {
      case : 'rgb as array#2',
      arg : [ 1, 0, 1 ],
      expected : '#ff00ff'
    },
    {
      case : 'rgb as array#3',
      arg : [ 0.5, 0, 1 ],
      expected : '#7f00ff'
    },
    {
      case : 'rgb as num#1',
      arg : 0xFF00FF,
      expected : '#ff00ff'
    },
    {
      case : 'rgb as num#2',
      arg : 255,
      expected : '#0000ff'
    },
    {
      case : 'rgb as num#3',
      arg : 65535,
      expected : '#00ffff'
    },
    {
      case : 'rgb as obj#1',
      arg : { r : 0, g : 0, b : 1.0 },
      expected : '#0000ff'
    },
    {
      case : 'rgb as obj#2',
      arg : { r : 0, g : 0, b : 0.5 },
      expected : '#00007f'
    },
    {
      case : 'rgb as str#1',
      arg : '',
      expected : undefined
    },
    {
      case : 'rgb as str#2',
      arg : '#ffffff',
      expected : '#ffffff'
    },
    {
      case : 'rgb as str#3',
      arg : 'ffffff',
      expected : '#ffffff'
    },

  ]

  cases.forEach( function( element )
  {
    test.case = element.case;
    var got = _.color.colorToHex( element.arg );
    test.identical( got, element.expected );
  });
}

//

function hexToColor( test )
{
  var cases =
  [
    {
      case : '#1',
      arg : '#ff0000',
      expected : [ 1, 0, 0 ]
    },
    {
      case : '#2',
      arg : '#80007f',
      expected : [ 0.5, 0, 0.49 ]
    },
    {
      case : '#3',
      arg : '252525',
      expected : [ 0.14, 0.14, 0.14 ]
    },
    {
      case : 'shorthand test#1',
      arg : 'fff',
      expected : [ 1, 1, 1 ]
    },
    {
      case : 'shorthand test#2',
      arg : '#f00',
      expected : [ 1, 0, 0 ]
    },
    {
      case : 'shorthand test#3',
      arg : '555',
      expected : [ 0.3, 0.3, 0.3 ]
    },
    {
      case : 'incorrect shorthand test',
      arg : '#0fff',
      expected : null
    },
    {
      case : 'incorrect data#1',
      arg : '#255255255',
      expected : null
    },
    {
      case : 'incorrect data#2',
      arg : '#-5-5-5',
      expected : null
    }
  ]

  cases.forEach( function( element )
  {
    test.case = element.case;
    var got = _.color.hexToColor( element.arg );
    test./*eps*/accuracy = 1e-1;
    test.equivalent( got, element.expected );
  });

}

//

function colorToRgbHtml( test )
{
  var cases =
  [
    {
      case : 'color as string #1',
      arg : '#ff0000',
      expected : '#ff0000'
    },
    {
      case : 'color as obj #1',
      arg : { r : 0, g : 1, b : 0 },
      expected : 'rgb( 0, 255, 0 )'
    },
    {
      case : 'color as obj #2',
      arg : { r : 255, g : 0, b : 0 },
      err : true,
    },
    {
      case : 'color as obj #3',
      arg : { r : -1, g : 0, b : 0 },
      err : true,
    },
    {
      case : 'color as array #1',
      arg : [ 0, 1, 0 ],
      expected : 'rgb( 0, 255, 0 )'
    },
    {
      case : 'color as array #2',
      arg : [ 0, -1, 0 ],
      err : true
    },
    {
      case : 'color as array #3',
      arg : [ 0, 255, 0 ],
      err : true
    }
  ]

  cases.forEach( function( element )
  {
    test.case = element.case;
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

  if( !Config.debug )
  return;

  test.shouldThrowError(function()
  {
    test.case = 'incorrect type';
    _.color.colorToRgbHtml( 1 );
  });
  test.shouldThrowError(function()
  {
    test.case = 'no arguments';
    _.color.colorToRgbHtml( );
  });

}

//

function colorToRgbaHtml( test )
{
  var cases =
  [
    {
      case : 'color as string #1',
      arg : '#ff0000',
      expected : '#ff0000'
    },
    {
      case : 'color as obj #1',
      arg : { r : 0, g : 1, b : 0, a : 1 },
      expected : 'rgba( 0, 255, 0, 1 )'
    },
    {
      case : 'color as obj, incorrect value #2',
      arg : { r : 255, g : 0, b : 0 },
      err : true,
    },
    {
      case : 'color as obj #3',
      arg : { r : -1, g : 0, b : 0 },
      err : true,
    },
    {
      case : 'color as array #1',
      arg : [ 0, 1, 0, 0.5],
      expected : 'rgba( 0, 255, 0, 0.5 )'
    },
    {
      case : 'color as number #1',
      arg : 0x00FFFF,
      expected : 'rgba( 0, 255, 255, 1 )'
    },
    {
      case : 'color as array #2',
      arg : [ 0, -1, 0 ],
      err : true
    },
    {
      case : 'color as array #3',
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

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync(function()
  {
    test.case = 'incorrect type';
    _.color.colorToRgbaHtml( function() {} );
  });
  test.shouldThrowErrorSync(function()
  {
    test.case = 'no arguments';
    _.color.colorToRgbaHtml( );
  });

}

//

function rgbByBitmask( test )
{
  var cases =
  [
    {
      case : '#1',
      arg : 0xff00ff,
      expected : [ 1, 0, 1 ]
    },
    {
      case : '#2',
      arg : 0x8000ff,
      expected : [ 0.5, 0, 1 ]
    },
    {
      case : '#3',
      arg : 0xff,
      expected : [ 0, 0, 1 ]
    },
    {
      case : '#4',
      arg : 255,
      expected : [ 0, 0, 1 ]
    },
    {
      case : '#5',
      arg : -1,
      expected : [ 1, 1, 1 ]
    },

  ]

  cases.forEach( function( element )
  {
    test.case = element.case;
    var got = _.color.rgbByBitmask( element.arg );
    test./*eps*/accuracy = 1e-2;
    test.equivalent( got, element.expected );
  });


  if( !Config.debug )
  return;

  test.shouldThrowErrorSync(function()
  {
    test.case = 'incorrect type';
    _.color.rgbByBitmask( 'str' );
  });
  test.shouldThrowErrorSync(function()
  {
    test.case = 'no arguments';
    _.color.rgbByBitmask( );
  });

}

//

function rgbaFrom( test )
{
  var cases =
  [
    {
      case : 'map #1',
      arg : { r : 0 },
      expected : [ 0, 1, 1, 1 ]
    },
    {
      case : 'map #2',
      arg : { r : 0, g : 1, b : 1, a : 0 },
      expected : [ 0, 1, 1, 0 ]
    },
    {
      case : 'number #1',
      arg : -1,
      expected : [ 1, 1, 1, 1 ]
    },
    {
      case : 'number #2',
      arg : 0xFF0080,
      expected : [ 1, 0, 0.5, 1 ]
    },
    {
      case : 'array #1',
      arg : [ -1, 0, 1, 1 ],
      expected : [ -1, 0, 1, 1 ]
    },
    {
      case : 'array #2',
      arg : [ 0, 0, 0 ],
      expected : [ 0, 0, 0, 1 ]
    },
    {
      case : 'str name#1',
      arg : 'white',
      expected : [ 1, 1, 1, 1 ]
    },
    {
      case : 'str hex #2',
      arg : '#ffffff',
      expected : [ 1, 1, 1, 1 ]
    },
    {
      case : 'rgb component > 1',
      arg : [ 10,10,10 ],
      expected : [ 10, 10, 10, 1 ]
    },
    {
      case : 'rgba component > 1',
      arg : [ 10,10,10,10 ],
      expected : [ 10, 10, 10, 10 ]
    },
    {
      case : 'all negative, no alpha',
      arg : [ -10, -10, -10 ],
      expected : [ -10, -10, -10, 1 ]
    },
    {
      case : 'all negative',
      arg : [ -10, -10, -10, -10 ],
      expected : [ -10, -10, -10, -10 ]
    }
  ]


  test.case = 'rgbaFrom bitmask';
  var color = 0xff0000;
  var got = _.color.rgbaFrom( color );
  var expected = [ 1,0,0,1 ];
  test.identical( got,expected );

  test.case = 'rgbaFrom name';
  var color = 'red';
  var got = _.color.rgbaFrom( color );
  var expected = [ 1,0,0,1 ];
  test.identical( got,expected );

  cases.forEach( function( element )
  {
    test.case = element.case;
    var got = _.color.rgbaFrom( element.arg );
    test./*eps*/accuracy = 1e-2;
    test.equivalent( got, element.expected );
  });


  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( function()
  {
    _.color.rgbaFrom( 'unknown' )
  })
  test.shouldThrowErrorSync( function()
  {
    _.color.rgbaFrom( function(){} )
  })

}

//

function rgbFrom( test )
{
  var cases =
  [
    {
      case : 'map #1',
      arg : { r : 0 },
      expected : [ 0, 1, 1 ]
    },
    {
      case : 'map #2',
      arg : { r : 0, g : 1, b : 1, a : 0 },
      expected : [ 0, 1, 1 ]
    },
    {
      case : 'number #1',
      arg : -1,
      expected : [ 1, 1, 1 ]
    },
    {
      case : 'number #2',
      arg : 0xFF0080,
      expected : [ 1, 0, 0.5 ]
    },
    {
      case : 'array #1',
      arg : [ -1, 0, 1, 1 ],
      expected : [ -1, 0, 1 ]
    },
    {
      case : 'array #2',
      arg : [ 0, 0, 0 ],
      expected : [ 0, 0, 0 ]
    },
    {
      case : 'str name#1',
      arg : 'white',
      expected : [ 1, 1, 1 ]
    },
    {
      case : 'str hex #2',
      arg : '#ffffff',
      expected : [ 1, 1, 1 ]
    },
    {
      case : 'rgb component > 1',
      arg : [ 10,10,10 ],
      expected : [ 10, 10, 10 ]
    },
    {
      case : 'all negative',
      arg : [ -10, -10, -10 ],
      expected : [ -10, -10, -10 ]
    }
  ]

  cases.forEach( function( element )
  {
    test.case = element.case;
    var got = _.color.rgbFrom( element.arg );
    test./*eps*/accuracy = 1e-2;
    test.equivalent( got, element.expected );
  });


  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( function()
  {
    _.color.rgbFrom( 'unknown' )
  })
  test.shouldThrowErrorSync( function()
  {
    _.color.rgbFrom( function(){} )
  })

}

//

var Self =
{

  name : 'Tools/mid/Color',
  silencing : 1,
  // verbosity : 1,

  tests :
  {

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
