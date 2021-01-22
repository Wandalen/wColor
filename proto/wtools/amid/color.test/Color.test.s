( function _Color_test_s_( )
{

'use strict';

if( typeof module !== 'undefined' )
{
  let _ = require( '../../../wtools/Tools.s' );
  require( '../color/Color.s' );
  _.include( 'wTesting' );
}

let _ = _global_.wTools;

// --
// tests
// --

function colorNameNearest( test )
{

  test.case = 'black';
  var color = [ 0, 0, 0, 1 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'black';
  test.identical( got, expected );

  test.case = 'close to invisible';
  var color = [ 0, 0, 0, 0 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'invisible';
  test.identical( got, expected );

  test.case = 'dim';
  var color = [ 0.3, 0.3, 0.3 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'dim';
  test.identical( got, expected );

  test.case = 'invisible';
  var color = [ 0.3, 0.3, 0.3, 0 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'invisible';
  test.identical( got, expected );

  test.case = 'close to transparent';
  var color = [ 1, 1, 1, 0 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'transparent';
  test.identical( got, expected );

  test.case = 'white with 0.8 transparency is closer to white';
  var color = [ 1, 1, 1, 0.8 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'white';
  test.identical( got, expected );

  test.case = 'white 0.7 transparency is still closer to transparent';
  var color = [ 1, 1, 1, 0.7 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'transparent';
  test.identical( got, expected );

  test.case = 'close to brown';
  var color = [ 0.6, 0.1, 0.1 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'brown';
  test.identical( got, expected );

  test.case = 'close to dark blue';
  var color = [ 0.1, 0.1, 0.6 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'dark blue';
  test.identical( got, expected );

  test.case = 'close to pink#1';
  var color = [ 0.9, 0.4, 0.6 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'purplish pink';
  test.identical( got, expected );

  test.case = 'close to pink#2';
  var color = [ 0.9, 0.4, 0.4 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'yellowish pink';
  test.identical( got, expected );

  test.case = 'white1';
  var color = [ 1, 1, 1 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'white';
  test.identical( got, expected );

  test.case = 'white2';
  var color = 'ffffff';
  var got = _.color.colorNameNearest( color );
  var expected = 'white';
  test.identical( got, expected );

  test.case = 'rgba a1 ';
  var color =  [ 1, 1, 1, 0.3 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'transparent';
  test.identical( got, expected );

  test.case = 'rgba a2';
  var color =  [ 1, 1, 1, 0.9 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'white';
  test.identical( got, expected );

  test.case = 'rgb a1';
  var color =  [ 0.5, 0, 0.1 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'maroon';
  test.identical( got, expected );

  test.case = 'rgb a2';
  var color =  [ 255, 0, 1 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'magenta';
  test.identical( got, expected );

  test.case = 'rgb a3';
  var color =  [ 0.2, 0, 0.3 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'olive green';
  test.identical( got, expected );

  test.case = 'rgb a4';
  var color =  [ 0.3, 0, 0.3 ];
  var got = _.color.colorNameNearest( color );
  var expected = 'purple';
  test.identical( got, expected );

  test.case = 'hex a1';
  var color = 'aaaaaa';
  var got = _.color.colorNameNearest( color );
  var expected = 'silver';
  test.identical( got, expected );

  test.case = 'empty string';
  var color = '';
  var got = _.color.colorNameNearest( color );
  var expected = undefined;
  test.identical( got, expected );

  test.case = 'empty array';
  var color = [];
  var got = _.color.colorNameNearest( color );
  var expected = 'white';
  test.identical( got, expected );

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.color.colorNameNearest();
  });

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.color.colorNameNearest();
  });

}

//

function colorToHex( test )
{
  var cases = /* qqq : normalize test routine */
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
  var cases = /* qqq : normalize test routine */
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
      arg : '01f',
      expected : [ 0.000, 0.066, 1.000 ]
    },
    {
      case : 'shorthand rgb',
      arg : 'a1f',
      expected : [ 0.666, 0.066, 1 ]
    },
    {
      case : 'shorthand rgba',
      arg : '1af0',
      expected : [ 0.066, 0.666, 1, 0 ],
    },
    {
      case : 'rgba',
      arg : 'abcd',
      expected : [ 0.666, 0.733, 0.8, 0.866 ],
    },
    {
      case : '#0fff',
      arg : '#0fff',
      expected : [ 0, 1, 1, 1 ],
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
    },
  ]

  cases.forEach( function( element )
  {
    test.case = element.case;
    var got = _.color.hexToColor( element.arg );
    test.equivalent( got, element.expected );
  });

}

hexToColor.accuracy = 1e-2;

//

function colorToRgbHtml( test )
{
  var cases = /* qqq : normalize test routine */
  [
    {
      case : 'color as string',
      arg : '#ff0000',
      expected : '#ff0000'
    },
    {
      case : 'color as obj',
      arg : { r : 0, g : 1, b : 0 },
      expected : 'rgb( 0, 255, 0 )'
    },
    {
      case : 'color as obj',
      arg : { r : 255, g : 0, b : 0 },
      err : true,
    },
    {
      case : 'color as obj',
      arg : { r : -1, g : 0, b : 0 },
      err : true,
    },
    {
      case : 'color as array',
      arg : [ 0, 1, 0 ],
      expected : 'rgb( 0, 255, 0 )'
    },
    {
      case : 'color as array',
      arg : [ 0, -1, 0 ],
      err : true
    },
    {
      case : 'color as array',
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

  test.shouldThrowErrorSync(function()
  {
    test.case = 'incorrect type';
    _.color.colorToRgbHtml( 1 );
  });
  test.shouldThrowErrorSync(function()
  {
    test.case = 'no arguments';
    _.color.colorToRgbHtml( );
  });

}

//

function colorToRgbaHtml( test )
{
  var cases = /* qqq : normalize test routine */
  [
    {
      case : 'color as string',
      arg : '#ff0000',
      expected : '#ff0000'
    },
    {
      case : 'color as obj',
      arg : { r : 0, g : 1, b : 0, a : 1 },
      expected : 'rgba( 0, 255, 0, 1 )'
    },
    {
      case : 'color as obj, incorrect value',
      arg : { r : 255, g : 0, b : 0 },
      err : true,
    },
    {
      case : 'color as obj',
      arg : { r : -1, g : 0, b : 0 },
      err : true,
    },
    {
      case : 'color as array',
      arg : [ 0, 1, 0, 0.5 ],
      expected : 'rgba( 0, 255, 0, 0.5 )'
    },
    {
      case : 'color as number',
      arg : 0x00FFFF,
      expected : 'rgba( 0, 255, 255, 1 )'
    },
    {
      case : 'color as array',
      arg : [ 0, -1, 0 ],
      err : true
    },
    {
      case : 'color as array',
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
  var cases = /* qqq : normalize test routine */
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
    // test.accuracy = 1e-2;
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

rgbByBitmask.accuracy = 1e-2;

//

function rgbaFrom( test )
{
  var cases = /* qqq : normalize test routine */
  [
    {
      case : 'map',
      arg : Object.create({ r : 0 }),
      expected : [ 0, 1, 1, 1 ]
    },
    {
      case : 'map',
      arg : Object.create({ r : 0, g : 1, b : 1, a : 0 }),
      expected : [ 0, 1, 1, 0 ]
    },
    {
      case : 'number',
      arg : -1,
      expected : [ 1, 1, 1, 1 ]
    },
    {
      case : 'number',
      arg : 0xFF0080,
      expected : [ 1, 0, 0.5, 1 ]
    },
    {
      case : 'array',
      arg : [ -1, 0, 1, 1 ],
      expected : [ -1, 0, 1, 1 ]
    },
    {
      case : 'array',
      arg : [ 0, 0, 0 ],
      expected : [ 0, 0, 0, 1 ]
    },
    {
      case : 'str name#1',
      arg : 'white',
      expected : [ 1, 1, 1, 1 ]
    },
    {
      case : 'str hex',
      arg : '#ffffff',
      expected : [ 1, 1, 1, 1 ]
    },
    {
      case : 'rgb component > 1',
      arg : [ 10, 10, 10 ],
      expected : [ 10, 10, 10, 1 ]
    },
    {
      case : 'rgba component > 1',
      arg : [ 10, 10, 10, 10 ],
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
  var expected = [ 1, 0, 0, 1 ];
  test.identical( got, expected );

  test.case = 'rgbaFrom name';
  var color = 'red';
  var got = _.color.rgbaFrom( color );
  var expected = [ 1, 0, 0, 1 ];
  test.identical( got, expected );

  test.case = 'string rgb';
  var exp = [ 0.666, 0.733, 0.8, 1 ];
  var got = _.color.rgbaFrom( 'aabbcc' );
  test.equivalent( got, exp );

  test.case = 'string rgb';
  var exp = [ 0.666, 0.733, 0.8, 0.866 ];
  var got = _.color.rgbaFrom( 'aabbccdd' );
  test.equivalent( got, exp );

  cases.forEach( function( element )
  {
    test.case = element.case;
    var got = _.color.rgbaFrom( element.arg );
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

rgbaFrom.accuracy = 1e-2;

//

function rgbFrom( test )
{

  var cases = /* qqq : normalize test routine */
  [
    {
      case : 'map',
      arg : Object.create({ r : 0 }),
      expected : [ 0, 1, 1 ]
    },
    {
      case : 'object',
      arg : Object.create({ r : 0, g : 1, b : 1, a : 0 }),
      expected : [ 0, 1, 1 ]
    },
    {
      case : 'number',
      arg : -1,
      expected : [ 1, 1, 1 ]
    },
    {
      case : 'number',
      arg : 0xFF0080,
      expected : [ 1, 0, 0.5 ]
    },
    {
      case : 'array',
      arg : [ -1, 0, 1, 1 ],
      expected : [ -1, 0, 1 ]
    },
    {
      case : 'array',
      arg : [ 0, 0, 0 ],
      expected : [ 0, 0, 0 ]
    },
    {
      case : 'str name#1',
      arg : 'white',
      expected : [ 1, 1, 1 ]
    },
    {
      case : 'str hex',
      arg : '#ffffff',
      expected : [ 1, 1, 1 ]
    },
    {
      case : 'rgb component > 1',
      arg : [ 10, 10, 10 ],
      expected : [ 10, 10, 10 ]
    },
    {
      case : 'all negative',
      arg : [ -10, -10, -10 ],
      expected : [ -10, -10, -10 ]
    },
  ]

  test.case = 'string rgb';
  var exp = [ 0.666, 0.733, 0.8 ];
  var got = _.color.rgbFrom( 'aabbcc' );
  test.equivalent( got, exp );

  test.case = 'string rgba';
  var exp = [ 0.666, 0.733, 0.8 ];
  var got = _.color.rgbFrom( 'aabbccdd' );
  test.equivalent( got, exp );

  cases.forEach( function( element )
  {
    test.case = element.case;
    var got = _.color.rgbFrom( element.arg );
    test.equivalent( got, element.expected );
  });

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( function()
  {
    _.color.rgbFrom( 'unknown' )
  });

  test.shouldThrowErrorSync( function()
  {
    _.color.rgbFrom( function(){} )
  });

}

rgbFrom.accuracy = 1e-2;

//

function rgbaHtmlFrom( test )
{
  test.case = 'string rgb';
  var color = [ 1, 0, 0, 1 ];
  var colorHtml = _.color.colorToRgbHtml( color );
  var got = _.color.rgbaHtmlFrom( colorHtml );
  test.identical( got, color );

  test.case = 'string rgb';
  var color = [ 1, 0, 0, 0.5 ];
  var exp = [ 1, 0, 0, 1 ]
  var colorHtml = _.color.colorToRgbHtml( color );
  var got = _.color.rgbaHtmlFrom( colorHtml );
  test.identical( got, exp );

  test.case = 'string rgba';
  var color = [ 1, 0, 0, 0.5 ];
  var colorHtml = _.color.colorToRgbaHtml( color );
  var got = _.color.rgbaHtmlFrom( colorHtml );
  test.identical( got, color );
}

//

function cmykStrToRgb( test )
{

  test.open( 'basic colors' );

  test.case = 'Black';
  var src = 'cmyk(0%,0%,0%,100%)';
  var expected = [ 0, 0, 0 ];
  var got = _.color.cmykStrToRgb( src );
  test.identical( got, expected );

  test.case = 'White';
  var src = 'cmyk(0%,0%,0%,0%)';
  var expected = [ 1, 1, 1 ];
  var got = _.color.cmykStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Red';
  var src = 'cmyk(0%,100%,100%,0%)';
  var expected = [ 1, 0, 0 ];
  var got = _.color.cmykStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Green';
  var src = 'cmyk(100%,0%,100%,0%)';
  var expected = [ 0, 1, 0 ];
  var got = _.color.cmykStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Blue';
  var src = 'cmyk(100%,100%,0%,0%)';
  var expected = [ 0, 0, 1 ];
  var got = _.color.cmykStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Yellow';
  var src = 'cmyk(0%,0%,100%,0%)';
  var expected = [ 1, 1, 0 ];
  var got = _.color.cmykStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Cyan';
  var src = 'cmyk(100%,0%,0%,0%)';
  var expected = [ 0, 1, 1 ];
  var got = _.color.cmykStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Magenta';
  var src = 'cmyk(0%,100%,0%,0%)';
  var expected = [ 1, 0, 1 ];
  var got = _.color.cmykStrToRgb( src );
  test.identical( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = 'cmyk(12%,34%,99%,27%)';
  var src = 'cmyk(12%,34%,99%,27%)';
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.cmykStrToRgb( src );
  test.identical( got, expected );

  test.case = 'cmyk(87%,1%,33%,5%)';
  var src = 'cmyk(87%,1%,33%,5%)';
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588 ];
  var got = _.color.cmykStrToRgb( src );
  test.identical( got, expected );

  test.case = 'cmyk(11%,16%,75%,4%)';
  var src = 'cmyk(11%,16%,75%,4%)';
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981 ];
  var got = _.color.cmykStrToRgb( src );
  test.identical( got, expected );

  test.close( 'non basic colors' );

}

cmykStrToRgb.accuracy = 2e-3;

//

function cmykStrToRgba( test )
{

  test.open( 'basic colors' );

  test.case = 'Black';
  var src = 'cmyk(0%,0%,0%,100%)';
  var expected = [ 0, 0, 0, 1 ];
  var got = _.color.cmykStrToRgba( src );
  test.identical( got, expected );

  test.case = 'White';
  var src = 'cmyk(0%,0%,0%,0%)';
  var expected = [ 1, 1, 1, 1 ];
  var got = _.color.cmykStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Red';
  var src = 'cmyk(0%,100%,100%,0%)';
  var expected = [ 1, 0, 0, 1 ];
  var got = _.color.cmykStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Green';
  var src = 'cmyk(100%,0%,100%,0%)';
  var expected = [ 0, 1, 0, 1 ];
  var got = _.color.cmykStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Blue';
  var src = 'cmyk(100%,100%,0%,0%)';
  var expected = [ 0, 0, 1, 1 ];
  var got = _.color.cmykStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Yellow';
  var src = 'cmyk(0%,0%,100%,0%)';
  var expected = [ 1, 1, 0, 1 ];
  var got = _.color.cmykStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Cyan';
  var src = 'cmyk(100%,0%,0%,0%)';
  var expected = [ 0, 1, 1, 1 ];
  var got = _.color.cmykStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Magenta';
  var src = 'cmyk(0%,100%,0%,0%)';
  var expected = [ 1, 0, 1, 1 ];
  var got = _.color.cmykStrToRgba( src );
  test.identical( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = 'cmyk(12%,34%,99%,27%)';
  var src = 'cmyk(12%,34%,99%,27%)';
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 1 ];
  var got = _.color.cmykStrToRgba( src );
  test.identical( got, expected );

  test.case = 'cmyk(87%,1%,33%,5%)';
  var src = 'cmyk(87%,1%,33%,5%)';
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588, 1 ];
  var got = _.color.cmykStrToRgba( src );
  test.identical( got, expected );

  test.case = 'cmyk(11%,16%,75%,4%)';
  var src = 'cmyk(11%,16%,75%,4%)';
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981, 1 ];
  var got = _.color.cmykStrToRgba( src );
  test.identical( got, expected );

  test.close( 'non basic colors' );

  test.case = 'first arg > 100%';
  var src = 'cmyk(111%,16%,75%,4%)';
  var expected = null;
  var got = _.color.cmykStrToRgba( src );
  test.identical( got, expected );

  test.case = 'second arg > 100%';
  var src = 'cmyk(11%,160%,75%,4%)';
  var expected = null;
  var got = _.color.cmykStrToRgba( src );
  test.identical( got, expected );

  test.case = 'third arg > 100%';
  var src = 'cmyk(11%,16%,750%,4%)';
  var expected = null;
  var got = _.color.cmykStrToRgba( src );
  test.identical( got, expected );

  test.case = 'fourth arg > 100%';
  var src = 'cmyk(11%,16%,75%,400%)';
  var expected = null;
  var got = _.color.cmykStrToRgba( src );
  test.identical( got, expected );

}

cmykStrToRgba.accuracy = 2e-3;

//

function cmykStructureStrToRgb( test )
{

  test.open( 'basic colors' );

  test.case = 'Black';
  var src = 'C0/M0/Y0/K100';
  var expected = [ 0, 0, 0 ];
  var got = _.color.cmykStructureStrToRgb( src );
  test.identical( got, expected );

  test.case = 'White';
  var src = 'C0/M0/Y0/K0';
  var expected = [ 1, 1, 1 ];
  var got = _.color.cmykStructureStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Red';
  var src = 'C0/M100/Y100/K0';
  var expected = [ 1, 0, 0 ];
  var got = _.color.cmykStructureStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Green';
  var src = 'C100/M0/Y100/K0';
  var expected = [ 0, 1, 0 ];
  var got = _.color.cmykStructureStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Blue';
  var src = 'C100/M100/Y0/K0';
  var expected = [ 0, 0, 1 ];
  var got = _.color.cmykStructureStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Yellow';
  var src = 'C0/M0/Y100/K0';
  var expected = [ 1, 1, 0 ];
  var got = _.color.cmykStructureStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Cyan';
  var src = 'C100/M0/Y0/K0';
  var expected = [ 0, 1, 1 ];
  var got = _.color.cmykStructureStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Magenta';
  var src = 'C0/M100/Y0/K0';
  var expected = [ 1, 0, 1 ];
  var got = _.color.cmykStructureStrToRgb( src );
  test.identical( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = 'C12/M34/Y99/K27';
  var src = 'C12/M34/Y99/K27';
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.cmykStructureStrToRgb( src );
  test.identical( got, expected );

  test.case = 'C87/M1/Y33/K5';
  var src = 'C87/M1/Y33/K5';
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588 ];
  var got = _.color.cmykStructureStrToRgb( src );
  test.identical( got, expected );

  test.case = 'C11/M16/Y75/K4';
  var src = 'C11/M16/Y75/K4';
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981 ];
  var got = _.color.cmykStructureStrToRgb( src );
  test.identical( got, expected );

  test.close( 'non basic colors' );

}

cmykStructureStrToRgb.accuracy = 2e-3;

//

function cmykStructureStrToRgba( test )
{

  test.open( 'basic colors' );

  test.case = 'Black';
  var src = 'C0/M0/Y0/K100';
  var expected = [ 0, 0, 0, 1 ];
  var got = _.color.cmykStructureStrToRgba( src );
  test.identical( got, expected );

  test.case = 'White';
  var src = 'C0/M0/Y0/K0';
  var expected = [ 1, 1, 1, 1 ];
  var got = _.color.cmykStructureStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Red';
  var src = 'C0/M100/Y100/K0';
  var expected = [ 1, 0, 0, 1 ];
  var got = _.color.cmykStructureStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Green';
  var src = 'C100/M0/Y100/K0';
  var expected = [ 0, 1, 0, 1 ];
  var got = _.color.cmykStructureStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Blue';
  var src = 'C100/M100/Y0/K0';
  var expected = [ 0, 0, 1, 1 ];
  var got = _.color.cmykStructureStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Yellow';
  var src = 'C0/M0/Y100/K0';
  var expected = [ 1, 1, 0, 1 ];
  var got = _.color.cmykStructureStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Cyan';
  var src = 'C100/M0/Y0/K0';
  var expected = [ 0, 1, 1, 1 ];
  var got = _.color.cmykStructureStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Magenta';
  var src = 'C0/M100/Y0/K0';
  var expected = [ 1, 0, 1, 1 ];
  var got = _.color.cmykStructureStrToRgba( src );
  test.identical( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = 'C12/M34/Y99/K27';
  var src = 'C12/M34/Y99/K27';
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 1 ];
  var got = _.color.cmykStructureStrToRgba( src );
  test.identical( got, expected );

  test.case = 'C87/M1/Y33/K5';
  var src = 'C87/M1/Y33/K5';
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588, 1 ];
  var got = _.color.cmykStructureStrToRgba( src );
  test.identical( got, expected );

  test.case = 'C11/M16/Y75/K4';
  var src = 'C11/M16/Y75/K4';
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981, 1 ];
  var got = _.color.cmykStructureStrToRgba( src );
  test.identical( got, expected );

  test.close( 'non basic colors' );

  test.case = 'first arg > 100%';
  var src = 'C111/M16/Y75/K4';
  var expected = null;
  var got = _.color.cmykStrToRgba( src );
  test.identical( got, expected );

  test.case = 'second arg > 100%';
  var src = 'cC11/M162/Y75/K4';
  var expected = null;
  var got = _.color.cmykStrToRgba( src );
  test.identical( got, expected );

  test.case = 'third arg > 100%';
  var src = 'C11/M16/Y750/K4';
  var expected = null;
  var got = _.color.cmykStrToRgba( src );
  test.identical( got, expected );

  test.case = 'fourth arg > 100%';
  var src = 'C11/M16/Y75/K400';
  var expected = null;
  var got = _.color.cmykStrToRgba( src );
  test.identical( got, expected );

}

cmykStructureStrToRgba.accuracy = 2e-3;

//

function hwbStrToRgb( test )
{

  test.open( 'basic colors' );

  test.case = 'Black';
  var src = 'hwb(0, 0%, 100%)';
  var expected = [ 0, 0, 0 ];
  var got = _.color.hwbStrToRgb( src );
  test.identical( got, expected );

  test.case = 'White';
  var src = 'hwb(0, 100%, 0%)';
  var expected = [ 1, 1, 1 ];
  var got = _.color.hwbStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Red';
  var src = 'hwb(0, 0%, 0%)';
  var expected = [ 1, 0, 0 ];
  var got = _.color.hwbStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Green';
  var src = 'hwb(120, 0%, 0%)';
  var expected = [ 0, 1, 0 ];
  var got = _.color.hwbStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Blue';
  var src = 'hwb(240,0%,0%)';
  var expected = [ 0, 0, 1 ];
  var got = _.color.hwbStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Yellow';
  var src = 'hwb(60,0%,0%)';
  var expected = [ 1, 1, 0 ];
  var got = _.color.hwbStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Cyan';
  var src = 'hwb(180,0%,0%)';
  var expected = [ 0, 1, 1 ];
  var got = _.color.hwbStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Magenta';
  var src = 'hwb(300,0%,0%)';
  var expected = [ 1, 0, 1 ];
  var got = _.color.hwbStrToRgb( src );
  test.identical( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = 'hwb(45, 1%, 36%)';
  var src = 'hwb(45, 1%, 36%)';
  var expected = [ 0.6392156862745098, 0.4823529411764706, 0.011764705882352941 ];
  var got = _.color.hwbStrToRgb( src );
  test.identical( got, expected );

  test.case = 'hwb(158, 12%, 6%)';
  var src = 'hwb(158, 12%, 6%)';
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6392156862745098 ];
  var got = _.color.hwbStrToRgb( src );
  test.identical( got, expected );

  test.case = 'hwb(55, 24%, 15%)';
  var src = 'hwb(55, 24%, 15%)';
  var expected = [ 0.8509803921568627, 0.8, 0.23921568627450981 ];
  var got = _.color.hwbStrToRgb( src );
  test.identical( got, expected );

  test.close( 'non basic colors' );

  test.case = 'first arg > 360';
  var src = 'hwb(366,16%,75%)';
  var expected = null;
  var got = _.color.hwbStrToRgb( src );
  test.identical( got, expected );

  test.case = 'second arg > 100%';
  var src = 'hwb(35,160%,75%)';
  var expected = null;
  var got = _.color.hwbStrToRgb( src );
  test.identical( got, expected );

}

//

function hwbStrToRgba( test )
{

  test.open( 'basic colors' );

  test.case = 'Black';
  var src = 'hwb(0, 0%, 100%)';
  var expected = [ 0, 0, 0, 1 ];
  var got = _.color.hwbStrToRgba( src );
  test.identical( got, expected );

  test.case = 'White';
  var src = 'hwb(0, 100%, 0%)';
  var expected = [ 1, 1, 1, 1 ];
  var got = _.color.hwbStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Red';
  var src = 'hwb(0, 0%, 0%)';
  var expected = [ 1, 0, 0, 1 ];
  var got = _.color.hwbStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Green';
  var src = 'hwb(120, 0%, 0%)';
  var expected = [ 0, 1, 0, 1 ];
  var got = _.color.hwbStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Blue';
  var src = 'hwb(240,0%,0%)';
  var expected = [ 0, 0, 1, 1 ];
  var got = _.color.hwbStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Yellow';
  var src = 'hwb(60,0%,0%)';
  var expected = [ 1, 1, 0, 1 ];
  var got = _.color.hwbStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Cyan';
  var src = 'hwb(180,0%,0%)';
  var expected = [ 0, 1, 1, 1 ];
  var got = _.color.hwbStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Magenta';
  var src = 'hwb(300,0%,0%)';
  var expected = [ 1, 0, 1, 1 ];
  var got = _.color.hwbStrToRgba( src );
  test.identical( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = 'hwb(45, 1%, 36%)';
  var src = 'hwb(45, 1%, 36%)';
  var expected = [ 0.6392156862745098, 0.4823529411764706, 0.011764705882352941, 1 ];
  var got = _.color.hwbStrToRgba( src );
  test.identical( got, expected );

  test.case = 'hwb(158, 12%, 6%)';
  var src = 'hwb(158, 12%, 6%)';
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6392156862745098, 1 ];
  var got = _.color.hwbStrToRgba( src );
  test.identical( got, expected );

  test.case = 'hwb(55, 24%, 15%)';
  var src = 'hwb(55, 24%, 15%)';
  var expected = [ 0.8509803921568627, 0.8, 0.23921568627450981, 1 ];
  var got = _.color.hwbStrToRgba( src );
  test.identical( got, expected );

  test.close( 'non basic colors' );

  test.case = 'first arg > 360';
  var src = 'hwb(366,16%,75%)';
  var expected = null;
  var got = _.color.hwbStrToRgba( src );
  test.identical( got, expected );

  test.case = 'second arg > 100%';
  var src = 'hwb(35,160%,75%)';
  var expected = null;
  var got = _.color.hwbStrToRgba( src );
  test.identical( got, expected );

  test.case = 'third arg > 100%';
  var src = 'hwb(35,10%,175%)';
  var expected = null;
  var got = _.color.hwbStrToRgba( src );
  test.identical( got, expected );

}

//

function hexStrToRgb( test )
{

  test.open( 'basic colors' );

  test.case = 'Black';
  var src = '#000000';
  var expected = [ 0, 0, 0 ];
  var got = _.color.hexStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Black short';
  var src = '#000';
  var expected = [ 0, 0, 0 ];
  var got = _.color.hexStrToRgb( src );
  test.identical( got, expected );

  test.case = 'White';
  var src = '#ffffff';
  var expected = [ 1, 1, 1 ];
  var got = _.color.hexStrToRgb( src );
  test.identical( got, expected );

  test.case = 'White short';
  var src = '#fff';
  var expected = [ 1, 1, 1 ];
  var got = _.color.hexStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Red';
  var src = '#ff0000';
  var expected = [ 1, 0, 0 ];
  var got = _.color.hexStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Red short';
  var src = '#f00';
  var expected = [ 1, 0, 0 ];
  var got = _.color.hexStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Green';
  var src = '#00ff00';
  var expected = [ 0, 1, 0 ];
  var got = _.color.hexStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Green short';
  var src = '#0f0';
  var expected = [ 0, 1, 0 ];
  var got = _.color.hexStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Blue';
  var src = '#0000ff';
  var expected = [ 0, 0, 1 ];
  var got = _.color.hexStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Blue short';
  var src = '#00f';
  var expected = [ 0, 0, 1 ];
  var got = _.color.hexStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Yellow';
  var src = '#ffff00';
  var expected = [ 1, 1, 0 ];
  var got = _.color.hexStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Yellow short';
  var src = '#ff0';
  var expected = [ 1, 1, 0 ];
  var got = _.color.hexStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Cyan';
  var src = '#00ffff';
  var expected = [ 0, 1, 1 ];
  var got = _.color.hexStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Cyan short';
  var src = '#0ff';
  var expected = [ 0, 1, 1 ];
  var got = _.color.hexStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Magenta';
  var src = '#ff00ff';
  var expected = [ 1, 0, 1 ];
  var got = _.color.hexStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Magenta short';
  var src = '#f0f';
  var expected = [ 1, 0, 1 ];
  var got = _.color.hexStrToRgb( src );
  test.identical( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = '#a47b02';
  var src = '#a47b02';
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.hexStrToRgb( src );
  test.identical( got, expected );

  test.case = '#1ff0a2';
  var src = '#1ff0a2';
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588 ];
  var got = _.color.hexStrToRgb( src );
  test.identical( got, expected );

  test.case = '#dace3d';
  var src = '#dace3d';
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981 ];
  var got = _.color.hexStrToRgb( src );
  test.identical( got, expected );

  test.close( 'non basic colors' );

  test.case = 'length > 6';
  var src = '#fffffff';
  var expected = null;
  var got = _.color.hexStrToRgb( src );
  test.identical( got, expected );

  test.case = 'length < 3';
  var src = '#ff';
  var expected = null;
  var got = _.color.hexStrToRgb( src );
  test.identical( got, expected );

}

//

function hexStrToRgba( test )
{

  test.open( 'basic colors' );

  test.case = 'Black';
  var src = '#000000ff';
  var expected = [ 0, 0, 0, 1 ];
  var got = _.color.hexStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Black short';
  var src = '#000f';
  var expected = [ 0, 0, 0, 1 ];
  var got = _.color.hexStrToRgba( src );
  test.identical( got, expected );

  test.case = 'White';
  var src = '#ffffff00';
  var expected = [ 1, 1, 1, 0 ];
  var got = _.color.hexStrToRgba( src );
  test.identical( got, expected );

  test.case = 'White short';
  var src = '#fff0';
  var expected = [ 1, 1, 1, 0 ];
  var got = _.color.hexStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Red';
  var src = '#ff0000cc';
  var expected = [ 1, 0, 0, 0.8 ];
  var got = _.color.hexStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Red short';
  var src = '#f00c';
  var expected = [ 1, 0, 0, 0.8 ];
  var got = _.color.hexStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Green';
  var src = '#00ff0011';
  var expected = [ 0, 1, 0, 0.07 ];
  var got = _.color.hexStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Green short';
  var src = '#0f01';
  var expected = [ 0, 1, 0, 0.07 ];
  var got = _.color.hexStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Blue';
  var src = '#0000ffdd';
  var expected = [ 0, 0, 1, 0.87 ];
  var got = _.color.hexStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Blue short';
  var src = '#00fd';
  var expected = [ 0, 0, 1, 0.87 ];
  var got = _.color.hexStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Yellow';
  var src = '#ffff0033';
  var expected = [ 1, 1, 0, 0.2 ];
  var got = _.color.hexStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Yellow short';
  var src = '#ff03';
  var expected = [ 1, 1, 0, 0.2 ];
  var got = _.color.hexStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Cyan';
  var src = '#00ffff66';
  var expected = [ 0, 1, 1, 0.4 ];
  var got = _.color.hexStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Cyan short';
  var src = '#0ff66';
  var expected = [ 0, 1, 1, 0.4 ];
  var got = _.color.hexStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Magenta';
  var src = '#ff00ffee';
  var expected = [ 1, 0, 1, 0.93 ];
  var got = _.color.hexStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Magenta short';
  var src = '#f0fe';
  var expected = [ 1, 0, 1, 0.93 ];
  var got = _.color.hexStrToRgba( src );
  test.identical( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = '#a47b02';
  var src = '#a47b02';
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 1 ];
  var got = _.color.hexStrToRgba( src );
  test.identical( got, expected );

  test.case = '#1ff0a218';
  var src = '#1ff0a218';
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588, 0.09 ];
  var got = _.color.hexStrToRgba( src );
  test.identical( got, expected );

  test.case = '#dace3dd2';
  var src = '#dace3dd2';
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981, 0.82 ];
  var got = _.color.hexStrToRgba( src );
  test.identical( got, expected );

  test.close( 'non basic colors' );

  test.case = 'length > 8';
  var src = '#ffffffff9';
  var expected = null;
  var got = _.color.hexStrToRgba( src );
  test.identical( got, expected );

  test.case = 'length < 3';
  var src = '#ff';
  var expected = null;
  var got = _.color.hexStrToRgba( src );
  test.identical( got, expected );

}

//

function rgbStrToRgb( test )
{

  test.open( 'basic colors' );

  test.case = 'Black';
  var src = 'rgb(0, 0, 0)';
  var expected = [ 0, 0, 0 ];
  var got = _.color.rgbStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Black with spaces';
  var src = 'rgb(0 0 0)';
  var expected = [ 0, 0, 0 ];
  var got = _.color.rgbStrToRgb( src );
  test.identical( got, expected );

  test.case = 'White';
  var src = 'rgb(255, 255, 255)';
  var expected = [ 1, 1, 1 ];
  var got = _.color.rgbStrToRgb( src );
  test.identical( got, expected );

  test.case = 'White with spaces';
  var src = 'rgb(255 255 255)';
  var expected = [ 1, 1, 1 ];
  var got = _.color.rgbStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Red';
  var src = 'rgb(255, 0, 0)';
  var expected = [ 1, 0, 0 ];
  var got = _.color.rgbStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Red with spaces';
  var src = 'rgb(255 0 0)';
  var expected = [ 1, 0, 0 ];
  var got = _.color.rgbStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Green';
  var src = 'rgb(0, 255, 0)';
  var expected = [ 0, 1, 0 ];
  var got = _.color.rgbStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Green with spaces';
  var src = 'rgb(0 255 0)';
  var expected = [ 0, 1, 0 ];
  var got = _.color.rgbStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Blue';
  var src = 'rgb(0, 0, 255)';
  var expected = [ 0, 0, 1 ];
  var got = _.color.rgbStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Blue with spaces';
  var src = 'rgb(0 0 255)';
  var expected = [ 0, 0, 1 ];
  var got = _.color.rgbStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Yellow';
  var src = 'rgb(255, 255, 0)';
  var expected = [ 1, 1, 0 ];
  var got = _.color.rgbStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Yellow with spaces';
  var src = 'rgb(255 255 0)';
  var expected = [ 1, 1, 0 ];
  var got = _.color.rgbStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Cyan';
  var src = 'rgb(0, 255, 255)';
  var expected = [ 0, 1, 1 ];
  var got = _.color.rgbStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Cyan with spaces';
  var src = 'rgb(0 255 255)';
  var expected = [ 0, 1, 1 ];
  var got = _.color.rgbStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Magenta';
  var src = 'rgb(255, 0, 255)';
  var expected = [ 1, 0, 1 ];
  var got = _.color.rgbStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Magenta with spaces';
  var src = 'rgb(255 0 255)';
  var expected = [ 1, 0, 1 ];
  var got = _.color.rgbStrToRgb( src );
  test.identical( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = 'rgb(164, 123, 2)';
  var src = 'rgb(164, 123, 2)';
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.rgbStrToRgb( src );
  test.identical( got, expected );

  test.case = 'rgb(164 123 2)';
  var src = 'rgb(164 123 2)';
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.rgbStrToRgb( src );
  test.identical( got, expected );

  test.case = 'rgb(31, 240, 162)';
  var src = 'rgb(31, 240, 162)';
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588 ];
  var got = _.color.rgbStrToRgb( src );
  test.identical( got, expected );

  test.case = 'rgb(31 240 162)';
  var src = 'rgb(31 240 162)';
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588 ];
  var got = _.color.rgbStrToRgb( src );
  test.identical( got, expected );

  test.case = 'rgb(218, 206, 61)';
  var src = 'rgb(218, 206, 61)';
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981 ];
  var got = _.color.rgbStrToRgb( src );
  test.identical( got, expected );

  test.case = 'rgb(218 206 61)';
  var src = 'rgb(218 206 61)';
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981 ];
  var got = _.color.rgbStrToRgb( src );
  test.identical( got, expected );

  test.close( 'non basic colors' );

  test.case = 'first arg > 255';
  var src = 'rgb(280, 123, 2)';
  var expected = null;
  var got = _.color.rgbStrToRgb( src );
  test.identical( got, expected );

  test.case = 'first arg > 255, with spaces';
  var src = 'rgb(280 123 2)';
  var expected = null;
  var got = _.color.rgbStrToRgb( src );
  test.identical( got, expected );

  test.case = 'second arg > 255';
  var src = 'rgb(244, 256, 2)';
  var expected = null;
  var got = _.color.rgbStrToRgb( src );
  test.identical( got, expected );

  test.case = 'second arg > 255, with space';
  var src = 'rgb(244 256 2)';
  var expected = null;
  var got = _.color.rgbStrToRgb( src );
  test.identical( got, expected );

}

//

function rgbaStrToRgba( test )
{

  test.open( 'basic colors' );

  test.case = 'Black';
  var src = 'rgba(0, 0, 0, 1)';
  var expected = [ 0, 0, 0, 1 ];
  var got = _.color.rgbaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Black with space';
  var src = 'rgba(0 0 0 1)';
  var expected = [ 0, 0, 0, 1 ];
  var got = _.color.rgbaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'White';
  var src = 'rgba(255, 255, 255, 1)';
  var expected = [ 1, 1, 1, 1 ];
  var got = _.color.rgbaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'White with space';
  var src = 'rgba(255 255 255 1)';
  var expected = [ 1, 1, 1, 1 ];
  var got = _.color.rgbaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Red';
  var src = 'rgba(255, 0, 0, 1)';
  var expected = [ 1, 0, 0, 1 ];
  var got = _.color.rgbaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Red with space';
  var src = 'rgba(255 0 0 1)';
  var expected = [ 1, 0, 0, 1 ];
  var got = _.color.rgbaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Green';
  var src = 'rgba(0, 255, 0, 1)';
  var expected = [ 0, 1, 0, 1 ];
  var got = _.color.rgbaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Green with space';
  var src = 'rgba(0 255 0 1)';
  var expected = [ 0, 1, 0, 1 ];
  var got = _.color.rgbaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Blue';
  var src = 'rgba(0, 0, 255, 1)';
  var expected = [ 0, 0, 1, 1 ];
  var got = _.color.rgbaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Blue with space';
  var src = 'rgba(0 0 255 1)';
  var expected = [ 0, 0, 1, 1 ];
  var got = _.color.rgbaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Yellow';
  var src = 'rgba(255, 255, 0, 1)';
  var expected = [ 1, 1, 0, 1 ];
  var got = _.color.rgbaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Yellow with space';
  var src = 'rgba(255 255 0 1)';
  var expected = [ 1, 1, 0, 1 ];
  var got = _.color.rgbaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Cyan';
  var src = 'rgba(0, 255, 255, 1)';
  var expected = [ 0, 1, 1, 1 ];
  var got = _.color.rgbaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Cyan with space';
  var src = 'rgba(0 255 255 1)';
  var expected = [ 0, 1, 1, 1 ];
  var got = _.color.rgbaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Magenta';
  var src = 'rgba(255, 0, 255, 1)';
  var expected = [ 1, 0, 1, 1 ];
  var got = _.color.rgbaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Magenta with space';
  var src = 'rgba(255 0 255 1)';
  var expected = [ 1, 0, 1, 1 ];
  var got = _.color.rgbaStrToRgba( src );
  test.identical( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = 'rgba(164, 123, 2, 0.1)';
  var src = 'rgba(164, 123, 2, 0.1)';
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 0.1 ];
  var got = _.color.rgbaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'rgba(164 123 2 / 0.1)';
  var src = 'rgba(164 123 2 / 0.1)';
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 0.1 ];
  var got = _.color.rgbaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'rgba(31, 240, 162, 0.55)';
  var src = 'rgba(31, 240, 162, 0.55)';
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588, 0.55 ];
  var got = _.color.rgbaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'rgba(31 240 162 / 0.55)';
  var src = 'rgba(31 240 162 / 0.55)';
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588, 0.55 ];
  var got = _.color.rgbaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'rgba(218, 206, 61, 0.39)';
  var src = 'rgba(218, 206, 61, 0.39)';
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981, 0.39 ];
  var got = _.color.rgbaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'rgba(218 206 61 / 0.39)';
  var src = 'rgba(218 206 61 / 0.39)';
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981, 0.39 ];
  var got = _.color.rgbaStrToRgba( src );
  test.identical( got, expected );

  test.close( 'non basic colors' );

  test.case = 'first arg > 255';
  var src = 'rgba(280, 123, 2, 1)';
  var expected = null;
  var got = _.color.rgbaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'first arg > 255, with spaces';
  var src = 'rgba(280 123 2 1)';
  var expected = null;
  var got = _.color.rgbaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'second arg > 255';
  var src = 'rgba(244, 256, 2, 1)';
  var expected = null;
  var got = _.color.rgbaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'second arg > 255, with spaces';
  var src = 'rgba(244 256 2 1)';
  var expected = null;
  var got = _.color.rgbaStrToRgba( src );
  test.identical( got, expected );

}

//

function rgbStructureStrToRgb( test )
{

  test.open( 'basic colors' );

  test.case = 'Black';
  var src = 'R:0 G:0 B:0';
  var expected = [ 0, 0, 0 ];
  var got = _.color.rgbStructureStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Black with slashes';
  var src = '(R:0 / G:0 / B:0)';
  var expected = [ 0, 0, 0 ];
  var got = _.color.rgbStructureStrToRgb( src );
  test.identical( got, expected );

  test.case = 'White';
  var src = 'R:255 G:255 B:255';
  var expected = [ 1, 1, 1 ];
  var got = _.color.rgbStructureStrToRgb( src );
  test.identical( got, expected );

  test.case = 'White with slashes';
  var src = '(R255 / G255 / B255)';
  var expected = [ 1, 1, 1 ];
  var got = _.color.rgbStructureStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Red';
  var src = 'R:255 G:0 B:0';
  var expected = [ 1, 0, 0 ];
  var got = _.color.rgbStructureStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Red with slashes';
  var src = '(R255 / G0 / B0)';
  var expected = [ 1, 0, 0 ];
  var got = _.color.rgbStructureStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Green';
  var src = 'R:0 G:255 B:0';
  var expected = [ 0, 1, 0 ];
  var got = _.color.rgbStructureStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Green with slashes';
  var src = '(R0 / G255 / B0)';
  var expected = [ 0, 1, 0 ];
  var got = _.color.rgbStructureStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Blue';
  var src = 'R:0 G:0 B:255';
  var expected = [ 0, 0, 1 ];
  var got = _.color.rgbStructureStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Blue with slashes';
  var src = '(R0 / G0 / B255)';
  var expected = [ 0, 0, 1 ];
  var got = _.color.rgbStructureStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Yellow';
  var src = 'R:255 G:255 B:0';
  var expected = [ 1, 1, 0 ];
  var got = _.color.rgbStructureStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Yellow with slashes';
  var src = '(R255 / G255 / B0)';
  var expected = [ 1, 1, 0 ];
  var got = _.color.rgbStructureStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Cyan';
  var src = 'R:0 G:255 B:255';
  var expected = [ 0, 1, 1 ];
  var got = _.color.rgbStructureStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Cyan with slashes';
  var src = '(R0 / G255 / B255)';
  var expected = [ 0, 1, 1 ];
  var got = _.color.rgbStructureStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Magenta';
  var src = 'R:255 G:0 B:255';
  var expected = [ 1, 0, 1 ];
  var got = _.color.rgbStructureStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Magenta with slashes';
  var src = '(R255 / G0 / B255)';
  var expected = [ 1, 0, 1 ];
  var got = _.color.rgbStructureStrToRgb( src );
  test.identical( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = 'R:164 G:123 B:2';
  var src = 'R:164 G:123 B:2';
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.rgbStructureStrToRgb( src );
  test.identical( got, expected );

  test.case = '(R164 / G123 / B2)';
  var src = '(R164 / G123 / B2)';
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.rgbStructureStrToRgb( src );
  test.identical( got, expected );

  test.case = 'R:31 G:240 B:162';
  var src = 'R:31 G:240 B:162';
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588 ];
  var got = _.color.rgbStructureStrToRgb( src );
  test.identical( got, expected );

  test.case = '(R31 / G240 / B162)';
  var src = '(R31 / G240 / B162)';
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588 ];
  var got = _.color.rgbStructureStrToRgb( src );
  test.identical( got, expected );

  test.case = 'R:218 G:206 B:61';
  var src = 'R:218 G:206 B:61';
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981 ];
  var got = _.color.rgbStructureStrToRgb( src );
  test.identical( got, expected );

  test.case = '(R218 / G206 / B61)';
  var src = '(R218 / G206 / B61)';
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981 ];
  var got = _.color.rgbStructureStrToRgb( src );
  test.identical( got, expected );

  test.close( 'non basic colors' );

  test.case = 'first arg > 255';
  var src = 'R:259 G:0 B:0';
  var expected = null;
  var got = _.color.rgbStructureStrToRgb( src );
  test.identical( got, expected );

  test.case = 'first arg > 255, with slashes';
  var src = '(R259 / G20 / B30)';
  var expected = null;
  var got = _.color.rgbStructureStrToRgb( src );
  test.identical( got, expected );

  test.case = 'second arg > 255';
  var src = 'R:29 G:259 B:0';
  var expected = null;
  var got = _.color.rgbStructureStrToRgb( src );
  test.identical( got, expected );

  test.case = 'second arg > 255, with slashes';
  var src = '(R29 / G259 / B30)';
  var expected = null;
  var got = _.color.rgbStructureStrToRgb( src );
  test.identical( got, expected );

}

//

function hslStrToRgb( test )
{

  test.open( 'basic colors' );

  test.case = 'Black';
  var src = 'hsl(0, 0%, 0%)';
  var expected = [ 0, 0, 0 ];
  var got = _.color.hslStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Black with spaces';
  var src = 'hsl(0 0% 0%)';
  var expected = [ 0, 0, 0 ];
  var got = _.color.hslStrToRgb( src );
  test.identical( got, expected );

  test.case = 'White';
  var src = 'hsl(0, 0%, 0%)';
  var expected = [ 1, 1, 1 ];
  var got = _.color.hslStrToRgb( src );
  test.identical( got, expected );

  test.case = 'White with spaces';
  var src = 'hsl(0 0% 0%)';
  var expected = [ 1, 1, 1 ];
  var got = _.color.hslStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Red';
  var src = 'hsl(0, 100%, 50%)';
  var expected = [ 1, 0, 0 ];
  var got = _.color.hslStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Red with spaces';
  var src = 'hsl(0 100% 50%)';
  var expected = [ 1, 0, 0 ];
  var got = _.color.hslStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Green';
  var src = 'hsl(120, 100%, 50%)';
  var expected = [ 0, 1, 0 ];
  var got = _.color.hslStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Green with spaces';
  var src = 'hsl(120 100% 50%)';
  var expected = [ 0, 1, 0 ];
  var got = _.color.hslStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Blue';
  var src = 'hsl(240, 100%, 50%)';
  var expected = [ 0, 0, 1 ];
  var got = _.color.hslStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Blue with spaces';
  var src = 'hsl(240 100% 50%)';
  var expected = [ 0, 0, 1 ];
  var got = _.color.hslStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Yellow';
  var src = 'hsl(60, 100%, 50%)';
  var expected = [ 1, 1, 0 ];
  var got = _.color.hslStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Yellow with spaces';
  var src = 'hsl(60 100% 50%)';
  var expected = [ 1, 1, 0 ];
  var got = _.color.hslStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Cyan';
  var src = 'hsl(180, 100%, 50%)';
  var expected = [ 0, 1, 1 ];
  var got = _.color.hslStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Cyan with spaces';
  var src = 'hsl(180 100% 50%)';
  var expected = [ 0, 1, 1 ];
  var got = _.color.hslStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Magenta';
  var src = 'hsl(300, 100%, 50%)';
  var expected = [ 1, 0, 1 ];
  var got = _.color.hslStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Magenta with spaces';
  var src = 'hsl(300 100% 50%)';
  var expected = [ 1, 0, 1 ];
  var got = _.color.hslStrToRgb( src );
  test.identical( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = 'hsl(45, 98%, 33%)';
  var src = 'hsl(45, 98%, 33%)';
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.hslStrToRgb( src );
  test.identical( got, expected );

  test.case = 'hsl(45 98% 33%)';
  var src = 'hsl(45 98% 33%)';
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.hslStrToRgb( src );
  test.identical( got, expected );

  test.case = 'hsl(158, 87%, 53%)';
  var src = 'hsl(158, 87%, 53%)';
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588 ];
  var got = _.color.hslStrToRgb( src );
  test.identical( got, expected );

  test.case = 'hsl(158 87% 53%)';
  var src = 'hsl(158 87% 53%)';
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588 ];
  var got = _.color.hslStrToRgb( src );
  test.identical( got, expected );

  test.case = 'hsl(55, 68%, 55%)';
  var src = 'hsl(55, 68%, 55%)';
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981 ];
  var got = _.color.hslStrToRgb( src );
  test.identical( got, expected );

  test.case = 'hsl(55 68% 55%)';
  var src = 'hsl(55 68% 55%)';
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981 ];
  var got = _.color.hslStrToRgb( src );
  test.identical( got, expected );

  test.close( 'non basic colors' );

  test.case = 'first arg > 360';
  var src = 'hsl(366, 88%, 2%)';
  var expected = null;
  var got = _.color.hslStrToRgb( src );
  test.identical( got, expected );

  test.case = 'first arg > 360, with spaces';
  var src = 'hsl(366 88% 2%)';
  var expected = null;
  var got = _.color.hslStrToRgb( src );
  test.identical( got, expected );

  test.case = 'second arg > 100';
  var src = 'hsl(244, 102%, 2%)';
  var expected = null;
  var got = _.color.hslStrToRgb( src );
  test.identical( got, expected );

  test.case = 'second arg > 100, with space';
  var src = 'hsl(244 102% 2%)';
  var expected = null;
  var got = _.color.hslStrToRgb( src );
  test.identical( got, expected );

}

