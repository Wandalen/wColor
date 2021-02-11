( function _Color_test_s_( )
{

'use strict';

if( typeof module !== 'undefined' )
{
  let _ = require( '../../../wtools/Tools.s' );
  require( '../color/entry/ColorBasic.s' );
  _.include( 'wTesting' );
  _.include( 'wMathVector' );
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

function _cmykStrToRgb( test )
{

  test.open( 'basic colors' );

  test.case = 'Black';
  var src = 'cmyk(0%,0%,0%,100%)';
  var expected = [ 0, 0, 0 ];
  var got = _.color.cmyk._strToRgb( null, src );
  test.identical( got, expected );

  test.case = 'White';
  var src = 'cmyk(0%,0%,0%,0%)';
  var expected = [ 1, 1, 1 ];
  var got = _.color.cmyk._strToRgb( null, src );
  test.identical( got, expected );

  test.case = 'Red';
  var src = 'cmyk(0%,100%,100%,0%)';
  var expected = [ 1, 0, 0 ];
  var got = _.color.cmyk._strToRgb( null, src );
  test.identical( got, expected );

  test.case = 'Green';
  var src = 'cmyk(100%,0%,100%,0%)';
  var expected = [ 0, 1, 0 ];
  var got = _.color.cmyk._strToRgb( null, src );
  test.identical( got, expected );

  test.case = 'Blue';
  var src = 'cmyk(100%,100%,0%,0%)';
  var expected = [ 0, 0, 1 ];
  var got = _.color.cmyk._strToRgb( null, src );
  test.identical( got, expected );

  test.case = 'Yellow';
  var src = 'cmyk(0%,0%,100%,0%)';
  var expected = [ 1, 1, 0 ];
  var got = _.color.cmyk._strToRgb( null, src );
  test.identical( got, expected );

  test.case = 'Cyan';
  var src = 'cmyk(100%,0%,0%,0%)';
  var expected = [ 0, 1, 1 ];
  var got = _.color.cmyk._strToRgb( null, src );
  test.identical( got, expected );

  test.case = 'Magenta';
  var src = 'cmyk(0%,100%,0%,0%)';
  var expected = [ 1, 0, 1 ];
  var got = _.color.cmyk._strToRgb( null, src );
  test.identical( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = 'cmyk(12%,34%,99%,27%)';
  var src = 'cmyk(12%,34%,99%,27%)';
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.cmyk._strToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'cmyk(87%,1%,33%,5%)';
  var src = 'cmyk(87%,1%,33%,5%)';
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588 ];
  var got = _.color.cmyk._strToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'cmyk(11%,16%,75%,4%)';
  var src = 'cmyk(11%,16%,75%,4%)';
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981 ];
  var got = _.color.cmyk._strToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'cmyk with alpha=100%';
  var src = 'cmyk(11%,16%,75%,4%,100%)';
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981 ];
  var got = _.color.cmyk._strToRgb( null, src );
  test.equivalent( got, expected );

  test.close( 'non basic colors' );

  test.case = 'first arg > 100%';
  var src = 'cmyk(111%,16%,75%,4%)';
  var expected = null;
  var got = _.color.cmyk._strToRgb( null, src );
  test.identical( got, expected );

  test.case = 'second arg > 100%';
  var src = 'cmyk(11%,160%,75%,4%)';
  var expected = null;
  var got = _.color.cmyk._strToRgb( null, src );
  test.identical( got, expected );

  test.case = 'third arg > 100%';
  var src = 'cmyk(11%,16%,750%,4%)';
  var expected = null;
  var got = _.color.cmyk._strToRgb( null, src );
  test.identical( got, expected );

  test.case = 'fourth arg > 100%';
  var src = 'cmyk(11%,16%,75%,400%)';
  var expected = null;
  var got = _.color.cmyk._strToRgb( null, src );
  test.identical( got, expected );

  /* */

  test.case = 'alpha !== 100%';
  var src = 'cmyk(11%,16%,75%,40%,50%)';
  test.shouldThrowErrorSync( () => _.color.cmyk._strToRgb( null, src ) )

}

_cmykStrToRgb.accuracy = 1e-2;

//

function _cmykaStrToRgba( test )
{

  test.open( 'basic colors' );

  test.case = 'Black';
  var src = 'cmyka(0%,0%,0%,100%,100%)';
  var expected = [ 0, 0, 0, 1 ];
  var got = _.color.cmyka._strToRgba( null, src );
  test.identical( got, expected );

  test.case = 'White';
  var src = 'cmyka(0%,0%,0%,0%,100%)';
  var expected = [ 1, 1, 1, 1 ];
  var got = _.color.cmyka._strToRgba( null, src );
  test.identical( got, expected );

  test.case = 'Red';
  var src = 'cmyka(0%,100%,100%,0%,100%)';
  var expected = [ 1, 0, 0, 1 ];
  var got = _.color.cmyka._strToRgba( null, src );
  test.identical( got, expected );

  test.case = 'Green';
  var src = 'cmyka(100%,0%,100%,0%,100%)';
  var expected = [ 0, 1, 0, 1 ];
  var got = _.color.cmyka._strToRgba( null, src );
  test.identical( got, expected );

  test.case = 'Blue';
  var src = 'cmyka(100%,100%,0%,0%,100%)';
  var expected = [ 0, 0, 1, 1 ];
  var got = _.color.cmyka._strToRgba( null, src );
  test.identical( got, expected );

  test.case = 'Yellow';
  var src = 'cmyka(0%,0%,100%,0%,100%)';
  var expected = [ 1, 1, 0, 1 ];
  var got = _.color.cmyka._strToRgba( null, src );
  test.identical( got, expected );

  test.case = 'Cyan';
  var src = 'cmyka(100%,0%,0%,0%,100%)';
  var expected = [ 0, 1, 1, 1 ];
  var got = _.color.cmyka._strToRgba( null, src );
  test.identical( got, expected );

  test.case = 'Magenta';
  var src = 'cmyka(0%,100%,0%,0%,100%)';
  var expected = [ 1, 0, 1, 1 ];
  var got = _.color.cmyka._strToRgba( null, src );
  test.identical( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = 'cmyka(12%,34%,99%,27%,40%)';
  var src = 'cmyka(12%,34%,99%,27%,40%)';
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 0.4 ];
  var got = _.color.cmyka._strToRgba( null, src );
  test.equivalent( got, expected );

  test.case = 'cmyka(87%,1%,33%,5%,34%)';
  var src = 'cmyka(87%,1%,33%,5%,34%)';
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588, 0.34 ];
  var got = _.color.cmyka._strToRgba( null, src );
  test.equivalent( got, expected );

  test.case = 'cmyka(11%,16%,75%,4%,5%)';
  var src = 'cmyka(11%,16%,75%,4%,5%)';
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981, 0.05 ];
  var got = _.color.cmyka._strToRgba( null, src );
  test.equivalent( got, expected );

  test.case = 'cmyka(11%,16%,75%,4%) no alpha info';
  var src = 'cmyka(11%,16%,75%,4%)';
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981, 1 ];
  var got = _.color.cmyka._strToRgba( null, src );
  test.equivalent( got, expected );

  test.close( 'non basic colors' );

  test.case = 'first arg > 100%';
  var src = 'cmyka(111%,16%,75%,4%,5%)';
  var expected = null;
  var got = _.color.cmyka._strToRgba( null, src );
  test.identical( got, expected );

  test.case = 'second arg > 100%';
  var src = 'cmyka(11%,160%,75%,4%,5%)';
  var expected = null;
  var got = _.color.cmyka._strToRgba( null, src );
  test.identical( got, expected );

  test.case = 'third arg > 100%';
  var src = 'cmyka(11%,16%,750%,4%,5%)';
  var expected = null;
  var got = _.color.cmyka._strToRgba( null, src );
  test.identical( got, expected );

  test.case = 'fourth arg > 100%';
  var src = 'cmyka(11%,16%,75%,400%,5%)';
  var expected = null;
  var got = _.color.cmyka._strToRgba( null, src );
  test.identical( got, expected );

  test.case = 'fifth arg > 100%';
  var src = 'cmyka(11%,16%,75%,40%,500%)';
  var expected = null;
  var got = _.color.cmyka._strToRgba( null, src );
  test.identical( got, expected );

}

