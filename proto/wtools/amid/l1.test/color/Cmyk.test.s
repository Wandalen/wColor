( function _Cmyk_test_s_( )
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

function _strToRgb( test )
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

_strToRgb.accuracy = 1e-2;

//

function _strToRgbWithDst( test )
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

_strToRgbWithDst.accuracy = 1e-2;

//

function _longToRgb( test )
{

  test.open( 'basic colors' );

  test.case = 'Black';
  var src = [ 0, 0, 0, 1 ];
  var expected = [ 0, 0, 0 ];
  var got = _.color.cmyk._longToRgb( null, src );
  test.identical( got, expected );

  test.case = 'White';
  var src = [ 0, 0, 0, 0 ];
  var expected = [ 1, 1, 1 ];
  var got = _.color.cmyk._longToRgb( null, src );
  test.identical( got, expected );

  test.case = 'Red';
  var src = [ 0, 1, 1, 0 ];
  var expected = [ 1, 0, 0 ];
  var got = _.color.cmyk._longToRgb( null, src );
  test.identical( got, expected );

  test.case = 'Green';
  var src = [ 1, 0, 1, 0 ];
  var expected = [ 0, 1, 0 ];
  var got = _.color.cmyk._longToRgb( null, src );
  test.identical( got, expected );

  test.case = 'Blue';
  var src = [ 1, 1, 0, 0 ];
  var expected = [ 0, 0, 1 ];
  var got = _.color.cmyk._longToRgb( null, src );
  test.identical( got, expected );

  test.case = 'Yellow';
  var src = [ 0, 0, 1, 0 ];
  var expected = [ 1, 1, 0 ];
  var got = _.color.cmyk._longToRgb( null, src );
  test.identical( got, expected );

  test.case = 'Cyan';
  var src = [ 1, 0, 0, 0 ];
  var expected = [ 0, 1, 1 ];
  var got = _.color.cmyk._longToRgb( null, src );
  test.identical( got, expected );

  test.case = 'Magenta';
  var src = [ 0, 1, 0, 0 ];
  var expected = [ 1, 0, 1 ];
  var got = _.color.cmyk._longToRgb( null, src );
  test.identical( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = '[ 0.12, 0.34, 0.99, 0.27 ]';
  var src = [ 0.12, 0.34, 0.99, 0.27 ];
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.cmyk._longToRgb( null, src );
  test.equivalent( got, expected );

  test.case = '[ 0.87, 0.01, 0.33, 0.05 ]';
  var src = [ 0.87, 0.01, 0.33, 0.05 ];
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588 ];
  var got = _.color.cmyk._longToRgb( null, src );
  test.equivalent( got, expected );

  test.case = '[ 0.11, 0.16, 0.75, 0.04 ]';
  var src = [ 0.11, 0.16, 0.75, 0.04 ];
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981 ];
  var got = _.color.cmyk._longToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'cmyk with alpha=100%';
  var src = [ 0.11, 0.16, 0.75, 0.04, 1 ];
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981 ];
  var got = _.color.cmyk._longToRgb( null, src );
  test.equivalent( got, expected );

  test.close( 'non basic colors' );

  test.case = 'first arg > 100%';
  var src = [ 1.1, 0.16, 0.75, 0.4 ];
  var expected = null;
  var got = _.color.cmyk._longToRgb( null, src );
  test.identical( got, expected );

  test.case = 'second arg > 100%';
  var src = [ 0.11, 16, 0.75, 0.4 ];
  var expected = null;
  var got = _.color.cmyk._longToRgb( null, src );
  test.identical( got, expected );

  test.case = 'third arg > 100%';
  var src = [ 0.11, 0.16, 75, 0.4 ];
  var expected = null;
  var got = _.color.cmyk._longToRgb( null, src );
  test.identical( got, expected );

  test.case = 'fourth arg > 100%';
  var src = [ 0.11, 0.16, 0.75, 4 ];
  var expected = null;
  var got = _.color.cmyk._longToRgb( null, src );
  test.identical( got, expected );

  /* */

  test.case = 'alpha !== 100%';
  var src = [ 0.11, 0.16, 0.75, 0.4, 0.8 ];
  test.shouldThrowErrorSync( () => _.color.cmyk._longToRgb( null, src ) )

}

_longToRgb.accuracy = 1e-2;

//

