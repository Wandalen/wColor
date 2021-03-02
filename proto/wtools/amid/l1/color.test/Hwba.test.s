( function _Hwba_test_s_( )
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

function _strToRgba( test )
{

  test.open( 'basic colors' );

  test.case = 'Black';
  var src = 'hwba(0,0%,100%,100%)';
  var expected = [ 0, 0, 0, 1 ];
  var got = _.color.hwba._strToRgba( null, src );
  test.identical( got, expected );

  test.case = 'White';
  var src = 'hwba(0,100%,0%,100%)';
  var expected = [ 1, 1, 1, 1 ];
  var got = _.color.hwba._strToRgba( null, src );
  test.identical( got, expected );

  test.case = 'Red';
  var src = 'hwba(0,0%,0%,100%)';
  var expected = [ 1, 0, 0, 1 ];
  var got = _.color.hwba._strToRgba( null, src );
  test.identical( got, expected );

  test.case = 'Green';
  var src = 'hwba(120, 0%, 0%,100%)';
  var expected = [ 0, 1, 0, 1 ];
  var got = _.color.hwba._strToRgba( null, src );
  test.identical( got, expected );

  test.case = 'Blue';
  var src = 'hwba(240,0%,0%,100%)';
  var expected = [ 0, 0, 1, 1 ];
  var got = _.color.hwba._strToRgba( null, src );
  test.identical( got, expected );

  test.case = 'Yellow';
  var src = 'hwba(60,0%,0%,100%)';
  var expected = [ 1, 1, 0, 1 ];
  var got = _.color.hwba._strToRgba( null, src );
  test.identical( got, expected );

  test.case = 'Cyan';
  var src = 'hwba(180,0%,0%,100%)';
  var expected = [ 0, 1, 1, 1 ];
  var got = _.color.hwba._strToRgba( null, src );
  test.identical( got, expected );

  test.case = 'Magenta';
  var src = 'hwba(300,0%,0%,100%)';
  var expected = [ 1, 0, 1, 1 ];
  var got = _.color.hwba._strToRgba( null, src );
  test.identical( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = 'hwba(45, 1%, 36%, 40%)';
  var src = 'hwba(45, 1%, 36%, 40%)';
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 0.4 ];
  var got = _.color.hwba._strToRgba( null, src );
  test.equivalent( got, expected );

  test.case = 'hwba(158, 12%, 6%, 34%)';
  var src = 'hwba(158, 12%, 6%, 34%)';
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588, 0.34 ];
  var got = _.color.hwba._strToRgba( null, src );
  test.equivalent( got, expected );

  test.case = 'hwba(55, 24%, 15%, 5%)';
  var src = 'hwba(55, 24%, 15%, 5%)';
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981, 0.05 ];
  var got = _.color.hwba._strToRgba( null, src );
  test.equivalent( got, expected );

  test.case = 'hwba(55, 24%, 15%) no alpha info';
  var src = 'hwba(55, 24%, 15%)';
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981, 1 ];
  var got = _.color.hwba._strToRgba( null, src );
  test.equivalent( got, expected );

  test.close( 'non basic colors' );

  test.case = 'first arg > 360';
  var src = 'hwba(444,16%,75%,4%)';
  var expected = null;
  var got = _.color.hwba._strToRgba( null, src );
  test.identical( got, expected );

  test.case = 'second arg > 100%';
  var src = 'hwba(11,160%,75%,4%)';
  var expected = null;
  var got = _.color.hwba._strToRgba( null, src );
  test.identical( got, expected );

  test.case = 'third arg > 100%';
  var src = 'hwba(11,16%,750%,4%)';
  var expected = null;
  var got = _.color.hwba._strToRgba( null, src );
  test.identical( got, expected );

  test.case = 'fourth arg > 100%';
  var src = 'hwba(11,16%,75%,400%)';
  var expected = null;
  var got = _.color.hwba._strToRgba( null, src );
  test.identical( got, expected );

}

_strToRgba.accuracy = 1e-2;

//