//


function hslaStrToRgba( test )
{

  test.open( 'basic colors' );

  test.case = 'Black';
  var src = 'hsl(0, 0%, 0%, 1)';
  var expected = [ 0, 0, 0, 1 ];
  var got = _.color.hslaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Black with spaces';
  var src = 'hsl(0 0% 0% 1)';
  var expected = [ 0, 0, 0, 1 ];
  var got = _.color.hslaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'White';
  var src = 'hsl(0, 0%, 0%, 1)';
  var expected = [ 1, 1, 1, 1 ];
  var got = _.color.hslaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'White with spaces';
  var src = 'hsl(0 0% 0% 1)';
  var expected = [ 1, 1, 1, 1 ];
  var got = _.color.hslaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Red';
  var src = 'hsl(0, 100%, 50%, 1)';
  var expected = [ 1, 0, 0, 1 ];
  var got = _.color.hslaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Red with spaces';
  var src = 'hsl(0 100% 50% 1)';
  var expected = [ 1, 0, 0, 1 ];
  var got = _.color.hslaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Green';
  var src = 'hsl(120, 100%, 50%, 1)';
  var expected = [ 0, 1, 0, 1 ];
  var got = _.color.hslaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Green with spaces';
  var src = 'hsl(120 100% 50% 1)';
  var expected = [ 0, 1, 0, 1 ];
  var got = _.color.hslaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Blue';
  var src = 'hsl(240, 100%, 50%, 1)';
  var expected = [ 0, 0, 1, 1 ];
  var got = _.color.hslaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Blue with spaces';
  var src = 'hsl(240 100% 50% 1)';
  var expected = [ 0, 0, 1, 1 ];
  var got = _.color.hslaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Yellow';
  var src = 'hsl(60, 100%, 50%, 1)';
  var expected = [ 1, 1, 0, 1 ];
  var got = _.color.hslaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Yellow with spaces';
  var src = 'hsl(60 100% 50% 1)';
  var expected = [ 1, 1, 0, 1 ];
  var got = _.color.hslaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Cyan';
  var src = 'hsl(180, 100%, 50%, 1)';
  var expected = [ 0, 1, 1, 1 ];
  var got = _.color.hslaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Cyan with spaces';
  var src = 'hsl(180 100% 50% 1)';
  var expected = [ 0, 1, 1, 1 ];
  var got = _.color.hslaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Magenta';
  var src = 'hsl(300, 100%, 50%, 1)';
  var expected = [ 1, 0, 1, 1 ];
  var got = _.color.hslaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Magenta with spaces';
  var src = 'hsl(300 100% 50% 1)';
  var expected = [ 1, 0, 1, 1 ];
  var got = _.color.hslaStrToRgba( src );
  test.identical( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = 'hsl(45, 98%, 33%, 0.5)';
  var src = 'hsl(45, 98%, 33%, 0.5)';
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 0.5 ];
  var got = _.color.hslaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'hsl(45 98% 33% 0.5)';
  var src = 'hsl(45 98% 33% 0.5)';
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 0.5 ];
  var got = _.color.hslaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'hsl(158, 87%, 53%, 0.34)';
  var src = 'hsl(158, 87%, 53%, 0.34)';
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588, 0.34 ];
  var got = _.color.hslaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'hsl(158 87% 53% 0.34)';
  var src = 'hsl(158 87% 53% 0.34)';
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588, 0.34 ];
  var got = _.color.hslaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'hsl(55, 68%, 55%, 0.19)';
  var src = 'hsl(55, 68%, 55%, 0.19)';
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981, 0.19 ];
  var got = _.color.hslaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'hsl(55 68% 55% 0.19)';
  var src = 'hsl(55 68% 55% 0.19)';
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981, 0.19 ];
  var got = _.color.hslaStrToRgba( src );
  test.identical( got, expected );

  test.close( 'non basic colors' );

  test.case = 'first arg > 360';
  var src = 'hsl(366, 88%, 2%)';
  var expected = null;
  var got = _.color.hslaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'first arg > 360, with spaces';
  var src = 'hsl(366 88% 2%)';
  var expected = null;
  var got = _.color.hslaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'second arg > 100';
  var src = 'hsl(244, 102%, 2%)';
  var expected = null;
  var got = _.color.hslaStrToRgba( src );
  test.identical( got, expected );

  test.case = 'second arg > 100, with space';
  var src = 'hsl(244 102% 2%)';
  var expected = null;
  var got = _.color.hslaStrToRgba( src );
  test.identical( got, expected );

}