_cmykaStrToRgba.accuracy = 1e-2;

//

function _cmykStrToRgbWithDst( test )
{

  test.open( 'basic colors' );

  test.case = 'Black, dst = Array';
  var src = 'cmyk(0%,0%,0%,100%)';
  var dst = [ 1, 2, 3 ];
  var expected = [ 0, 0, 0 ];
  var got = _.color.cmyk._strToRgb( dst, src );
  test.identical( got, expected );
  test.true( got === dst );

  test.case = 'Green, dst = Long';
  var src = 'cmyk(100%,0%,100%,0%)';
  var dst = _.longFrom([ 1, 4, 13 ]);
  var expected = [ 0, 1, 0 ];
  var got = _.color.cmyk._strToRgb( dst, src );
  test.identical( got, expected );
  test.true( got === dst );

  test.case = 'Red, dst = TypedArray';
  var src = 'cmyk(0%,100%,100%,0%)';
  var dst = new I8x([ 1, 5, 15 ]); /* 1 and 0 -> Integer Typed Array can be used */
  var expected = [ 1, 0, 0 ];
  var got = _.color.cmyk._strToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.identical( got[ i ], expected[ i ] );
  test.true( got === dst );

  test.case = 'White, dst = VectorAdapter';
  var src = 'cmyk(0%,0%,0%,0%)';
  var dst = _.vad.fromLong([ 1, 2, 3 ]);
  var expected = [ 1, 1, 1 ];
  var got = _.color.cmyk._strToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = 'cmyk(12%,34%,99%,27%), dst = Array';
  var src = 'cmyk(12%,34%,99%,27%)';
  var dst = [ 1, 2, 3 ];
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.cmyk._strToRgb( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = 'cmyk(12%,34%,99%,27%), dst = Long';
  var src = 'cmyk(12%,34%,99%,27%)';
  var dst = _.longFrom([ 1, 2, 3 ]);
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.cmyk._strToRgb( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = 'cmyk(12%,34%,99%,27%), dst = TypedArray';
  var src = 'cmyk(12%,34%,99%,27%)';
  var dst = new Float32Array([ 1, 2, 3 ]); /* ( 0, 1 ) -> Integer Typed Array can NOT be used */
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.cmyk._strToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got[ i ], expected[ i ] );
  test.true( got === dst );

  test.case = 'cmyk(12%,34%,99%,27%), dst = VectorAdapter';
  var src = 'cmyk(12%,34%,99%,27%)';
  var dst = _.vad.fromLong([ 1, 2, 3 ]);
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.cmyk._strToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.case = 'cmyk with alpha = 100, dst = Long';
  var src = 'cmyk(12%,34%,99%,27%,100%)';
  var dst = _.longFrom([ 1, 2, 3 ]);
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.cmyk._strToRgb( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = 'cmyk with alpha, dst = VectorAdapter';
  var src = 'cmyk(12%,34%,99%,27%,100%)';
  var dst = _.vad.fromLong([ 1, 2, 3 ]);
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.cmyk._strToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.close( 'non basic colors' );

  test.case = 'first arg > 100%';
  var src = 'cmyk(111%,16%,75%,4%)';
  var expected = null;
  var got = _.color.cmyk._strToRgb( [ 1, 2, 3 ], src );
  test.identical( got, expected );

  test.case = 'second arg > 100%';
  var src = 'cmyk(11%,160%,75%,4%)';
  var expected = null;
  var got = _.color.cmyk._strToRgb( [ 1, 2, 3 ], src );
  test.identical( got, expected );

  test.case = 'third arg > 100%';
  var src = 'cmyk(11%,16%,750%,4%)';
  var expected = null;
  var got = _.color.cmyk._strToRgb( [ 1, 2, 3 ], src );
  test.identical( got, expected );

  test.case = 'fourth arg > 100%';
  var src = 'cmyk(11%,16%,75%,400%)';
  var expected = null;
  var got = _.color.cmyk._strToRgb( [ 1, 2, 3 ], src );
  test.identical( got, expected );

  /* - */

  test.case = 'dst : Array; dst.length !== 3';
  var src = 'cmyk(12%,34%,99%,27%)';
  var dst = [ 1, 2, 3, 5 ];
  test.shouldThrowErrorSync( () => _.color.cmyk._strToRgb( dst, src ) )

  test.case = 'dst : Long; dst.length !== 3';
  var src = 'cmyk(12%,34%,99%,27%)';
  var dst = _.longFrom([ 1, 2 ]);
  test.shouldThrowErrorSync( () => _.color.cmyk._strToRgb( dst, src ) )

  test.case = 'dst : TypedArray; dst.length !== 3';
  var src = 'cmyk(12%,34%,99%,27%)';
  var dst = new Float32Array([ 1, 2, 3, 4, 5, 6 ]);
  test.shouldThrowErrorSync( () => _.color.cmyk._strToRgb( dst, src ) )

  test.case = 'dst : VectorAdapter; dst.length !== 3';
  var src = 'cmyk(12%,34%,99%,27%)';
  var dst = _.vad.fromLong([ 1 ]);
  test.shouldThrowErrorSync( () => _.color.cmyk._strToRgb( dst, src ) )

  test.case = 'dst : Long; alpha !== 100';
  var src = 'cmyk(12%,34%,99%,27%,22%)';
  var dst = _.longFrom([ 1, 2, 3 ]);
  test.shouldThrowErrorSync( () => _.color.cmyk._strToRgb( dst, src ) )

  test.case = 'dst : VectorAdapter; alpha !== 100';
  var src = 'cmyk(12%,34%,99%,27%,22%)';
  var dst = _.vad.fromLong([ 1, 2, 3 ]);
  test.shouldThrowErrorSync( () => _.color.cmyk._strToRgb( dst, src ) )

}

_cmykStrToRgbWithDst.accuracy = 1e-2;

//

function _cmykaStrToRgbaWithDst( test )
{

  test.open( 'basic colors' );

  test.case = 'Black, dst = Array';
  var src = 'cmyka(0%,0%,0%,100%,100%)';
  var dst = [ 1, 2, 3, 4 ];
  var expected = [ 0, 0, 0, 1 ];
  var got = _.color.cmyka._strToRgba( dst, src );
  test.identical( got, expected );
  test.true( got === dst );

  test.case = 'Green, dst = Long';
  var src = 'cmyka(100%,0%,100%,0%,100%)';
  var dst = _.longFrom([ 1, 4, 13, 14 ]);
  var expected = [ 0, 1, 0, 1 ];
  var got = _.color.cmyka._strToRgba( dst, src );
  test.identical( got, expected );
  test.true( got === dst );

  test.case = 'Red, dst = TypedArray';
  var src = 'cmyka(0%,100%,100%,0%,100%)';
  var dst = new I8x([ 1, 5, 15, 14 ]); /* 1 and 0 -> Integer Typed Array can be used */
  var expected = [ 1, 0, 0, 1 ];
  var got = _.color.cmyka._strToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.identical( got[ i ], expected[ i ] );
  test.true( got === dst );

  test.case = 'White, dst = VectorAdapter';
  var src = 'cmyka(0%,0%,0%,0%,100%)';
  var dst = _.vad.fromLong([ 1, 2, 3, 4 ]);
  var expected = [ 1, 1, 1, 1 ];
  var got = _.color.cmyka._strToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = 'cmyka(12%,34%,99%,27%,31%), dst = Array';
  var src = 'cmyka(12%,34%,99%,27%,31%)';
  var dst = [ 1, 2, 3, 4 ];
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 0.31 ];
  var got = _.color.cmyka._strToRgba( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = 'cmyka(12%,34%,99%,27%,31%), dst = Long';
  var src = 'cmyka(12%,34%,99%,27%,31%)';
  var dst = _.longFrom([ 1, 2, 3, 4 ]);
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 0.31 ];
  var got = _.color.cmyka._strToRgba( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = 'cmyka(12%,34%,99%,27%,31%), dst = TypedArray';
  var src = 'cmyka(12%,34%,99%,27%,31%)';
  var dst = new Float32Array([ 1, 2, 3, 4 ]); /* ( 0, 1 ) -> Integer Typed Array can NOT be used */
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 0.31 ];
  var got = _.color.cmyka._strToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got[ i ], expected[ i ] );
  test.true( got === dst );

  test.case = 'cmyka(12%,34%,99%,27%,31%), dst = VectorAdapter';
  var src = 'cmyka(12%,34%,99%,27%,31%)';
  var dst = _.vad.fromLong([ 1, 2, 3, 4 ]);
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 0.31 ];
  var got = _.color.cmyka._strToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.case = 'cmyka(12%,34%,99%,27%) no alpha info, dst = Array';
  var src = 'cmyka(12%,34%,99%,27%)';
  var dst = [ 1, 2, 3, 4 ];
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 1 ];
  var got = _.color.cmyka._strToRgba( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = 'cmyka(12%,34%,99%,27%) no alpha info, dst = VectorAdapter';
  var src = 'cmyka(12%,34%,99%,27%)';
  var dst = _.vad.fromLong([ 1, 2, 3, 4 ]);
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 1 ];
  var got = _.color.cmyka._strToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.close( 'non basic colors' );

  test.case = 'first arg > 100%';
  var src = 'cmyka(111%,16%,75%,4%,31%)';
  var expected = null;
  var got = _.color.cmyka._strToRgba( [ 1, 2, 3, 4 ], src );
  test.identical( got, expected );

  test.case = 'second arg > 100%';
  var src = 'cmyka(11%,160%,75%,4%,31%)';
  var expected = null;
  var got = _.color.cmyka._strToRgba( [ 1, 2, 3 ], src );
  test.identical( got, expected );

  test.case = 'third arg > 100%';
  var src = 'cmyka(11%,16%,750%,4%,31%)';
  var expected = null;
  var got = _.color.cmyka._strToRgba( [ 1, 2, 3 ], src );
  test.identical( got, expected );

  test.case = 'fourth arg > 100%';
  var src = 'cmyka(11%,16%,75%,400%,31%)';
  var expected = null;
  var got = _.color.cmyka._strToRgba( [ 1, 2, 3 ], src );
  test.identical( got, expected );

  /* - */

  test.case = 'dst : Array; dst.length !== 4';
  var src = 'cmyka(12%,34%,99%,27%,31%)';
  var dst = [ 1, 2, 3, 5, 6 ];
  test.shouldThrowErrorSync( () => _.color.cmyka._strToRgba( dst, src ) )

  test.case = 'dst : Long; dst.length !== 4';
  var src = 'cmyka(12%,34%,99%,27%,31%)';
  var dst = _.longFrom([ 1, 2 ]);
  test.shouldThrowErrorSync( () => _.color.cmyka._strToRgba( dst, src ) )

  test.case = 'dst : TypedArray; dst.length !== 4';
  var src = 'cmyka(12%,34%,99%,27%,31%)';
  var dst = new Float32Array([ 1, 2, 3 ]);
  test.shouldThrowErrorSync( () => _.color.cmyka._strToRgba( dst, src ) )

  test.case = 'dst : VectorAdapter; dst.length !== 4';
  var src = 'cmyka(12%,34%,99%,27%,31%)';
  var dst = _.vad.fromLong([ 1 ]);
  test.shouldThrowErrorSync( () => _.color.cmyka._strToRgba( dst, src ) )

}