function _strToRgbaWithDst( test )
{

  test.open( 'basic colors' );

  test.case = 'Black, dst = Array';
  var src = 'hwba(0, 0%, 100%, 100%)';
  var dst = [ 1, 2, 3, 4 ];
  var expected = [ 0, 0, 0, 1 ];
  var got = _.color.hwba._strToRgba( dst, src );
  test.identical( got, expected );
  test.true( got === dst );

  test.case = 'Green, dst = Long';
  var src = 'hwba(120, 0%, 0%, 100%)';
  var dst = _.longFrom([ 1, 4, 13, 14 ]);
  var expected = [ 0, 1, 0, 1 ];
  var got = _.color.hwba._strToRgba( dst, src );
  test.identical( got, expected );
  test.true( got === dst );

  test.case = 'Red, dst = TypedArray';
  var src = 'hwba(0, 0%, 0%, 100%)';
  var dst = new I8x([ 1, 5, 15, 14 ]); /* 1 and 0 -> Integer Typed Array can be used */
  var expected = [ 1, 0, 0, 1 ];
  var got = _.color.hwba._strToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.identical( got[ i ], expected[ i ] );
  test.true( got === dst );

  test.case = 'White, dst = VectorAdapter';
  var src = 'hwba(0, 100%, 0%, 100%)';
  var dst = _.vad.fromLong([ 1, 2, 3, 4 ]);
  var expected = [ 1, 1, 1, 1 ];
  var got = _.color.hwba._strToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = 'hwba(45, 1%, 36%, 31%), dst = Array';
  var src = 'hwba(45, 1%, 36%, 31%)';
  var dst = [ 1, 2, 3, 4 ];
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 0.31 ];
  var got = _.color.hwba._strToRgba( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = 'hwba(45, 1%, 36%, 31%), dst = Long';
  var src = 'hwba(45, 1%, 36%, 31%)';
  var dst = _.longFrom([ 1, 2, 3, 4 ]);
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 0.31 ];
  var got = _.color.hwba._strToRgba( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = 'hwba(45, 1%, 36%, 31%), dst = TypedArray';
  var src = 'hwba(45, 1%, 36%, 31%)';
  var dst = new Float32Array([ 1, 2, 3, 4 ]); /* ( 0, 1 ) -> Integer Typed Array can NOT be used */
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 0.31 ];
  var got = _.color.hwba._strToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got[ i ], expected[ i ] );
  test.true( got === dst );

  test.case = 'hwba(45, 1%, 36%, 31%), dst = VectorAdapter';
  var src = 'hwba(45, 1%, 36%, 31%)';
  var dst = _.vad.fromLong([ 1, 2, 3, 4 ]);
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 0.31 ];
  var got = _.color.hwba._strToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.case = 'hwba(45, 1%, 36%) no alpha info, dst = Array';
  var src = 'hwba(45, 1%, 36%)';
  var dst = [ 1, 2, 3, 4 ];
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 1 ];
  var got = _.color.hwba._strToRgba( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = 'hwba(45, 1%, 36%) no alpha info, dst = VectorAdapter';
  var src = 'hwba(45, 1%, 36%)';
  var dst = _.vad.fromLong([ 1, 2, 3, 4 ]);
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 1 ];
  var got = _.color.hwba._strToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.close( 'non basic colors' );

  test.case = 'first arg > 360';
  var src = 'hwba(444,16%,75%,4%)';
  var expected = null;
  var got = _.color.hwba._strToRgba( [ 1, 2, 3, 4 ], src );
  test.identical( got, expected );

  test.case = 'second arg > 100%';
  var src = 'hwba(11,160%,75%,4%)';
  var expected = null;
  var got = _.color.hwba._strToRgba( [ 1, 2, 3 ], src );
  test.identical( got, expected );

  test.case = 'third arg > 100%';
  var src = 'hwba(11,16%,750%,4%)';
  var expected = null;
  var got = _.color.hwba._strToRgba( [ 1, 2, 3 ], src );
  test.identical( got, expected );

  test.case = 'fourth arg > 100%';
  var src = 'hwba(11,16%,75%,400%)';
  var expected = null;
  var got = _.color.hwba._strToRgba( [ 1, 2, 3 ], src );
  test.identical( got, expected );

  /* - */

  test.case = 'dst : Array; dst.length !== 4';
  var src = 'hwba(45, 1%, 36%)';
  var dst = [ 1, 2, 3, 5, 6 ];
  test.shouldThrowErrorSync( () => _.color.hwba._strToRgba( dst, src ) )

  test.case = 'dst : Long; dst.length !== 4';
  var src = 'hwba(45, 1%, 36%)';
  var dst = _.longFrom([ 1, 2 ]);
  test.shouldThrowErrorSync( () => _.color.hwba._strToRgba( dst, src ) )

  test.case = 'dst : TypedArray; dst.length !== 4';
  var src = 'hwba(45, 1%, 36%)';
  var dst = new Float32Array([ 1, 2, 3 ]);
  test.shouldThrowErrorSync( () => _.color.hwba._strToRgba( dst, src ) )

  test.case = 'dst : VectorAdapter; dst.length !== 4';
  var src = 'hwba(45, 1%, 36%)';
  var dst = _.vad.fromLong([ 1 ]);
  test.shouldThrowErrorSync( () => _.color.hwba._strToRgba( dst, src ) )

}

