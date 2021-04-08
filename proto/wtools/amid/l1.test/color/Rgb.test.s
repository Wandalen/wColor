( function _Rgb_test_s_( )
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
  var src = '#000000';
  var expected = [ 0, 0, 0 ];
  var got = _.color.rgb.fromHexStr( src );
  test.identical( got, expected );

  test.case = 'Black short';
  var src = '#000';
  var expected = [ 0, 0, 0 ];
  var got = _.color.rgb.fromHexStr( src );
  test.identical( got, expected );

  test.case = 'White';
  var src = '#ffffff';
  var expected = [ 1, 1, 1 ];
  var got = _.color.rgb.fromHexStr( src );
  test.identical( got, expected );

  test.case = 'White short';
  var src = '#fff';
  var expected = [ 1, 1, 1 ];
  var got = _.color.rgb.fromHexStr( src );
  test.identical( got, expected );

  test.case = 'Red';
  var src = '#ff0000';
  var expected = [ 1, 0, 0 ];
  var got = _.color.rgb.fromHexStr( src );
  test.identical( got, expected );

  test.case = 'Red short';
  var src = '#f00';
  var expected = [ 1, 0, 0 ];
  var got = _.color.rgb.fromHexStr( src );
  test.identical( got, expected );

  test.case = 'Green';
  var src = '#00ff00';
  var expected = [ 0, 1, 0 ];
  var got = _.color.rgb.fromHexStr( src );
  test.identical( got, expected );

  test.case = 'Green short';
  var src = '#0f0';
  var expected = [ 0, 1, 0 ];
  var got = _.color.rgb.fromHexStr( src );
  test.identical( got, expected );

  test.case = 'Blue';
  var src = '#0000ff';
  var expected = [ 0, 0, 1 ];
  var got = _.color.rgb.fromHexStr( src );
  test.identical( got, expected );

  test.case = 'Blue short';
  var src = '#00f';
  var expected = [ 0, 0, 1 ];
  var got = _.color.rgb.fromHexStr( src );
  test.identical( got, expected );

  test.case = 'Yellow';
  var src = '#ffff00';
  var expected = [ 1, 1, 0 ];
  var got = _.color.rgb.fromHexStr( src );
  test.identical( got, expected );

  test.case = 'Yellow short';
  var src = '#ff0';
  var expected = [ 1, 1, 0 ];
  var got = _.color.rgb.fromHexStr( src );
  test.identical( got, expected );

  test.case = 'Cyan';
  var src = '#00ffff';
  var expected = [ 0, 1, 1 ];
  var got = _.color.rgb.fromHexStr( src );
  test.identical( got, expected );

  test.case = 'Cyan short';
  var src = '#0ff';
  var expected = [ 0, 1, 1 ];
  var got = _.color.rgb.fromHexStr( src );
  test.identical( got, expected );

  test.case = 'Magenta';
  var src = '#ff00ff';
  var expected = [ 1, 0, 1 ];
  var got = _.color.rgb.fromHexStr( src );
  test.identical( got, expected );

  test.case = 'Magenta short';
  var src = '#f0f';
  var expected = [ 1, 0, 1 ];
  var got = _.color.rgb.fromHexStr( src );
  test.identical( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = '#a47b02';
  var src = '#a47b02';
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.rgb.fromHexStr( src );
  test.equivalent( got, expected );

  test.case = '#1ff0a2';
  var src = '#1ff0a2';
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588 ];
  var got = _.color.rgb.fromHexStr( src );
  test.equivalent( got, expected );

  test.case = '#dace3d';
  var src = '#dace3d';
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981 ];
  var got = _.color.rgb.fromHexStr( src );
  test.equivalent( got, expected );

  test.close( 'non basic colors' );

  test.case = 'length = 7';
  var src = '#fffffff';
  var expected = null;
  var got = _.color.rgb.fromHexStr( src );
  test.identical( got, expected );

  test.case = 'length = 3';
  var src = '#ff';
  var expected = null;
  var got = _.color.rgb.fromHexStr( src );
  test.identical( got, expected );

  test.case = 'alpha != 100'
  test.shouldThrowErrorSync( () => _.color.rgb.fromHexStr( '#a47b0200' ) );

}