_cmykaStrToRgbaWithDst.accuracy = 1e-2;

//

function _cmykLongToRgb( test )
{

  test.open( 'basic colors' );

  test.case = 'Black';
  var src = [ 0, 0, 0, 100 ];
  var expected = [ 0, 0, 0 ];
  var got = _.color.cmyk._longToRgb( null, src );
  test.identical( got, expected );

  test.case = 'White';
  var src = [ 0, 0, 0, 0 ];
  var expected = [ 1, 1, 1 ];
  var got = _.color.cmyk._longToRgb( null, src );
  test.identical( got, expected );

  test.case = 'Red';
  var src = [ 0, 100, 100, 0 ];
  var expected = [ 1, 0, 0 ];
  var got = _.color.cmyk._longToRgb( null, src );
  test.identical( got, expected );

  test.case = 'Green';
  var src = [ 100, 0, 100, 0 ];
  var expected = [ 0, 1, 0 ];
  var got = _.color.cmyk._longToRgb( null, src );
  test.identical( got, expected );

  test.case = 'Blue';
  var src = [ 100, 100, 0, 0 ];
  var expected = [ 0, 0, 1 ];
  var got = _.color.cmyk._longToRgb( null, src );
  test.identical( got, expected );

  test.case = 'Yellow';
  var src = [ 0, 0, 100, 0 ];
  var expected = [ 1, 1, 0 ];
  var got = _.color.cmyk._longToRgb( null, src );
  test.identical( got, expected );

  test.case = 'Cyan';
  var src = [ 100, 0, 0, 0 ];
  var expected = [ 0, 1, 1 ];
  var got = _.color.cmyk._longToRgb( null, src );
  test.identical( got, expected );

  test.case = 'Magenta';
  var src = [ 0, 100, 0, 0 ];
  var expected = [ 1, 0, 1 ];
  var got = _.color.cmyk._longToRgb( null, src );
  test.identical( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = '[ 12, 34, 99, 27 ]';
  var src = [ 12, 34, 99, 27 ];
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.cmyk._longToRgb( null, src );
  test.equivalent( got, expected );

  test.case = '[ 87, 1, 33, 5 ]';
  var src = [ 87, 1, 33, 5 ];
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588 ];
  var got = _.color.cmyk._longToRgb( null, src );
  test.equivalent( got, expected );

  test.case = '[ 11, 16, 75, 4 ]';
  var src = [ 11, 16, 75, 4 ];
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981 ];
  var got = _.color.cmyk._longToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'cmyk with alpha=100%';
  var src = [ 11, 16, 75, 4, 100 ];
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981 ];
  var got = _.color.cmyk._longToRgb( null, src );
  test.equivalent( got, expected );

  test.close( 'non basic colors' );

  test.case = 'first arg > 100%';
  var src = [ 111, 16, 75, 4 ];
  var expected = null;
  var got = _.color.cmyk._longToRgb( null, src );
  test.identical( got, expected );

  test.case = 'second arg > 100%';
  var src = [ 11, 160, 75, 4 ];
  var expected = null;
  var got = _.color.cmyk._longToRgb( null, src );
  test.identical( got, expected );

  test.case = 'third arg > 100%';
  var src = [ 11, 16, 750, 4 ];
  var expected = null;
  var got = _.color.cmyk._longToRgb( null, src );
  test.identical( got, expected );

  test.case = 'fourth arg > 100%';
  var src = [ 11, 16, 75, 400 ];
  var expected = null;
  var got = _.color.cmyk._longToRgb( null, src );
  test.identical( got, expected );

  /* */

  test.case = 'alpha !== 100%';
  var src = [ 11, 16, 75, 40, 50 ];
  test.shouldThrowErrorSync( () => _.color.cmyk._longToRgb( null, src ) )

}