//

function xyzStrToRgb( test )
{

  test.open( 'basic colors' );

  test.case = 'Black';
  var src = 'xyz(0.0000, 0.0000, 0.0000)';
  var expected = [ 0, 0, 0 ];
  var got = _.color.xyzStrToRgb( src );
  test.identical( got, expected );

  test.case = 'White';
  var src = 'xyz(0.9642, 1.0000, 0.8252)';
  var expected = [ 1, 1, 1 ];
  var got = _.color.xyzStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Red';
  var src = 'xyz(0.4361, 0.2225, 0.0139)';
  var expected = [ 1, 0, 0 ];
  var got = _.color.xyzStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Green';
  var src = 'xyz(0.3851, 0.7169, 0.0971)';
  var expected = [ 0, 1, 0 ];
  var got = _.color.xyzStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Blue';
  var src = 'xyz(0.1431, 0.0606, 0.7142)';
  var expected = [ 0, 0, 1 ];
  var got = _.color.xyzStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Yellow';
  var src = 'xyz(0.8211, 0.9394, 0.1110)';
  var expected = [ 1, 1, 0 ];
  var got = _.color.xyzStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Cyan';
  var src = 'xyz(0.5281, 0.7775, 0.8113)';
  var expected = [ 0, 1, 1 ];
  var got = _.color.xyzStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Magenta';
  var src = 'xyz(0.5792, 0.2831, 0.7281)';
  var expected = [ 1, 0, 1 ];
  var got = _.color.xyzStrToRgb( src );
  test.identical( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = 'xyz(0.2382, 0.2246, 0.0248)';
  var src = 'xyz(0.2382, 0.2246, 0.0248)';
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.xyzStrToRgb( src );
  test.identical( got, expected );

  test.case = 'xyz(0.3932, 0.6496, 0.3428)';
  var src = 'xyz(0.3932, 0.6496, 0.3428)';
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588 ];
  var got = _.color.xyzStrToRgb( src );
  test.identical( got, expected );

  test.case = 'xyz(0.5501, 0.6013, 0.1030)';
  var src = 'xyz(0.5501, 0.6013, 0.1030)';
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981 ];
  var got = _.color.xyzStrToRgb( src );
  test.identical( got, expected );

  test.close( 'non basic colors' );

  test.case = 'first arg > 1';
  var src = 'xyz(1.2000, 0.9862, 0.3332)';
  var expected = null;
  var got = _.color.xyzStrToRgb( src );
  test.identical( got, expected );

  test.case = 'second arg > 1';
  var src = 'xyz(0.2000, 1.9862, 0.3332)';
  var expected = null;
  var got = _.color.xyzStrToRgb( src );
  test.identical( got, expected );

}