fromHexStr.accuracy = 1e-2;

//

function fromRgbStr( test )
{

  test.open( 'basic colors' );

  test.case = 'Black';
  var src = 'R:0 G:0 B:0';
  var expected = [ 0, 0, 0 ];
  var got = _.color.rgb.fromRgbStr( src );
  test.identical( got, expected );

  test.case = 'White';
  var src = 'R:255 G:255 B:255';
  var expected = [ 1, 1, 1 ];
  var got = _.color.rgb.fromRgbStr( src );
  test.identical( got, expected );

  test.case = 'Red';
  var src = 'R:255 G:0 B:0';
  var expected = [ 1, 0, 0 ];
  var got = _.color.rgb.fromRgbStr( src );
  test.identical( got, expected );

  test.case = 'Green';
  var src = 'R:0 G:255 B:0';
  var expected = [ 0, 1, 0 ];
  var got = _.color.rgb.fromRgbStr( src );
  test.identical( got, expected );

  test.case = 'Blue';
  var src = 'R:0 G:0 B:255';
  var expected = [ 0, 0, 1 ];
  var got = _.color.rgb.fromRgbStr( src );
  test.identical( got, expected );

  test.case = 'Yellow';
  var src = 'R:255 G:255 B:0';
  var expected = [ 1, 1, 0 ];
  var got = _.color.rgb.fromRgbStr( src );
  test.identical( got, expected );

  test.case = 'Cyan';
  var src = 'R:0 G:255 B:255';
  var expected = [ 0, 1, 1 ];
  var got = _.color.rgb.fromRgbStr( src );
  test.identical( got, expected );

  test.case = 'Magenta';
  var src = 'R:255 G:0 B:255';
  var expected = [ 1, 0, 1 ];
  var got = _.color.rgb.fromRgbStr( src );
  test.identical( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = 'R:111 G:22 B:33';
  var src = 'R:111 G:22 B:33';
  var expected = [ 111/255, 22/255, 33/255 ];
  var got = _.color.rgb.fromRgbStr( src );
  test.equivalent( got, expected );

  test.case = 'R:1 G:1 B:3';
  var src = 'R:1 G:1 B:3';
  var expected = [ 1/255, 1/255, 3/255 ];
  var got = _.color.rgb.fromRgbStr( src );
  test.equivalent( got, expected );

  test.case = 'R:99 G:99 B:99';
  var src = 'R:99 G:99 B:99';
  var expected = [ 99/255, 99/255, 99/255 ];
  var got = _.color.rgb.fromRgbStr( src );
  test.equivalent( got, expected );

  test.close( 'non basic colors' );

  /* */

  test.case = 'R:99 G:99 B:99 A:100';
  var src = 'R:99 G:99 B:99 A:100';
  var expected = [ 99/255, 99/255, 99/255 ];
  var got = _.color.rgb.fromRgbStr( src );
  test.equivalent( got, expected );

  /* */

  test.case = 'wrong string pattern 1';
  var src = 'R:567 G:0 B:1';
  var expected = null;
  var got = _.color.rgb.fromRgbStr( src );
  test.identical( got, expected );

  test.case = 'wrong string pattern 2';
  var src = 'R:12 G:1111 B:1';
  var expected = null;
  var got = _.color.rgb.fromRgbStr( src );
  test.identical( got, expected );

  test.case = 'wrong string pattern 3';
  var src = 'R:0 G:11 B:1111';
  var expected = null;
  var got = _.color.rgb.fromRgbStr( src );
  test.identical( got, expected );

  test.case = 'alpha != 100'
  test.shouldThrowErrorSync( () => _.color.rgb.fromRgbStr( 'R:00 G:11 B:11 A:22' ) );

}

fromRgbStr.accuracy = 1e-2;

// --
// declare
// --

let Self =
{

  name : 'Tools/mid/Rgb',
  silencing : 1,

  tests :
  {
    // to rgb/a

    fromHexStr,
    fromRgbStr

  },

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
