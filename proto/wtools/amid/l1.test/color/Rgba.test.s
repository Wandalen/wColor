( function _Rgba_test_s_( )
{

'use strict';

if( typeof module !== 'undefined' )
{
  const _ = require( 'Tools' );
  require( '../../l1/color/entry/ColorBasic.s' );
  _.include( 'wTesting' );
  // _.include( 'wMathVector' );
}

const _ = _global_.wTools;

// --
// tests
// --

function fromHexStr( test )
{

  test.open( 'basic colors' );

  test.case = 'Black';
  var src = '#000000ff';
  var expected = [ 0, 0, 0, 1 ];
  var got = _.color.rgba.fromHexStr( src );
  test.equivalent( got, expected );

  test.case = 'Black short';
  var src = '#000f';
  var expected = [ 0, 0, 0, 1 ];
  var got = _.color.rgba.fromHexStr( src );
  test.equivalent( got, expected );

  test.case = 'White';
  var src = '#ffffff00';
  var expected = [ 1, 1, 1, 0 ];
  var got = _.color.rgba.fromHexStr( src );
  test.equivalent( got, expected );

  test.case = 'White short';
  var src = '#fff0';
  var expected = [ 1, 1, 1, 0 ];
  var got = _.color.rgba.fromHexStr( src );
  test.equivalent( got, expected );

  test.case = 'Red';
  var src = '#ff0000cc';
  var expected = [ 1, 0, 0, 0.8 ];
  var got = _.color.rgba.fromHexStr( src );
  test.equivalent( got, expected );

  test.case = 'Red short';
  var src = '#f00c';
  var expected = [ 1, 0, 0, 0.8 ];
  var got = _.color.rgba.fromHexStr( src );
  test.equivalent( got, expected );

  test.case = 'Green';
  var src = '#00ff0011';
  var expected = [ 0, 1, 0, 0.07 ];
  var got = _.color.rgba.fromHexStr( src );
  test.equivalent( got, expected );

  test.case = 'Green short';
  var src = '#0f01';
  var expected = [ 0, 1, 0, 0.07 ];
  var got = _.color.rgba.fromHexStr( src );
  test.equivalent( got, expected );

  test.case = 'Blue';
  var src = '#0000ffdd';
  var expected = [ 0, 0, 1, 0.87 ];
  var got = _.color.rgba.fromHexStr( src );
  test.equivalent( got, expected );

  test.case = 'Blue short';
  var src = '#00fd';
  var expected = [ 0, 0, 1, 0.87 ];
  var got = _.color.rgba.fromHexStr( src );
  test.equivalent( got, expected );

  test.case = 'Yellow';
  var src = '#ffff0033';
  var expected = [ 1, 1, 0, 0.2 ];
  var got = _.color.rgba.fromHexStr( src );
  test.equivalent( got, expected );

  test.case = 'Yellow short';
  var src = '#ff03';
  var expected = [ 1, 1, 0, 0.2 ];
  var got = _.color.rgba.fromHexStr( src );
  test.equivalent( got, expected );

  test.case = 'Cyan';
  var src = '#00ffff66';
  var expected = [ 0, 1, 1, 0.4 ];
  var got = _.color.rgba.fromHexStr( src );
  test.equivalent( got, expected );

  test.case = 'Cyan short';
  var src = '#0ff6';
  var expected = [ 0, 1, 1, 0.4 ];
  var got = _.color.rgba.fromHexStr( src );
  test.equivalent( got, expected );

  test.case = 'Magenta';
  var src = '#ff00ffee';
  var expected = [ 1, 0, 1, 0.93 ];
  var got = _.color.rgba.fromHexStr( src );
  test.equivalent( got, expected );

  test.case = 'Magenta short';
  var src = '#f0fe';
  var expected = [ 1, 0, 1, 0.93 ];
  var got = _.color.rgba.fromHexStr( src );
  test.equivalent( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = '#a47b02ff';
  var src = '#a47b02ff';
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 1 ];
  var got = _.color.rgba.fromHexStr( src );
  test.equivalent( got, expected );

  test.case = '#1ff0a218';
  var src = '#1ff0a218';
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588, 0.09 ];
  var got = _.color.rgba.fromHexStr( src );
  test.equivalent( got, expected );

  test.case = '#dace3dd2';
  var src = '#dace3dd2';
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981, 0.82 ];
  var got = _.color.rgba.fromHexStr( src );
  test.equivalent( got, expected );

  test.close( 'non basic colors' );

  test.case = 'length > 8';
  var src = '#ffffffff9';
  var expected = null;
  var got = _.color.rgba.fromHexStr( src );
  test.identical( got, expected );

  test.case = 'length < 3';
  var src = '#ff';
  var expected = null;
  var got = _.color.rgba.fromHexStr( src );
  test.identical( got, expected );

}