//

function xyzStrToRgba( test )
{

  test.open( 'basic colors' );

  test.case = 'Black';
  var src = 'xyz(0.0000, 0.0000, 0.0000)';
  var expected = [ 0, 0, 0, 1 ];
  var got = _.color.xyzStrToRgba( src );
  test.identical( got, expected );

  test.case = 'White';
  var src = 'xyz(0.9642, 1.0000, 0.8252)';
  var expected = [ 1, 1, 1, 1 ];
  var got = _.color.xyzStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Red';
  var src = 'xyz(0.4361, 0.2225, 0.0139)'; /* 0.6484, 0.3309, 0.3111 */
  var expected = [ 1, 0, 0, 1 ];
  var got = _.color.xyzStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Green';
  var src = 'xyz(0.3851, 0.7169, 0.0971)';
  var expected = [ 0, 1, 0, 1 ];
  var got = _.color.xyzStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Blue';
  var src = 'xyz(0.1431, 0.0606, 0.7142)';
  var expected = [ 0, 0, 1, 1 ];
  var got = _.color.xyzStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Yellow';
  var src = 'xyz(0.8211, 0.9394, 0.1110)';
  var expected = [ 1, 1, 0, 1 ];
  var got = _.color.xyzStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Cyan';
  var src = 'xyz(0.5281, 0.7775, 0.8113)';
  var expected = [ 0, 1, 1, 1 ];
  var got = _.color.xyzStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Magenta';
  var src = 'xyz(0.5792, 0.2831, 0.7281)';
  var expected = [ 1, 0, 1, 1 ];
  var got = _.color.xyzStrToRgba( src );
  test.identical( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = 'xyz(0.2382, 0.2246, 0.0248)';
  var src = 'xyz(0.2382, 0.2246, 0.0248)';
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 1 ];
  var got = _.color.xyzStrToRgba( src );
  test.identical( got, expected );

  test.case = 'xyz(0.3932, 0.6496, 0.3428)';
  var src = 'xyz(0.3932, 0.6496, 0.3428)';
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588, 1 ];
  var got = _.color.xyzStrToRgba( src );
  test.identical( got, expected );

  test.case = 'xyz(0.5501, 0.6013, 0.1030)';
  var src = 'xyz(0.5501, 0.6013, 0.1030)';
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981, 1 ];
  var got = _.color.xyzStrToRgba( src );
  test.identical( got, expected );

  test.close( 'non basic colors' );

  test.case = 'first arg > 1';
  var src = 'xyz(1.2000, 0.9862, 0.3332)';
  var expected = null;
  var got = _.color.xyzStrToRgba( src );
  test.identical( got, expected );

  test.case = 'second arg > 1';
  var src = 'xyz(0.2000, 1.9862, 0.3332)';
  var expected = null;
  var got = _.color.xyzStrToRgba( src );
  test.identical( got, expected );

}

