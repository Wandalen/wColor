( function _Cmyka_test_s_( )
{

'use strict';

if( typeof module !== 'undefined' )
{
  const _ = require( 'Tools' );
  require( '../../l1/color/entry/ColorBasic.s' );
  _.include( 'wTesting' );
  _.include( 'wMathVector' );
}

const _ = _global_.wTools;

// --
// tests
// --

function _strToRgba( test )
{

  test.open( 'basic colors' );

  test.case = 'Black';
  var src = 'cmyka(0%,0%,0%,100%,100%)';
  var expected = [ 0, 0, 0, 1 ];
  debugger
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

_strToRgba.accuracy = 1e-2;

//

function _strToRgbaWithDst( test )
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

_strToRgbaWithDst.accuracy = 1e-2;

//

function _longToRgba( test )
{

  test.open( 'basic colors' );

  test.case = 'Black';
  var src = [ 0, 0, 0, 1, 1 ];
  var expected = [ 0, 0, 0, 1 ];
  var got = _.color.cmyka._longToRgba( null, src );
  test.identical( got, expected );

  test.case = 'White';
  var src = [ 0, 0, 0, 0, 1 ];
  var expected = [ 1, 1, 1, 1 ];
  var got = _.color.cmyka._longToRgba( null, src );
  test.identical( got, expected );

  test.case = 'Red';
  var src = [ 0, 1, 1, 0, 1 ];
  var expected = [ 1, 0, 0, 1 ];
  var got = _.color.cmyka._longToRgba( null, src );
  test.identical( got, expected );

  test.case = 'Green';
  var src = [ 1, 0, 1, 0, 1 ];
  var expected = [ 0, 1, 0, 1 ];
  var got = _.color.cmyka._longToRgba( null, src );
  test.identical( got, expected );

  test.case = 'Blue';
  var src = [ 1, 1, 0, 0, 1 ];
  var expected = [ 0, 0, 1, 1 ];
  var got = _.color.cmyka._longToRgba( null, src );
  test.identical( got, expected );

  test.case = 'Yellow';
  var src = [ 0, 0, 1, 0, 1 ];
  var expected = [ 1, 1, 0, 1 ];
  var got = _.color.cmyka._longToRgba( null, src );
  test.identical( got, expected );

  test.case = 'Cyan';
  var src = [ 1, 0, 0, 0, 1 ];
  var expected = [ 0, 1, 1, 1 ];
  var got = _.color.cmyka._longToRgba( null, src );
  test.identical( got, expected );

  test.case = 'Magenta';
  var src = [ 0, 1, 0, 0, 1 ];
  var expected = [ 1, 0, 1, 1 ];
  var got = _.color.cmyka._longToRgba( null, src );
  test.identical( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = '[ 0.12, 0.34, 0.99, 0.27, 0.4 ]';
  var src = [ 0.12, 0.34, 0.99, 0.27, 0.4 ];
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 0.4 ];
  var got = _.color.cmyka._longToRgba( null, src );
  test.equivalent( got, expected );

  test.case = '[ 0.87, 0.01, 0.33, 0.05, 0.34 ]';
  var src = [ 0.87, 0.01, 0.33, 0.05, 0.34 ];
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588, 0.34 ];
  var got = _.color.cmyka._longToRgba( null, src );
  test.equivalent( got, expected );

  test.case = '[ 0.11, 0.16, 0.75, 0.04, 0.05 ]';
  var src = [ 0.11, 0.16, 0.75, 0.04, 0.05 ];
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981, 0.05 ];
  var got = _.color.cmyka._longToRgba( null, src );
  test.equivalent( got, expected );

  test.case = '[ 0.11, 0.16, 0.75, 0.04 ] no alpha info';
  var src = [ 0.11, 0.16, 0.75, 0.04 ];
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981, 1 ];
  var got = _.color.cmyka._longToRgba( null, src );
  test.equivalent( got, expected );

  test.close( 'non basic colors' );

  test.case = 'first arg > 100%';
  var src = [ 111, 0.16, 0.75, 0.04, 0.05 ];
  var expected = null;
  var got = _.color.cmyka._longToRgba( null, src );
  test.identical( got, expected );

  test.case = 'second arg > 100%';
  var src = [ 0.11, 160, 0.75, 0.04, 0.05 ];
  var expected = null;
  var got = _.color.cmyka._longToRgba( null, src );
  test.identical( got, expected );

  test.case = 'third arg > 100%';
  var src = [ 0.11, 0.16, 750, 0.4, 0.5 ];
  var expected = null;
  var got = _.color.cmyka._longToRgba( null, src );
  test.identical( got, expected );

  test.case = 'fourth arg > 100%';
  var src = [ 0.11, 0.16, 0.75, 400, 0.5 ];
  var expected = null;
  var got = _.color.cmyka._longToRgba( null, src );
  test.identical( got, expected );

  test.case = 'fifth arg > 100%';
  var src = [ 0.11, 0.16, 0.75, 0.40, 5 ];
  var expected = null;
  var got = _.color.cmyka._longToRgba( null, src );
  test.identical( got, expected );

}