fromHexStr.accuracy = 1e-2;

//

function fromRgbaStr( test )
{

  test.open( 'basic colors' );

  test.case = 'Black';
  var src = 'R:0 G:0 B:0 A:100';
  var expected = [ 0, 0, 0, 1 ];
  var got = _.color.rgba.fromRgbaStr( src );
  test.identical( got, expected );

  test.case = 'White';
  var src = 'R:255 G:255 B:255 A:100';
  var expected = [ 1, 1, 1, 1 ];
  var got = _.color.rgba.fromRgbaStr( src );
  test.identical( got, expected );

  test.case = 'Red';
  var src = 'R:255 G:0 B:0 A:100';
  var expected = [ 1, 0, 0, 1 ];
  var got = _.color.rgba.fromRgbaStr( src );
  test.identical( got, expected );

  test.case = 'Green';
  var src = 'R:0 G:255 B:0 A:100';
  var expected = [ 0, 1, 0, 1 ];
  var got = _.color.rgba.fromRgbaStr( src );
  test.identical( got, expected );

  test.case = 'Blue';
  var src = 'R:0 G:0 B:255 A:100';
  var expected = [ 0, 0, 1, 1 ];
  var got = _.color.rgba.fromRgbaStr( src );
  test.identical( got, expected );

  test.case = 'Yellow';
  var src = 'R:255 G:255 B:0 A:100';
  var expected = [ 1, 1, 0, 1 ];
  var got = _.color.rgba.fromRgbaStr( src );
  test.identical( got, expected );

  test.case = 'Cyan';
  var src = 'R:0 G:255 B:255 A:100';
  var expected = [ 0, 1, 1, 1 ];
  var got = _.color.rgba.fromRgbaStr( src );
  test.identical( got, expected );

  test.case = 'Magenta';
  var src = 'R:255 G:0 B:255 A:100';
  var expected = [ 1, 0, 1, 1 ];
  var got = _.color.rgba.fromRgbaStr( src );
  test.identical( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = 'R:111 G:22 B:33 A:12';
  var src = 'R:111 G:22 B:33 A:12';
  var expected = [ 111/255, 22/255, 33/255, 0.12 ];
  var got = _.color.rgba.fromRgbaStr( src );
  test.equivalent( got, expected );

  test.case = 'R:1 G:1 B:3 A:1';
  var src = 'R:1 G:1 B:3 A:1';
  var expected = [ 1/255, 1/255, 3/255, 0.01 ];
  var got = _.color.rgba.fromRgbaStr( src );
  test.equivalent( got, expected );

  test.case = 'R:99 G:99 B:99 A:99';
  var src = 'R:99 G:99 B:99 A:99';
  var expected = [ 99/255, 99/255, 99/255, 0.99 ];
  var got = _.color.rgba.fromRgbaStr( src );
  test.equivalent( got, expected );

  test.close( 'non basic colors' );

  /* */

  test.case = 'R:99 G:99 B:99, withou alpha info';
  var src = 'R:99 G:99 B:99';
  var expected = [ 99/255, 99/255, 99/255, 1 ];
  var got = _.color.rgba.fromRgbaStr( src );
  test.equivalent( got, expected );

  /* */

  test.case = 'wrong string pattern 1';
  var src = 'R:567 G:0 B:1';
  var expected = null;
  var got = _.color.rgba.fromRgbaStr( src );
  test.identical( got, expected );

  test.case = 'wrong string pattern 2';
  var src = 'R:12 G:1111 B:1';
  var expected = null;
  var got = _.color.rgba.fromRgbaStr( src );
  test.identical( got, expected );

  test.case = 'wrong string pattern 3';
  var src = 'R:0 G:11 B:1111';
  var expected = null;
  var got = _.color.rgba.fromRgbaStr( src );
  test.identical( got, expected );

  debugger
  test.case = 'wrong string pattern 4';
  var src = 'R:0 G:11 B:11, A:22232';
  var expected = null;
  var got = _.color.rgba.fromRgbaStr( src );
  test.identical( got, expected );

}

fromRgbaStr.accuracy = 1e-2;

// --
// declare
// --

let Self =
{

  name : 'Tools/mid/Rgba',
  silencing : 1,

  tests :
  {
    // to rgba/a

    fromHexStr,
    fromRgbaStr,

  },

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