//

function labStrToRgb( test )
{

  test.open( 'basic colors' );

  test.case = 'Black';
  var src = 'lab(0.00, 0.00, 0.00)';
  var expected = [ 0, 0, 0 ];
  var got = _.color.labStrToRgb( src );
  test.identical( got, expected );

  test.case = 'White';
  var src = 'lab(100.00 0.00 0.00)';
  var expected = [ 1, 1, 1 ];
  var got = _.color.labStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Red';
  var src = 'lab(54.29, 80.81, 69.89)';
  var expected = [ 1, 0, 0 ];
  var got = _.color.labStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Green';
  var src = 'lab(87.82, -79.29, 80.99)';
  var expected = [ 0, 1, 0 ];
  var got = _.color.labStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Blue';
  var src = 'lab(29.57, 68.30, -112.03)';
  var expected = [ 0, 0, 1 ];
  var got = _.color.labStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Yellow';
  var src = 'lab(97.61, -15.75, 93.39)';
  var expected = [ 1, 1, 0 ];
  var got = _.color.labStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Cyan';
  var src = 'lab(90.67, -50.67, -14.96)';
  var expected = [ 0, 1, 1 ];
  var got = _.color.labStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Magenta';
  var src = 'lab(60.17, 93.55, -60.50)';
  var expected = [ 1, 0, 1 ];
  var got = _.color.labStrToRgb( src );
  test.identical( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = 'lab(54.51, 9.81, 59.36)';
  var src = 'lab(54.51, 9.81, 59.36)';
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.labStrToRgb( src );
  test.identical( got, expected );

  test.case = 'lab(84.46, -62.25, 23.98)';
  var src = 'lab(84.46, -62.25, 23.98)';
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588 ];
  var got = _.color.labStrToRgb( src );
  test.identical( got, expected );

  test.case = 'lab(81.91, -7.33, 68.85)';
  var src = 'lab(81.91, -7.33, 68.85)';
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981 ];
  var got = _.color.labStrToRgb( src );
  test.identical( got, expected );

  test.close( 'non basic colors' );

  test.case = 'first arg > 100';
  var src = 'lab(102.35, -7.33, 68.85)';
  var expected = null;
  var got = _.color.labStrToRgb( src );
  test.identical( got, expected );

  test.case = 'second arg > 128';
  var src = 'lab(102.35, 129.34, 68.86)';
  var expected = null;
  var got = _.color.labStrToRgb( src );
  test.identical( got, expected );

}