_cmykLongToRgb.accuracy = 1e-2;

//
function _cmykaLongToRgba( test )
{

  test.open( 'basic colors' );

  test.case = 'Black';
  var src = [ 0, 0, 0, 100, 100 ];
  var expected = [ 0, 0, 0, 1 ];
  var got = _.color.cmyka._longToRgba( null, src );
  test.identical( got, expected );

  test.case = 'White';
  var src = [ 0, 0, 0, 0, 100 ];
  var expected = [ 1, 1, 1, 1 ];
  var got = _.color.cmyka._longToRgba( null, src );
  test.identical( got, expected );

  test.case = 'Red';
  var src = [ 0, 100, 100, 0, 100 ];
  var expected = [ 1, 0, 0, 1 ];
  var got = _.color.cmyka._longToRgba( null, src );
  test.identical( got, expected );

  test.case = 'Green';
  var src = [ 100, 0, 100, 0, 100 ];
  var expected = [ 0, 1, 0, 1 ];
  var got = _.color.cmyka._longToRgba( null, src );
  test.identical( got, expected );

  test.case = 'Blue';
  var src = [ 100, 100, 0, 0, 100 ];
  var expected = [ 0, 0, 1, 1 ];
  var got = _.color.cmyka._longToRgba( null, src );
  test.identical( got, expected );

  test.case = 'Yellow';
  var src = [ 0, 0, 100, 0, 100 ];
  var expected = [ 1, 1, 0, 1 ];
  var got = _.color.cmyka._longToRgba( null, src );
  test.identical( got, expected );

  test.case = 'Cyan';
  var src = [ 100, 0, 0, 0, 100 ];
  var expected = [ 0, 1, 1, 1 ];
  var got = _.color.cmyka._longToRgba( null, src );
  test.identical( got, expected );

  test.case = 'Magenta';
  var src = [ 0, 100, 0, 0, 100 ];
  var expected = [ 1, 0, 1, 1 ];
  var got = _.color.cmyka._longToRgba( null, src );
  test.identical( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = '[ 12, 34, 99, 27, 40 ]';
  var src = [ 12, 34, 99, 27, 40 ];
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 0.4 ];
  var got = _.color.cmyka._longToRgba( null, src );
  test.equivalent( got, expected );

  test.case = '[ 87, 1, 33, 5, 34 ]';
  var src = [ 87, 1, 33, 5, 34 ];
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588, 0.34 ];
  var got = _.color.cmyka._longToRgba( null, src );
  test.equivalent( got, expected );

  test.case = '11, 16, 75, 4, 5 ]';
  var src = [ 11, 16, 75, 4, 5 ];
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981, 0.05 ];
  var got = _.color.cmyka._longToRgba( null, src );
  test.equivalent( got, expected );

  test.case = '[ 11, 16, 75, 4 ] no alpha info';
  var src = [ 11, 16, 75, 4 ];
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981, 1 ];
  var got = _.color.cmyka._longToRgba( null, src );
  test.equivalent( got, expected );

  test.close( 'non basic colors' );

  test.case = 'first arg > 100%';
  var src = [ 111, 16, 75, 4, 5 ];
  var expected = null;
  var got = _.color.cmyka._longToRgba( null, src );
  test.identical( got, expected );

  test.case = 'second arg > 100%';
  var src = [ 11, 160, 75, 4, 5 ];
  var expected = null;
  var got = _.color.cmyka._longToRgba( null, src );
  test.identical( got, expected );

  test.case = 'third arg > 100%';
  var src = [ 11, 16, 750, 4, 5 ];
  var expected = null;
  var got = _.color.cmyka._longToRgba( null, src );
  test.identical( got, expected );

  test.case = 'fourth arg > 100%';
  var src = [ 11, 16, 75, 400, 5 ];
  var expected = null;
  var got = _.color.cmyka._longToRgba( null, src );
  test.identical( got, expected );

  test.case = 'fifth arg > 100%';
  var src = [ 11, 16, 75, 40, 500 ];
  var expected = null;
  var got = _.color.cmyka._longToRgba( null, src );
  test.identical( got, expected );

}