_longToRgba.accuracy = 1e-2;

//

function _longToRgbaWithDst( test )
{

  test.open( 'basic colors' );

  test.case = 'Black, dst = Array';
  var src = [ 0, 0, 0, 1, 1 ];
  var dst = [ 1, 2, 3, 4 ];
  var expected = [ 0, 0, 0, 1 ];
  var got = _.color.cmyka._longToRgba( dst, src );
  test.identical( got, expected );
  test.true( got === dst );

  test.case = 'Green, dst = Long';
  var src = [ 1, 0, 1, 0, 1 ];
  var dst = _.longFrom([ 1, 4, 13, 14 ]);
  var expected = [ 0, 1, 0, 1 ];
  var got = _.color.cmyka._longToRgba( dst, src );
  test.identical( got, expected );
  test.true( got === dst );

  test.case = 'Red, dst = TypedArray';
  var src = [ 0, 1, 1, 0, 1 ];
  var dst = new I8x([ 1, 5, 15, 14 ]); /* 1 and 0 -> Integer Typed Array can be used */
  var expected = [ 1, 0, 0, 1 ];
  var got = _.color.cmyka._longToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.identical( got[ i ], expected[ i ] );
  test.true( got === dst );

  test.case = 'White, dst = VectorAdapter';
  var src = [ 0, 0, 0, 0, 1 ];
  var dst = _.vad.fromLong([ 1, 2, 3, 4 ]);
  var expected = [ 1, 1, 1, 1 ];
  var got = _.color.cmyka._longToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = '[ 0.12, 0.34, 0.99, 0.27, 0.31 ], dst = Array';
  var src = [ 0.12, 0.34, 0.99, 0.27, 0.31 ];
  var dst = [ 1, 2, 3, 4 ];
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 0.31 ];
  var got = _.color.cmyka._longToRgba( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = '[ 0.12, 0.34, 0.99, 0.27, 0.31 ], dst = Long';
  var src = [ 0.12, 0.34, 0.99, 0.27, 0.31 ];
  var dst = _.longFrom([ 1, 2, 3, 4 ]);
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 0.31 ];
  var got = _.color.cmyka._longToRgba( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = '[ 0.12, 0.34, 0.99, 0.27, 0.31 ], dst = TypedArray';
  var src = [ 0.12, 0.34, 0.99, 0.27, 0.31 ];
  var dst = new Float32Array([ 1, 2, 3, 4 ]); /* ( 0, 1 ) -> Integer Typed Array can NOT be used */
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 0.31 ];
  var got = _.color.cmyka._longToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got[ i ], expected[ i ] );
  test.true( got === dst );

  test.case = '[ 0.12, 0.34, 0.99, 0.27, 0.31 ], dst = VectorAdapter';
  var src = [ 0.12, 0.34, 0.99, 0.27, 0.31 ];
  var dst = _.vad.fromLong([ 1, 2, 3, 4 ]);
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 0.31 ];
  var got = _.color.cmyka._longToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.case = '[ 0.12, 0.34, 0.99, 0.27 ] no alpha info, dst = Array';
  var src = [ 0.12, 0.34, 0.99, 0.27 ];
  var dst = [ 1, 2, 3, 4 ];
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 1 ];
  var got = _.color.cmyka._longToRgba( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = '[ 0.12, 0.34, 0.99, 0.27 ] no alpha info, dst = VectorAdapter';
  var src = [ 0.12, 0.34, 0.99, 0.27 ];
  var dst = _.vad.fromLong([ 1, 2, 3, 4 ]);
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196, 1 ];
  var got = _.color.cmyka._longToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.close( 'non basic colors' );

  test.case = 'first arg > 100%';
  var src = [ 111, 0.16, 0.75, 0.04, 0.05 ];
  var expected = null;
  var got = _.color.cmyka._longToRgba( [ 1, 2, 3, 4 ], src );
  test.identical( got, expected );

  test.case = 'second arg > 100%';
  var src = [ 0.11, 160, 0.75, 0.04, 0.05 ];
  var expected = null;
  var got = _.color.cmyka._longToRgba( [ 1, 2, 3 ], src );
  test.identical( got, expected );

  test.case = 'third arg > 100%';
  var src = [ 0.11, 0.16, 750, 0.4, 0.5 ];
  var expected = null;
  var got = _.color.cmyka._longToRgba( [ 1, 2, 3 ], src );
  test.identical( got, expected );

  test.case = 'fourth arg > 100%';
  var src = [ 0.11, 0.16, 0.75, 400, 0.5 ];
  var expected = null;
  var got = _.color.cmyka._longToRgba( [ 1, 2, 3 ], src );
  test.identical( got, expected );

  test.case = 'fifth arg > 100%';
  var src = [ 0.11, 0.16, 0.75, 0.40, 5 ];
  var expected = null;
  var got = _.color.cmyka._longToRgba( [ 1, 2, 3 ], src );
  test.identical( got, expected );

  /* - */

  test.case = 'dst : Array; dst.length !== 4';
  var src = [ 0.12, 0.34, 0.99, 0.27, 0.31 ];
  var dst = [ 1, 2, 3, 5, 6 ];
  test.shouldThrowErrorSync( () => _.color.cmyka._longToRgba( dst, src ) )

  test.case = 'dst : Long; dst.length !== 4';
  var src = [ 0.12, 0.34, 0.99, 0.27, 0.31 ];
  var dst = _.longFrom([ 1, 2 ]);
  test.shouldThrowErrorSync( () => _.color.cmyka._longToRgba( dst, src ) )

  test.case = 'dst : TypedArray; dst.length !== 4';
  var src = [ 0.12, 0.34, 0.99, 0.27, 0.31 ];
  var dst = new Float32Array([ 1, 2, 3 ]);
  test.shouldThrowErrorSync( () => _.color.cmyka._longToRgba( dst, src ) )

  test.case = 'dst : VectorAdapter; dst.length !== 4';
  var src = [ 0.12, 0.34, 0.99, 0.27, 0.31 ];
  var dst = _.vad.fromLong([ 1 ]);
  test.shouldThrowErrorSync( () => _.color.cmyka._longToRgba( dst, src ) )

}