_strToRgbaWithDst.accuracy = 1e-2;

//

function _longToRgba( test )
{

  test.open( 'basic colors' );

  test.case = 'Black';
  var src = [ 0, 0, 100, 100 ];
  var expected = [ 0, 0, 0, 1 ];
  var got = _.color.hwba._longToRgba( null, src );
  test.identical( got, expected );

  test.case = 'White';
  var src = [ 0, 100, 0, 100 ];
  var expected = [ 1, 1, 1, 1 ];
  var got = _.color.hwba._longToRgba( null, src );
  test.identical( got, expected );

  test.case = 'Red';
  var src = [ 0, 0, 0, 100 ];
  var expected = [ 1, 0, 0, 1 ];
  var got = _.color.hwba._longToRgba( null, src );
  test.identical( got, expected );

  test.case = 'Green';
  var src = [ 120, 0, 0, 100 ];
  var expected = [ 0, 1, 0, 1 ];
  var got = _.color.hwba._longToRgba( null, src );
  test.identical( got, expected );

  test.case = 'Blue';
  var src = [ 240, 0, 0, 100 ];
  var expected = [ 0, 0, 1, 1 ];
  var got = _.color.hwba._longToRgba( null, src );
  test.identical( got, expected );

  test.case = 'Yellow';
  var src = [ 60, 0, 0, 100 ];
  var expected = [ 1, 1, 0, 1 ];
  var got = _.color.hwba._longToRgba( null, src );
  test.identical( got, expected );

  test.case = 'Cyan';
  var src = [ 180, 0, 0, 100 ];
  var expected = [ 0, 1, 1, 1 ];
  var got = _.color.hwba._longToRgba( null, src );
  test.identical( got, expected );

  test.case = 'Magenta';
  var src = [ 300, 0, 0, 100 ];
  var expected = [ 1, 0, 1, 1 ];
  var got = _.color.hwba._longToRgba( null, src );
  test.identical( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = '[  45, 1, 36, 40 ]';
  var src = [ 45, 1, 36, 40 ];
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 0.4 ];
  var got = _.color.hwba._longToRgba( null, src );
  test.equivalent( got, expected );

  test.case = '[ 158, 12, 6, 34 ]';
  var src = [ 158, 12, 6, 34 ];
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588, 0.34 ];
  var got = _.color.hwba._longToRgba( null, src );
  test.equivalent( got, expected );

  test.case = '[ 55, 24, 15, 5 ]';
  var src = [ 55, 24, 15, 5 ];
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981, 0.05 ];
  var got = _.color.hwba._longToRgba( null, src );
  test.equivalent( got, expected );

  test.case = '[ 55, 24, 15 ] no alpha info';
  var src = [ 55, 24, 15 ];
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981, 1 ];
  var got = _.color.hwba._longToRgba( null, src );
  test.equivalent( got, expected );

  test.close( 'non basic colors' );

  test.case = 'first arg > 360';
  var src = [ 444, 16, 75, 4 ];
  var expected = null;
  var got = _.color.hwba._longToRgba( null, src );
  test.identical( got, expected );

  test.case = 'second arg > 100%';
  var src = [ 11, 160, 75, 4 ];
  var expected = null;
  var got = _.color.hwba._longToRgba( null, src );
  test.identical( got, expected );

  test.case = 'third arg > 100%';
  var src = [ 11, 16, 750, 4 ];
  var expected = null;
  var got = _.color.hwba._longToRgba( null, src );
  test.identical( got, expected );

  test.case = 'fourth arg > 100%';
  var src = [ 11, 16, 75, 400 ];
  var expected = null;
  var got = _.color.hwba._longToRgba( null, src );
  test.identical( got, expected );

}

_longToRgba.accuracy = 1e-2;

//