//

function labStrToRgba( test )
{

  test.open( 'basic colors' );

  test.case = 'Black';
  var src = 'lab(0.00, 0.00, 0.00)';
  var expected = [ 0, 0, 0, 1 ];
  var got = _.color.labStrToRgba( src );
  test.identical( got, expected );

  test.case = 'White';
  var src = 'lab(100.00, 0.00, 0.00)';
  var expected = [ 1, 1, 1, 1 ];
  var got = _.color.labStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Red';
  var src = 'lab(54.29, 80.81, 69.89)';
  var expected = [ 1, 0, 0, 1 ];
  var got = _.color.labStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Green';
  var src = 'lab(87.82, -79.29, 80.99)';
  var expected = [ 0, 1, 0, 1 ];
  var got = _.color.labStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Blue';
  var src = 'lab(29.57, 68.30, -112.03)';
  var expected = [ 0, 0, 1, 1 ];
  var got = _.color.labStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Yellow';
  var src = 'lab(97.61, -15.75, 93.39)';
  var expected = [ 1, 1, 0, 1 ];
  var got = _.color.labStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Cyan';
  var src = 'lab(90.67, -50.67, -14.96)';
  var expected = [ 0, 1, 1, 1 ];
  var got = _.color.labStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Magenta';
  var src = 'lab(60.17, 93.55, -60.50)';
  var expected = [ 1, 0, 1, 1 ];
  var got = _.color.labStrToRgba( src );
  test.identical( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = 'lab(54.51, 9.81, 59.36)';
  var src = 'lab(54.51, 9.81, 59.36)';
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 1 ];
  var got = _.color.labStrToRgba( src );
  test.identical( got, expected );

  test.case = 'lab(84.46, -62.25, 23.98)';
  var src = 'lab(84.46, -62.25, 23.98)';
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588, 1 ];
  var got = _.color.labStrToRgba( src );
  test.identical( got, expected );

  test.case = 'lab(81.91, -7.33, 68.85)';
  var src = 'lab(81.91, -7.33, 68.85)';
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981 , 1 ];
  var got = _.color.labStrToRgba( src );
  test.identical( got, expected );

  test.close( 'non basic colors' );

}