_cmykaLongToRgba.accuracy = 1e-2;

//

function _cmykLongToRgbWithDst( test )
{

  test.open( 'basic colors' );

  test.case = 'Black, dst = Array';
  var src = [ 0, 0, 0, 100 ];
  var dst = [ 1, 2, 3 ];
  var expected = [ 0, 0, 0 ];
  var got = _.color.cmyk._longToRgb( dst, src );
  test.identical( got, expected );
  test.true( got === dst );

  test.case = 'Green, dst = Long';
  var src = [ 100, 0, 100, 0 ];
  var dst = _.longFrom([ 1, 4, 13 ]);
  var expected = [ 0, 1, 0 ];
  var got = _.color.cmyk._longToRgb( dst, src );
  test.identical( got, expected );
  test.true( got === dst );

  test.case = 'Red, dst = TypedArray';
  var src = [ 0, 100, 100, 0 ];
  var dst = new I8x([ 1, 5, 15 ]); /* 1 and 0 -> Integer Typed Array can be used */
  var expected = [ 1, 0, 0 ];
  var got = _.color.cmyk._longToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.identical( got[ i ], expected[ i ] );
  test.true( got === dst );

  test.case = 'White, dst = VectorAdapter';
  var src = [ 0, 0, 0, 0 ];
  var dst = _.vad.fromLong([ 1, 2, 3 ]);
  var expected = [ 1, 1, 1 ];
  var got = _.color.cmyk._longToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = '[ 12, 34, 99, 27 ];, dst = Array';
  var src = [ 12, 34, 99, 27 ];
  var dst = [ 1, 2, 3 ];
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.cmyk._longToRgb( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = '[ 12, 34, 99, 27 ];, dst = Long';
  var src = [ 12, 34, 99, 27 ];
  var dst = _.longFrom([ 1, 2, 3 ]);
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.cmyk._longToRgb( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = '[ 12, 34, 99, 27 ];, dst = TypedArray';
  var src = [ 12, 34, 99, 27 ];
  var dst = new Float32Array([ 1, 2, 3 ]); /* ( 0, 1 ) -> Integer Typed Array can NOT be used */
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.cmyk._longToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got[ i ], expected[ i ] );
  test.true( got === dst );

  test.case = '[ 12, 34, 99, 27 ];, dst = VectorAdapter';
  var src = [ 12, 34, 99, 27 ];
  var dst = _.vad.fromLong([ 1, 2, 3 ]);
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.cmyk._longToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.case = 'cmyk with alpha = 100, dst = Long';
  var src = [ 12, 34, 99, 27, 100 ];
  var dst = _.longFrom([ 1, 2, 3 ]);
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.cmyk._longToRgb( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = 'cmyk with alpha = 100, dst = VectorAdapter';
  var src = [ 12, 34, 99, 27, 100 ];
  var dst = _.vad.fromLong([ 1, 2, 3 ]);
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.cmyk._longToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.close( 'non basic colors' );

  test.case = 'first arg > 100%';
  var src = [ 111, 16, 75, 4 ];
  var expected = null;
  var got = _.color.cmyk._longToRgb( [ 1, 2, 3 ], src );
  test.identical( got, expected );

  test.case = 'second arg > 100%';
  var src = [ 11, 160, 75, 4 ];
  var expected = null;
  var got = _.color.cmyk._longToRgb( [ 1, 2, 3 ], src );
  test.identical( got, expected );

  test.case = 'third arg > 100%';
  var src = [ 11, 16, 750, 4 ];
  var expected = null;
  var got = _.color.cmyk._longToRgb( [ 1, 2, 3 ], src );
  test.identical( got, expected );

  test.case = 'fourth arg > 100%';
  var src = [ 11, 16, 75, 400 ];
  var expected = null;
  var got = _.color.cmyk._longToRgb( [ 1, 2, 3 ], src );
  test.identical( got, expected );

  /* - */

  test.case = 'dst : Array; dst.length !== 3';
  var src = [ 12, 34, 99, 27 ];
  var dst = [ 1, 2, 3, 5 ];
  test.shouldThrowErrorSync( () => _.color.cmyk._longToRgb( dst, src ) )

  test.case = 'dst : Long; dst.length !== 3';
  var src = [ 12, 34, 99, 27 ];
  var dst = _.longFrom([ 1, 2 ]);
  test.shouldThrowErrorSync( () => _.color.cmyk._longToRgb( dst, src ) )

  test.case = 'dst : TypedArray; dst.length !== 3';
  var src = [ 12, 34, 99, 27 ];
  var dst = new Float32Array([ 1, 2, 3, 4, 5, 6 ]);
  test.shouldThrowErrorSync( () => _.color.cmyk._longToRgb( dst, src ) )

  test.case = 'dst : VectorAdapter; dst.length !== 3';
  var src = [ 12, 34, 99, 27 ];
  var dst = _.vad.fromLong([ 1 ]);
  test.shouldThrowErrorSync( () => _.color.cmyk._longToRgb( dst, src ) )

  test.case = 'dst : Long; alpha !== 100';
  var src = [ 12, 34, 99, 27, 22 ];
  var dst = _.longFrom([ 1, 2, 3 ]);
  test.shouldThrowErrorSync( () => _.color.cmyk._longToRgb( dst, src ) )

  test.case = 'dst : VectorAdapter; alpha !== 100';
  var src = [ 12, 34, 99, 27, 22 ];
  var dst = _.vad.fromLong([ 1, 2, 3 ]);
  test.shouldThrowErrorSync( () => _.color.cmyk._longToRgb( dst, src ) )

}

_cmykLongToRgbWithDst.accuracy = 1e-2;

//

function _cmykaLongToRgbaWithDst( test )
{

  test.open( 'basic colors' );

  test.case = 'Black, dst = Array';
  var src = [ 0, 0, 0, 100, 100 ];
  var dst = [ 1, 2, 3, 4 ];
  var expected = [ 0, 0, 0, 1 ];
  var got = _.color.cmyka._longToRgba( dst, src );
  test.identical( got, expected );
  test.true( got === dst );

  test.case = 'Green, dst = Long';
  var src = [ 100, 0, 100, 0, 100 ];
  var dst = _.longFrom([ 1, 4, 13, 14 ]);
  var expected = [ 0, 1, 0, 1 ];
  var got = _.color.cmyka._longToRgba( dst, src );
  test.identical( got, expected );
  test.true( got === dst );

  test.case = 'Red, dst = TypedArray';
  var src = [ 0, 100, 100, 0, 100 ];
  var dst = new I8x([ 1, 5, 15, 14 ]); /* 1 and 0 -> Integer Typed Array can be used */
  var expected = [ 1, 0, 0, 1 ];
  var got = _.color.cmyka._longToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.identical( got[ i ], expected[ i ] );
  test.true( got === dst );

  test.case = 'White, dst = VectorAdapter';
  var src = [ 0, 0, 0, 0, 100 ];
  var dst = _.vad.fromLong([ 1, 2, 3, 4 ]);
  var expected = [ 1, 1, 1, 1 ];
  var got = _.color.cmyka._longToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = '[ 12, 34, 99, 27, 40 ], dst = Array';
  var src = [ 12, 34, 99, 27, 31 ];
  var dst = [ 1, 2, 3, 4 ];
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 0.31 ];
  var got = _.color.cmyka._longToRgba( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = '[ 12, 34, 99, 27, 31 ], dst = Long';
  var src = [ 12, 34, 99, 27, 31 ];
  var dst = _.longFrom([ 1, 2, 3, 4 ]);
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 0.31 ];
  var got = _.color.cmyka._longToRgba( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = '[ 12, 34, 99, 27, 31 ], dst = TypedArray';
  var src = [ 12, 34, 99, 27, 31 ];
  var dst = new Float32Array([ 1, 2, 3, 4 ]); /* ( 0, 1 ) -> Integer Typed Array can NOT be used */
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 0.31 ];
  var got = _.color.cmyka._longToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got[ i ], expected[ i ] );
  test.true( got === dst );

  test.case = '[ 12, 34, 99, 27, 31 ], dst = VectorAdapter';
  var src = [ 12, 34, 99, 27, 31 ];
  var dst = _.vad.fromLong([ 1, 2, 3, 4 ]);
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 0.31 ];
  var got = _.color.cmyka._longToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.case = '[ 12, 34, 99, 27 ] no alpha info, dst = Array';
  var src = [ 12, 34, 99, 27 ];
  var dst = [ 1, 2, 3, 4 ];
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 1 ];
  var got = _.color.cmyka._longToRgba( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = '[ 12, 34, 99, 27 ] no alpha info, dst = VectorAdapter';
  var src = [ 12, 34, 99, 27 ];
  var dst = _.vad.fromLong([ 1, 2, 3, 4 ]);
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 1 ];
  var got = _.color.cmyka._longToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.close( 'non basic colors' );

  test.case = 'first arg > 100%';
  var src = [ 111, 16, 75, 4, 5 ];
  var expected = null;
  var got = _.color.cmyka._longToRgba( [ 1, 2, 3, 4 ], src );
  test.identical( got, expected );

  test.case = 'second arg > 100%';
  var src = [ 11, 160, 75, 4, 5 ];
  var expected = null;
  var got = _.color.cmyka._longToRgba( [ 1, 2, 3 ], src );
  test.identical( got, expected );

  test.case = 'third arg > 100%';
  var src = [ 11, 16, 750, 4, 5 ];
  var expected = null;
  var got = _.color.cmyka._longToRgba( [ 1, 2, 3 ], src );
  test.identical( got, expected );

  test.case = 'fourth arg > 100%';
  var src = [ 11, 16, 75, 400, 5 ];
  var expected = null;
  var got = _.color.cmyka._longToRgba( [ 1, 2, 3 ], src );
  test.identical( got, expected );

  test.case = 'fifth arg > 100%';
  var src = [ 11, 16, 75, 40, 500 ];
  var expected = null;
  var got = _.color.cmyka._longToRgba( [ 1, 2, 3 ], src );
  test.identical( got, expected );

  /* - */

  test.case = 'dst : Array; dst.length !== 4';
  var src = [ 12, 34, 99, 27, 31 ];
  var dst = [ 1, 2, 3, 5, 6 ];
  test.shouldThrowErrorSync( () => _.color.cmyka._longToRgba( dst, src ) )

  test.case = 'dst : Long; dst.length !== 4';
  var src = [ 12, 34, 99, 27, 31 ];
  var dst = _.longFrom([ 1, 2 ]);
  test.shouldThrowErrorSync( () => _.color.cmyka._longToRgba( dst, src ) )

  test.case = 'dst : TypedArray; dst.length !== 4';
  var src = [ 12, 34, 99, 27, 31 ];
  var dst = new Float32Array([ 1, 2, 3 ]);
  test.shouldThrowErrorSync( () => _.color.cmyka._longToRgba( dst, src ) )

  test.case = 'dst : VectorAdapter; dst.length !== 4';
  var src = [ 12, 34, 99, 27, 31 ];
  var dst = _.vad.fromLong([ 1 ]);
  test.shouldThrowErrorSync( () => _.color.cmyka._longToRgba( dst, src ) )

}

_cmykaLongToRgbaWithDst.accuracy = 1e-2;


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

    // to rgb/a

    _cmykStrToRgb,
    _cmykaStrToRgba,
    _cmykStrToRgbWithDst,
    _cmykaStrToRgbaWithDst,
    _cmykLongToRgb,
    _cmykaLongToRgba,
    _cmykLongToRgbWithDst,
    _cmykaLongToRgbaWithDst,

  },

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