function _longToRgbWithDst( test )
{

  test.open( 'basic colors' );

  test.case = 'Black, dst = Array';
  var src = [ 0, 0, 0, 1 ];
  var dst = [ 1, 2, 3 ];
  var expected = [ 0, 0, 0 ];
  var got = _.color.cmyk._longToRgb( dst, src );
  test.identical( got, expected );
  test.true( got === dst );

  test.case = 'Green, dst = Long';
  var src = [ 1, 0, 1, 0 ];
  var dst = _.longFrom([ 1, 4, 13 ]);
  var expected = [ 0, 1, 0 ];
  var got = _.color.cmyk._longToRgb( dst, src );
  test.identical( got, expected );
  test.true( got === dst );

  test.case = 'Red, dst = TypedArray';
  var src = [ 0, 1, 1, 0 ];
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

  test.case = '[ 0.12, 0.34, 0.99, 0.27 ];, dst = Array';
  var src = [ 0.12, 0.34, 0.99, 0.27 ];
  var dst = [ 1, 2, 3 ];
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.cmyk._longToRgb( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = '[ 0.12, 0.34, 0.99, 0.27 ];, dst = Long';
  var src = [ 0.12, 0.34, 0.99, 0.27 ];
  var dst = _.longFrom([ 1, 2, 3 ]);
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.cmyk._longToRgb( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = '[ 0.12, 0.34, 0.99, 0.27 ];, dst = TypedArray';
  var src = [ 0.12, 0.34, 0.99, 0.27 ];
  var dst = new Float32Array([ 1, 2, 3 ]); /* ( 0, 1 ) -> Integer Typed Array can NOT be used */
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.cmyk._longToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got[ i ], expected[ i ] );
  test.true( got === dst );

  test.case = '[ 0.12, 0.34, 0.99, 0.27 ];, dst = VectorAdapter';
  var src = [ 0.12, 0.34, 0.99, 0.27 ];
  var dst = _.vad.fromLong([ 1, 2, 3 ]);
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.cmyk._longToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.case = 'cmyk with alpha = 100, dst = Long';
  var src = [ 0.12, 0.34, 0.99, 0.27, 1 ];
  var dst = _.longFrom([ 1, 2, 3 ]);
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.cmyk._longToRgb( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = 'cmyk with alpha = 100, dst = VectorAdapter';
  var src = [ 0.12, 0.34, 0.99, 0.27, 1 ];
  var dst = _.vad.fromLong([ 1, 2, 3 ]);
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.cmyk._longToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.close( 'non basic colors' );

  test.case = 'first arg > 100%';
  var src = [ 1.1, 0.16, 0.75, 0.4 ];
  var expected = null;
  var got = _.color.cmyk._longToRgb( [ 1, 2, 3 ], src );
  test.identical( got, expected );

  test.case = 'second arg > 100%';
  var src = [ 0.11, 16, 0.75, 0.4 ];
  var expected = null;
  var got = _.color.cmyk._longToRgb( [ 1, 2, 3 ], src );
  test.identical( got, expected );

  test.case = 'third arg > 100%';
  var src = [ 0.11, 0.16, 75, 0.4 ];
  var expected = null;
  var got = _.color.cmyk._longToRgb( [ 1, 2, 3 ], src );
  test.identical( got, expected );

  test.case = 'fourth arg > 100%';
  var src = [ 0.11, 0.16, 0.75, 4 ];
  var expected = null;
  var got = _.color.cmyk._longToRgb( [ 1, 2, 3 ], src );
  test.identical( got, expected );

  /* - */

  test.case = 'dst : Array; dst.length !== 3';
  var src = [ 0.12, 0.34, 0.99, 0.27 ];
  var dst = [ 1, 2, 3, 5 ];
  test.shouldThrowErrorSync( () => _.color.cmyk._longToRgb( dst, src ) )

  test.case = 'dst : Long; dst.length !== 3';
  var src = [ 0.12, 0.34, 0.99, 0.27 ];
  var dst = _.longFrom([ 1, 2 ]);
  test.shouldThrowErrorSync( () => _.color.cmyk._longToRgb( dst, src ) )

  test.case = 'dst : TypedArray; dst.length !== 3';
  var src = [ 0.12, 0.34, 0.99, 0.27 ];
  var dst = new Float32Array([ 1, 2, 3, 4, 5, 6 ]);
  test.shouldThrowErrorSync( () => _.color.cmyk._longToRgb( dst, src ) )

  test.case = 'dst : VectorAdapter; dst.length !== 3';
  var src = [ 0.12, 0.34, 0.99, 0.27 ];
  var dst = _.vad.fromLong([ 1 ]);
  test.shouldThrowErrorSync( () => _.color.cmyk._longToRgb( dst, src ) )

  test.case = 'dst : Long; alpha !== 100';
  var src = [ 0.12, 0.34, 0.99, 0.27, 1.1 ];
  var dst = _.longFrom([ 1, 2, 3 ]);
  test.shouldThrowErrorSync( () => _.color.cmyk._longToRgb( dst, src ) )

  test.case = 'dst : VectorAdapter; alpha !== 100';
  var src = [ 0.12, 0.34, 0.99, 0.27, 0.1 ];
  var dst = _.vad.fromLong([ 1, 2, 3 ]);
  test.shouldThrowErrorSync( () => _.color.cmyk._longToRgb( dst, src ) )

}

_longToRgbWithDst.accuracy = 1e-2;

//


function _validate( test )
{

  test.case = 'normal';
  var src = [ 11, 16, 75, 40 ];
  var expected = true;
  var got = _.color.cmyk._validate( src );
  test.identical( got, expected );

  test.case = 'first arg > 100';
  var src = [ 111, 16, 75, 4 ];
  var expected = false;
  var got = _.color.cmyk._validate( src );
  test.identical( got, expected );

  test.case = 'first arg < 0';
  var src = [ -111, 16, 75, 4 ];
  var expected = false;
  var got = _.color.cmyk._validate( src );
  test.identical( got, expected );

  test.case = 'second arg > 100';
  var src = [ 11, 160, 75, 4 ];
  var expected = false;
  var got = _.color.cmyk._validate( src );
  test.identical( got, expected );

  test.case = 'second arg < 0';
  var src = [ 11, -160, 75, 4 ];
  var expected = false;
  var got = _.color.cmyk._validate( src );
  test.identical( got, expected );

  test.case = 'third arg > 100';
  var src = [ 11, 16, 750, 4 ];
  var expected = false;
  var got = _.color.cmyk._validate( src );
  test.identical( got, expected );

  test.case = 'third arg < 0';
  var src = [ 11, 16, -750, 4 ];
  var expected = false;
  var got = _.color.cmyk._validate( src );
  test.identical( got, expected );

  test.case = 'fourth arg > 100';
  var src = [ 11, 16, 75, 400 ];
  var expected = false;
  var got = _.color.cmyk._validate( src );
  test.identical( got, expected );

  test.case = 'fourth arg < 0';
  var src = [ 11, 16, 75, -400 ];
  var expected = false;
  var got = _.color.cmyk._validate( src );
  test.identical( got, expected );

}

//

function _formatStringParse( test )
{
  test.case = 'normal 5 elems';
  var src = 'cmyk(0%,0%,0%,0%,100%)';
  var expected = [ 0, 0, 0, 0, 100 ];
  var got = _.color.cmyk._formatStringParse( src );
  test.identical( got, expected );

  test.case = 'normal 4 elems';
  var src = 'cmyk(0%,0%,0%,0%)';
  var expected = [ 0, 0, 0, 0 ];
  var got = _.color.cmyk._formatStringParse( src );
  test.identical( got, expected );

  test.case = 'wrong format';
  var src = 'cmyka(0%,0%,0%,0%,100%)';
  test.shouldThrowErrorSync( () => _.color.cmyk._formatStringParse( src ) );

  test.case = 'redundant channel';
  var src = 'cmyk(0%,0%,0%,0%,100%,105%)';
  test.shouldThrowErrorSync( () => _.color.cmyk._formatStringParse( src ) );

  test.case = 'without \'%\'';
  var src = 'cmyk(0,0%,0%,0%,100%)';
  test.shouldThrowErrorSync( () => _.color.cmyk._formatStringParse( src ) );

  test.case = 'more than 3 digits \'%\'';
  var src = 'cmyk(0,0%,0%,0%,1000%)';
  test.shouldThrowErrorSync( () => _.color.cmyk._formatStringParse( src ) );
}

//

// --
// declare
// --

const Proto =
{

  name : 'Tools/mid/Cmyk',
  silencing : 1,

  tests :
  {
    // to rgb/a

    _strToRgb,
    _strToRgbWithDst,
    _longToRgb,
    _longToRgbWithDst,
    _validate,
    _formatStringParse,

  },

}

//

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