//

function lchStrToRgb( test )
{

  test.open( 'basic colors' );

  test.case = 'Black';
  var src = 'lch(0, 0.000, 0.000)';
  var expected = [ 0, 0, 0 ];
  var got = _.color.lchStrToRgb( src );
  test.identical( got, expected );

  test.case = 'White';
  var src = 'lch((100.000, 0.000, 338.199)';
  var expected = [ 1, 1, 1 ];
  var got = _.color.lchStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Red';
  var src = 'lch(53, 104.576, 40.000)';
  var expected = [ 1, 0, 0 ];
  var got = _.color.lchStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Green';
  var src = 'lch(88, 119.779, 136.016)';
  var expected = [ 0, 1, 0 ];
  var got = _.color.lchStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Blue';
  var src = 'lch(32, 133.816, 306.287)';
  var expected = [ 0, 0, 1 ];
  var got = _.color.lchStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Yellow';
  var src = 'lch(97, 96.910, 102.852)';
  var expected = [ 1, 1, 0 ];
  var got = _.color.lchStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Cyan';
  var src = 'lch(91, 50.115, 196.386)';
  var expected = [ 0, 1, 1 ];
  var got = _.color.lchStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Magenta';
  var src = 'lch(60, 115.567, 328.233)';
  var expected = [ 1, 0, 1 ];
  var got = _.color.lchStrToRgb( src );
  test.identical( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = 'lch(54, 59.930, 83.548)';
  var src = 'lch(54, 59.930, 83.548)';
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.lchStrToRgb( src );
  test.identical( got, expected );

  test.case = 'lch(85, 69.053, 159.007)';
  var src = 'lch(85, 69.053, 159.007)';
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588 ];
  var got = _.color.lchStrToRgb( src );
  test.identical( got, expected );

  test.case = 'lch(82, 70.255, 99.657)';
  var src = 'lch(82, 70.255, 99.657)';
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981 ];
  var got = _.color.lchStrToRgb( src );
  test.identical( got, expected );

  test.close( 'non basic colors' );

  test.case = 'first arg > 100';
  var src = 'lch(102.35, 70.33, 68.85)';
  var expected = null;
  var got = _.color.lchStrToRgb( src );
  test.identical( got, expected );

}