function _longToRgbaWithDst( test )
{

  test.open( 'basic colors' );

  test.case = 'Black, dst = Array';
  var src = [ 0, 0, 100, 100 ];
  var dst = [ 1, 2, 3, 4 ];
  var expected = [ 0, 0, 0, 1 ];
  var got = _.color.hwba._longToRgba( dst, src );
  test.identical( got, expected );
  test.true( got === dst );

  test.case = 'Green, dst = Long';
  var src = [ 120, 0, 0, 100 ];
  var dst = _.longFrom([ 1, 4, 13, 14 ]);
  var expected = [ 0, 1, 0, 1 ];
  var got = _.color.hwba._longToRgba( dst, src );
  test.identical( got, expected );
  test.true( got === dst );

  test.case = 'Red, dst = TypedArray';
  var src = [ 0, 0, 0, 100 ];
  var dst = new I8x([ 1, 5, 15, 14 ]); /* 1 and 0 -> Integer Typed Array can be used */
  var expected = [ 1, 0, 0, 1 ];
  var got = _.color.hwba._longToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.identical( got[ i ], expected[ i ] );
  test.true( got === dst );

  test.case = 'White, dst = VectorAdapter';
  var src = [ 0, 100, 0, 100 ];
  var dst = _.vad.fromLong([ 1, 2, 3, 4 ]);
  var expected = [ 1, 1, 1, 1 ];
  var got = _.color.hwba._longToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = '[ 45, 1, 36, 40 ], dst = Array';
  var src = [ 45, 1, 36, 31 ];
  var dst = [ 1, 2, 3, 4 ];
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 0.31 ];
  var got = _.color.hwba._longToRgba( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = '[ 45, 1, 36, 31 ], dst = Long';
  var src = [ 45, 1, 36, 31 ];
  var dst = _.longFrom([ 1, 2, 3, 4 ]);
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 0.31 ];
  var got = _.color.hwba._longToRgba( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = '[ 45, 1, 36, 31 ], dst = TypedArray';
  var src = [ 45, 1, 36, 31 ];
  var dst = new Float32Array([ 1, 2, 3, 4 ]); /* ( 0, 1 ) -> Integer Typed Array can NOT be used */
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 0.31 ];
  var got = _.color.hwba._longToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got[ i ], expected[ i ] );
  test.true( got === dst );

  test.case = '[ 45, 1, 36, 31 ], dst = VectorAdapter';
  var src = [ 45, 1, 36, 31 ];
  var dst = _.vad.fromLong([ 1, 2, 3, 4 ]);
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 0.31 ];
  var got = _.color.hwba._longToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.case = '[ 45, 1, 36 ] no alpha info, dst = Array';
  var src = [ 45, 1, 36 ];
  var dst = [ 1, 2, 3, 4 ];
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 1 ];
  var got = _.color.hwba._longToRgba( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = '[ 45, 1, 36 ] no alpha info, dst = VectorAdapter';
  var src = [ 45, 1, 36 ];
  var dst = _.vad.fromLong([ 1, 2, 3, 4 ]);
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 1 ];
  var got = _.color.hwba._longToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.close( 'non basic colors' );

  test.case = 'first arg > 360';
  var src = [ 444, 16, 75, 4 ];
  var expected = null;
  var got = _.color.hwba._longToRgba( [ 1, 2, 3, 4 ], src );
  test.identical( got, expected );

  test.case = 'second arg > 100%';
  var src = [ 11, 160, 75, 4 ];
  var expected = null;
  var got = _.color.hwba._longToRgba( [ 1, 2, 3 ], src );
  test.identical( got, expected );

  test.case = 'third arg > 100%';
  var src = [ 11, 16, 750, 4 ];
  var expected = null;
  var got = _.color.hwba._longToRgba( [ 1, 2, 3 ], src );
  test.identical( got, expected );

  test.case = 'fourth arg > 100%';
  var src = [ 11, 16, 75, 400 ];
  var expected = null;
  var got = _.color.hwba._longToRgba( [ 1, 2, 3 ], src );
  test.identical( got, expected );

  /* - */

  test.case = 'dst : Array; dst.length !== 4';
  var src = [ 12, 34, 99, 27 ];
  var dst = [ 1, 2, 3, 5, 6 ];
  test.shouldThrowErrorSync( () => _.color.hwba._longToRgba( dst, src ) )

  test.case = 'dst : Long; dst.length !== 4';
  var src = [ 12, 34, 99, 27 ];
  var dst = _.longFrom([ 1, 2 ]);
  test.shouldThrowErrorSync( () => _.color.hwba._longToRgba( dst, src ) )

  test.case = 'dst : TypedArray; dst.length !== 4';
  var src = [ 12, 34, 99, 27 ];
  var dst = new Float32Array([ 1, 2, 3 ]);
  test.shouldThrowErrorSync( () => _.color.hwba._longToRgba( dst, src ) )

  test.case = 'dst : VectorAdapter; dst.length !== 4';
  var src = [ 12, 34, 99, 27 ];
  var dst = _.vad.fromLong([ 1 ]);
  test.shouldThrowErrorSync( () => _.color.hwba._longToRgba( dst, src ) )

}