_longToRgbaWithDst.accuracy = 1e-2;

//

function _validate( test )
{

  test.case = 'normal 4 elements';
  var src = [ 11, 16, 75, 40 ];
  var expected = true;
  var got = _.color.cmyka._validate( src );
  test.identical( got, expected );

  test.case = 'normal 5 elements';
  var src = [ 11, 16, 75, 40, 54 ];
  var expected = true;
  var got = _.color.cmyka._validate( src );
  test.identical( got, expected );

  test.case = 'first arg > 100';
  var src = [ 111, 16, 75, 4 ];
  var expected = false;
  var got = _.color.cmyka._validate( src );
  test.identical( got, expected );

  test.case = 'first arg < 0';
  var src = [ -111, 16, 75, 4 ];
  var expected = false;
  var got = _.color.cmyka._validate( src );
  test.identical( got, expected );

  test.case = 'second arg > 100';
  var src = [ 11, 160, 75, 4 ];
  var expected = false;
  var got = _.color.cmyka._validate( src );
  test.identical( got, expected );

  test.case = 'second arg < 0';
  var src = [ 11, -160, 75, 4 ];
  var expected = false;
  var got = _.color.cmyka._validate( src );
  test.identical( got, expected );

  test.case = 'third arg > 100';
  var src = [ 11, 16, 750, 4 ];
  var expected = false;
  var got = _.color.cmyka._validate( src );
  test.identical( got, expected );

  test.case = 'third arg < 0';
  var src = [ 11, 16, -750, 4 ];
  var expected = false;
  var got = _.color.cmyka._validate( src );
  test.identical( got, expected );

  test.case = 'fourth arg > 100';
  var src = [ 11, 16, 75, 400 ];
  var expected = false;
  var got = _.color.cmyka._validate( src );
  test.identical( got, expected );

  test.case = 'fourth arg < 0';
  var src = [ 11, 16, 75, -400 ];
  var expected = false;
  var got = _.color.cmyka._validate( src );
  test.identical( got, expected );

  test.case = 'fifth arg > 100';
  var src = [ 11, 16, 75, 40, 104 ];
  var expected = false;
  var got = _.color.cmyka._validate( src );
  test.identical( got, expected );

  test.case = 'fifth arg < 0';
  var src = [ 11, 16, 75, 40, -1 ];
  var expected = false;
  var got = _.color.cmyka._validate( src );
  test.identical( got, expected );

}

//

function _formatStringParse( test )
{
  test.case = 'normal';
  var src = 'cmyka(0%,0%,0%,0%,100%)';
  var expected = [ 0, 0, 0, 0, 100 ];
  var got = _.color.cmyka._formatStringParse( src );
  test.identical( got, expected );

  test.case = 'wrong format';
  var src = 'cmyk(0%,0%,0%,0%,100%)';
  test.shouldThrowErrorSync( () => _.color.cmyka._formatStringParse( src ) );

  test.case = 'redundant channel';
  var src = 'cmyka(0%,0%,0%,0%,100%,105%)';
  test.shouldThrowErrorSync( () => _.color.cmyka._formatStringParse( src ) );

  test.case = 'without \'%\'';
  var src = 'cmyka(0,0%,0%,0%,100%)';
  test.shouldThrowErrorSync( () => _.color.cmyka._formatStringParse( src ) );

  test.case = 'more than 3 digits \'%\'';
  var src = 'cmyka(0,0%,0%,0%,1000%)';
  test.shouldThrowErrorSync( () => _.color.cmyka._formatStringParse( src ) );
}


// --
// declare
// --

const Proto =
{

  name : 'Tools/mid/Cmyka',
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

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