//

function lchStrToRgba( test )
{

  test.open( 'basic colors' );

  test.case = 'Black';
  var src = 'lch(0, 0.000, 0.000)';
  var expected = [ 0, 0, 0, 1 ];
  var got = _.color.lchStrToRgba( src );
  test.identical( got, expected );

  test.case = 'White';
  var src = 'lch(100.000, 0.000, 338.199)';
  var expected = [ 1, 1, 1, 1 ];
  var got = _.color.lchStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Red';
  var src = 'lch(53, 104.576, 40.000)';
  var expected = [ 1, 0, 0, 1 ];
  var got = _.color.lchStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Green';
  var src = 'lch(88, 119.779, 136.016)';
  var expected = [ 0, 1, 0, 1 ];
  var got = _.color.lchStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Blue';
  var src = 'lch(32, 133.816, 306.287)';
  var expected = [ 0, 0, 1, 1 ];
  var got = _.color.lchStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Yellow';
  var src = 'lch(97, 96.910, 102.852)';
  var expected = [ 1, 1, 0, 1 ];
  var got = _.color.lchStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Cyan';
  var src = 'lch(91, 50.115, 196.386)';
  var expected = [ 0, 1, 1, 1 ];
  var got = _.color.lchStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Magenta';
  var src = 'lch(60, 115.567, 328.233)';
  var expected = [ 1, 0, 1, 1 ];
  var got = _.color.lchStrToRgba( src );
  test.identical( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = 'lch(54, 59.930, 83.548)';
  var src = 'lch(54, 59.930, 83.548)';
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 1 ];
  var got = _.color.lchStrToRgba( src );
  test.identical( got, expected );

  test.case = 'lch(85, 69.053, 159.007)';
  var src = 'lch(85, 69.053, 159.007)';
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588, 1 ];
  var got = _.color.lchStrToRgba( src );
  test.identical( got, expected );

  test.case = 'lch(82, 70.255, 99.657)';
  var src = 'lch(82, 70.255, 99.657)';
  var expected = [ 20.8549019607843137, 0.807843137254902, 0.23921568627450981, 1 ];
  var got = _.color.lchStrToRgba( src );
  test.identical( got, expected );

  test.close( 'non basic colors' );

  test.case = 'first arg > 100';
  var src = 'lch(102.35, 70.33, 68.85)';
  var expected = null;
  var got = _.color.lchStrToRgba( src );
  test.identical( got, expected );

}

//

function luvStrToRgb( test )
{

  test.open( 'basic colors' );

  test.case = 'Black';
  var src = 'luv(0, 0, 0)';
  var expected = [ 0, 0, 0 ];
  var got = _.color.luvStrToRgb( src );
  test.identical( got, expected );

  test.case = 'White';
  var src = 'luv(100.000, 0.000, -0.000)';
  var expected = [ 1, 1, 1 ];
  var got = _.color.luvStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Red';
  var src = 'luv(61.427, 201.926, 43.562)';
  var expected = [ 1, 0, 0 ];
  var got = _.color.luvStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Green';
  var src = 'luv(83.303, -132.296, 116.242)';
  var expected = [ 0, 1, 0 ];
  var got = _.color.luvStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Blue';
  var src = 'luv(32.979, -9.604, -133.093)';
  var expected = [ 0, 0, 1 ];
  var got = _.color.luvStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Yellow';
  var src = 'luv(97.013, 8.121, 112.544)';
  var expected = [ 1, 1, 0 ];
  var got = _.color.luvStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Cyan';
  var src = 'luv(87.125, -103.979, -22.432)';
  var expected = [ 0, 1, 1 ];
  var got = _.color.luvStrToRgb( src );
  test.identical( got, expected );

  test.case = 'Magenta';
  var src = 'luv(67.475, 111.701, -98.146)';
  var expected = [ 1, 0, 1 ];
  var got = _.color.luvStrToRgb( src );
  test.identical( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = 'luv(55.975, 46.348, 59.064)';
  var src = 'luv(55.975, 46.348, 59.064)';
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.luvStrToRgb( src );
  test.identical( got, expected );

  test.case = 'luv(80.721, -110.068, 44.474)';
  var src = 'luv(80.721, -110.068, 44.474)';
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588 ];
  var got = _.color.luvStrToRgb( src );
  test.identical( got, expected );

  test.case = 'luv(82.178, 17.545, 85.824)';
  var src = 'luv(82.178, 17.545, 85.824)';
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981 ];
  var got = _.color.luvStrToRgb( src );
  test.identical( got, expected );

  test.close( 'non basic colors' );

  test.case = 'first arg > 100';
  var src = 'luv(102.35, 70.33, 68.85)';
  var expected = null;
  var got = _.color.luvStrToRgb( src );
  test.identical( got, expected );

  test.case = 'second arg > 224';
  var src = 'luv(98.35, 225.33, 68.85)';
  var expected = null;
  var got = _.color.luvStrToRgb( src );
  test.identical( got, expected );

  test.case = 'third arg > 122';
  var src = 'luv(98.35, 66.33, 123.85)';
  var expected = null;
  var got = _.color.luvStrToRgb( src );
  test.identical( got, expected );

}

//

function luvStrToRgba( test )
{

  test.open( 'basic colors' );

  test.case = 'Black';
  var src = 'luv(0, 0, 0)';
  var expected = [ 0, 0, 0, 1 ];
  var got = _.color.luvStrToRgba( src );
  test.identical( got, expected );

  test.case = 'White';
  var src = 'luv(100.000, 0.000, -0.000)';
  var expected = [ 1, 1, 1, 1 ];
  var got = _.color.luvStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Red';
  var src = 'luv(61.427, 201.926, 43.562)';
  var expected = [ 1, 0, 0, 1 ];
  var got = _.color.luvStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Green';
  var src = 'luv(83.303, -132.296, 116.242)';
  var expected = [ 0, 1, 0, 1 ];
  var got = _.color.luvStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Blue';
  var src = 'luv(32.979, -9.604, -133.093)';
  var expected = [ 0, 0, 1, 1 ];
  var got = _.color.luvStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Yellow';
  var src = 'luv(97.013, 8.121, 112.544)';
  var expected = [ 1, 1, 0, 1 ];
  var got = _.color.luvStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Cyan';
  var src = 'luv(87.125, -103.979, -22.432)';
  var expected = [ 0, 1, 1, 1 ];
  var got = _.color.luvStrToRgba( src );
  test.identical( got, expected );

  test.case = 'Magenta';
  var src = 'luv(67.475, 111.701, -98.146)';
  var expected = [ 1, 0, 1, 1 ];
  var got = _.color.luvStrToRgba( src );
  test.identical( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = 'luv(55.975, 46.348, 59.064)';
  var src = 'luv(55.975, 46.348, 59.064)';
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 1 ];
  var got = _.color.luvStrToRgba( src );
  test.identical( got, expected );

  test.case = 'luv(80.721, -110.068, 44.474)';
  var src = 'luv(80.721, -110.068, 44.474)';
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588, 1 ];
  var got = _.color.luvStrToRgba( src );
  test.identical( got, expected );

  test.case = 'luv(82.178, 17.545, 85.824)';
  var src = 'luv(82.178, 17.545, 85.824)';
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981, 1 ];
  var got = _.color.luvStrToRgba( src );
  test.identical( got, expected );

  test.close( 'non basic colors' );

  test.case = 'first arg > 100';
  var src = 'luv(102.35, 70.33, 68.85)';
  var expected = null;
  var got = _.color.luvStrToRgba( src );
  test.identical( got, expected );

  test.case = 'second arg > 224';
  var src = 'luv(98.35, 225.33, 68.85)';
  var expected = null;
  var got = _.color.luvStrToRgba( src );
  test.identical( got, expected );

  test.case = 'third arg > 122';
  var src = 'luv(98.35, 66.33, 123.85)';
  var expected = null;
  var got = _.color.luvStrToRgba( src );
  test.identical( got, expected );

}


// --
// declare
// --

let Self =
{

  name : 'Tools/mid/Color',
  silencing : 1,

  tests :
  {

    colorNameNearest,

    colorToHex,
    hexToColor,
    colorToRgbHtml,
    colorToRgbaHtml,
    rgbByBitmask,
    rgbaFrom,
    rgbFrom,
    rgbaHtmlFrom,

    cmykStrToRgb,
    cmykStrToRgba,
    cmykStructureStrToRgb,
    cmykStructureStrToRgba,
    hwbStrToRgb,
    hwbStrToRgba,
    hexStrToRgb,
    hexStrToRgba,
    rgbStrToRgb,
    rgbaStrToRgba,
    rgbStructureStrToRgb,
    hslStrToRgb,
    hslaStrToRgba,
    xyzStrToRgb,
    xyzStrToRgba,
    labStrToRgb,
    labStrToRgba,
    lchStrToRgb,
    lchStrToRgba,
    luvStrToRgb,
    luvStrToRgba,

  },

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