_longToRgbaWithDst.accuracy = 1e-2;

//

function _validate( test )
{

  test.case = 'normal 4 elements';
  var src = [ 11, 16, 75, 40 ];
  var expected = true;
  var got = _.color.hwba._validate( src );
  test.identical( got, expected );

  test.case = 'normal 5 elements';
  var src = [ 11, 16, 75, 40, 54 ];
  var expected = true;
  var got = _.color.hwba._validate( src );
  test.identical( got, expected );

  test.case = 'first arg > 360';
  var src = [ 444, 16, 75, 4 ];
  var expected = false;
  var got = _.color.hwba._validate( src );
  test.identical( got, expected );

  test.case = 'first arg < 0';
  var src = [ -111, 16, 75, 4 ];
  var expected = false;
  var got = _.color.hwba._validate( src );
  test.identical( got, expected );

  test.case = 'second arg > 100';
  var src = [ 11, 160, 75, 4 ];
  var expected = false;
  var got = _.color.hwba._validate( src );
  test.identical( got, expected );

  test.case = 'second arg < 0';
  var src = [ 11, -160, 75, 4 ];
  var expected = false;
  var got = _.color.hwba._validate( src );
  test.identical( got, expected );

  test.case = 'third arg > 100';
  var src = [ 11, 16, 750, 4 ];
  var expected = false;
  var got = _.color.hwba._validate( src );
  test.identical( got, expected );

  test.case = 'third arg < 0';
  var src = [ 11, 16, -750, 4 ];
  var expected = false;
  var got = _.color.hwba._validate( src );
  test.identical( got, expected );

  test.case = 'fourth arg > 100';
  var src = [ 11, 16, 75, 400 ];
  var expected = false;
  var got = _.color.hwba._validate( src );
  test.identical( got, expected );

  test.case = 'fourth arg < 0';
  var src = [ 11, 16, 75, -400 ];
  var expected = false;
  var got = _.color.hwba._validate( src );
  test.identical( got, expected );

}

//

function _formatStringParse( test )
{
  test.case = 'normal 3';
  var src = 'hwba(0,0%,100%)';
  var expected = [ 0, 0, 100 ];
  var got = _.color.hwba._formatStringParse( src );
  test.identical( got, expected );

  test.case = 'normal spaces 3';
  var src = 'hwba(0, 0%, 100%)';
  var expected = [ 0, 0, 100 ];
  var got = _.color.hwba._formatStringParse( src );
  test.identical( got, expected );

  test.case = 'normal 4';
  var src = 'hwba(0,0%,0%,100%)';
  var expected = [ 0, 0, 0, 100 ];
  var got = _.color.hwba._formatStringParse( src );
  test.identical( got, expected );

  test.case = 'normal spaces 4';
  var src = 'hwba(0, 0%, 0%, 100%)';
  var expected = [ 0, 0, 0, 100 ];
  var got = _.color.hwba._formatStringParse( src );
  test.identical( got, expected );

  test.case = 'wrong format';
  var src = 'hwb(0%,0%,0%,100%)';
  test.shouldThrowErrorSync( () => _.color.hwba._formatStringParse( src ) );

  test.case = 'redundant channel';
  var src = 'hwba(0%,0%,0%,0%,100%,)';
  test.shouldThrowErrorSync( () => _.color.hwba._formatStringParse( src ) );

  test.case = 'without \'%\'';
  var src = 'hwba(0,0,0%,0%)';
  test.shouldThrowErrorSync( () => _.color.hwba._formatStringParse( src ) );

  test.case = 'more than 3 digits \'%\'';
  var src = 'hwba(0,0%,0%,1000%)';
  test.shouldThrowErrorSync( () => _.color.hwba._formatStringParse( src ) );
}


// --
// declare
// --

let Self =
{

  name : 'Tools/mid/Hwba',
  silencing : 1,

  tests :
  {
    // to rgb/a

    _strToRgba,
    _strToRgbaWithDst,
    _longToRgba,
    _longToRgbaWithDst,
    _validate,
    _formatStringParse

  },

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
