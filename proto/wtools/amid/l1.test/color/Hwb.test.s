( function _Hwb_test_s_( )
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
  var src = 'hwb(0,0%,100%)';
  var expected = [ 0, 0, 0 ];
  var got = _.color.hwb._strToRgb( null, src );
  test.identical( got, expected );

  test.case = 'White';
  var src = 'hwb(0, 100%, 0%)';
  var expected = [ 1, 1, 1 ];
  var got = _.color.hwb._strToRgb( null, src );
  test.identical( got, expected );

  test.case = 'Red';
  var src = 'hwb(0, 0%, 0%)';
  var expected = [ 1, 0, 0 ];
  var got = _.color.hwb._strToRgb( null, src );
  test.identical( got, expected );

  test.case = 'Green';
  var src = 'hwb(120, 0%, 0%)';
  var expected = [ 0, 1, 0 ];
  var got = _.color.hwb._strToRgb( null, src );
  test.identical( got, expected );

  test.case = 'Blue';
  var src = 'hwb(240,0%,0%)';
  var expected = [ 0, 0, 1 ];
  var got = _.color.hwb._strToRgb( null, src );
  test.identical( got, expected );

  test.case = 'Yellow';
  var src = 'hwb(60,0%,0%)';
  var expected = [ 1, 1, 0 ];
  var got = _.color.hwb._strToRgb( null, src );
  test.identical( got, expected );

  test.case = 'Cyan';
  var src = 'hwb(180,0%,0%)';
  var expected = [ 0, 1, 1 ];
  var got = _.color.hwb._strToRgb( null, src );
  test.identical( got, expected );

  test.case = 'Magenta';
  var src = 'hwb(300,0%,0%)';
  var expected = [ 1, 0, 1 ];
  var got = _.color.hwb._strToRgb( null, src );
  test.identical( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = 'hwb(45, 1%, 36%)';
  var src = 'hwb(45, 1%, 36%)';
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.hwb._strToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'hwb(158, 12%, 6%)';
  var src = 'hwb(158, 12%, 6%)';
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588 ];
  var got = _.color.hwb._strToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'hwb(55, 24%, 15%)';
  var src = 'hwb(55, 24%, 15%)';
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981 ];
  var got = _.color.hwb._strToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'hwb(55, 24%, 15%, 100%) with alpha = 100%';
  var src = 'hwb(55, 24%, 15%, 100%)';
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981 ];
  var got = _.color.hwb._strToRgb( null, src );
  test.equivalent( got, expected );

  test.close( 'non basic colors' );

  test.case = 'first arg > 360';
  var src = 'hwb(366,16%,75%)';
  var expected = null;
  var got = _.color.hwb._strToRgb( null, src );
  test.identical( got, expected );

  test.case = 'second arg > 100%';
  var src = 'hwb(35,160%,75%)';
  var expected = null;
  var got = _.color.hwb._strToRgb( null, src );
  test.identical( got, expected );

  test.case = 'third arg > 100%';
  var src = 'hwb(35,10%,175%)';
  var expected = null;
  var got = _.color.hwb._strToRgb( null, src );
  test.identical( got, expected );

  test.case = 'alpha !== 100%';
  var src = 'hwb(35,10%,15%,120%)';
  test.shouldThrowErrorSync( () => _.color.hwb._strToRgb( null, src ) )

}

_strToRgb.accuracy = 1e-2;

//

function _strToRgbWithDst( test )
{

  test.open( 'basic colors' );

  test.case = 'Black, dst = Array';
  var src = 'hwb(0, 0%, 100%)';
  var dst = [ 1, 2, 3 ];
  var expected = [ 0, 0, 0 ];
  var got = _.color.hwb._strToRgb( dst, src );
  test.identical( got, expected );
  test.true( got === dst );

  test.case = 'Green, dst = Long';
  var src = 'hwb(120, 0%, 0%)';
  var dst = _.longFrom([ 1, 4, 13 ]);
  var expected = [ 0, 1, 0 ];
  var got = _.color.hwb._strToRgb( dst, src );
  test.identical( got, expected );
  test.true( got === dst );

  test.case = 'Red, dst = TypedArray';
  var src = 'hwb(0, 0%, 0%)';
  var dst = new I8x([ 1, 5, 15 ]); /* 1 and 0 -> Integer Typed Array can be used */
  var expected = [ 1, 0, 0 ];
  var got = _.color.hwb._strToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.identical( got[ i ], expected[ i ] );
  test.true( got === dst );

  test.case = 'White, dst = VectorAdapter';
  var src = 'hwb(0, 100%, 0%)';
  var dst = _.vad.fromLong([ 1, 2, 3 ]);
  var expected = [ 1, 1, 1 ];
  var got = _.color.hwb._strToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = 'hwb(45, 1%, 36%), dst = Array';
  var src = 'hwb(45, 1%, 36%)';
  var dst = [ 1, 2, 3 ];
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.hwb._strToRgb( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = 'hwb(45, 1%, 36%), dst = Long';
  var src = 'hwb(45, 1%, 36%)';
  var dst = _.longFrom([ 1, 2, 3 ]);
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.hwb._strToRgb( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = 'hwb(45, 1%, 36%), dst = TypedArray';
  var src = 'hwb(45, 1%, 36%)';
  var dst = new Float32Array([ 1, 2, 3 ]); /* ( 0, 1 ) -> Integer Typed Array can NOT be used */
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.hwb._strToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got[ i ], expected[ i ] );
  test.true( got === dst );

  test.case = 'hwb(45, 1%, 36%), dst = VectorAdapter';
  var src = 'hwb(45, 1%, 36%)';
  var dst = _.vad.fromLong([ 1, 2, 3 ]);
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.hwb._strToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.case = 'hwb(45, 1%, 36%, 100%) with alpha = 100, dst = Array';
  var src = 'hwb(45, 1%, 36%, 100%)';
  var dst = [ 1, 2, 3 ];
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.hwb._strToRgb( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = 'hwb(45, 1%, 36%, 100%) with alpha = 100, dst = VectorAdapter';
  var src = 'hwb(45, 1%, 36%, 100%)';
  var dst = _.vad.fromLong([ 1, 2, 3 ]);
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.hwb._strToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.close( 'non basic colors' );

  /* - */

  test.case = 'dst : Array; dst.length !== 3';
  var src = 'hwb(45, 1%, 36%)';
  var dst = [ 1, 2, 3, 5, 6 ];
  test.shouldThrowErrorSync( () => _.color.hwb._strToRgb( dst, src ) )

  test.case = 'dst : Long; dst.length !== 3';
  var src = 'hwb(45, 1%, 36%)';
  var dst = _.longFrom([ 1, 2 ]);
  test.shouldThrowErrorSync( () => _.color.hwb._strToRgb( dst, src ) )

  test.case = 'dst : TypedArray; dst.length !== 3';
  var src = 'hwb(45, 1%, 36%)';
  var dst = new Float32Array([ 1, 2, 3, 4 ]);
  test.shouldThrowErrorSync( () => _.color.hwb._strToRgb( dst, src ) )

  test.case = 'dst : VectorAdapter; dst.length !== 3';
  var src = 'hwb(45, 1%, 36%)';
  var dst = _.vad.fromLong([ 1 ]);
  test.shouldThrowErrorSync( () => _.color.hwb._strToRgb( dst, src ) )

}

_strToRgbWithDst.accuracy = 1e-2;

//

function _longToRgb( test )
{

  test.open( 'basic colors' );

  test.case = 'Black';
  var src = [ 0, 0, 1 ];
  var expected = [ 0, 0, 0 ];
  var got = _.color.hwb._longToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'White';
  var src = [ 0, 1, 0 ];
  var expected = [ 1, 1, 1 ];
  var got = _.color.hwb._longToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'Red';
  var src = [ 0, 0, 0 ];
  var expected = [ 1, 0, 0 ];
  var got = _.color.hwb._longToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'Green';
  var src = [ 0.3333333333333333, 0, 0 ];
  var expected = [ 0, 1, 0 ];
  var got = _.color.hwb._longToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'Blue';
  var src = [ 0.6666666666666666, 0, 0 ];
  var expected = [ 0, 0, 1 ];
  var got = _.color.hwb._longToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'Yellow';
  var src = [ 0.1666666666666666, 0, 0 ];
  var expected = [ 1, 1, 0 ];
  var got = _.color.hwb._longToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'Cyan';
  var src = [ 0.5, 0, 0 ];
  var expected = [ 0, 1, 1 ];
  var got = _.color.hwb._longToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'Magenta';
  var src = [ 0.8333333333333333, 0, 0 ];
  var expected = [ 1, 0, 1 ];
  var got = _.color.hwb._longToRgb( null, src );
  test.equivalent( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = '[ 0.125, 0.01, 0.36 ]';
  var src = [ 0.125, 0.01, 0.36 ];
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.hwb._longToRgb( null, src );
  test.equivalent( got, expected );

  test.case = '[ 0.4388888888888889, 0.12, 0.06 ]';
  var src = [ 0.4388888888888889, 0.12, 0.06 ];
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588 ];
  var got = _.color.hwb._longToRgb( null, src );
  test.equivalent( got, expected );

  test.case = '[ 0.1527777777777778, 0.24, 0.15 ]';
  var src = [ 0.1527777777777778, 0.24, 0.15 ];
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981 ];
  var got = _.color.hwb._longToRgb( null, src );
  test.equivalent( got, expected );

  test.case = '[ 0.1527777777777778, 0.24, 0.15, 1 ] with alpha = 100';
  var src = [ 0.1527777777777778, 0.24, 0.15, 1 ];
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981 ];
  var got = _.color.hwb._longToRgb( null, src );
  test.equivalent( got, expected );

  test.close( 'non basic colors' );

  test.case = 'first arg > 360';
  var src = [ 11, 0.24, 0.15 ];
  var expected = null;
  var got = _.color.hwb._longToRgb( null, src );
  test.identical( got, expected );

  test.case = 'second arg > 100%';
  var src = [ 0.11, 160, 0.75 ];
  var expected = null;
  var got = _.color.hwb._longToRgb( null, src );
  test.identical( got, expected );

  test.case = 'third arg > 100%';
  var src = [ 0.11, 0.16, 75 ];
  var expected = null;
  var got = _.color.hwb._longToRgb( null, src );
  test.identical( got, expected );

}

_longToRgb.accuracy = 1e-2;

//

function _longToRgbWithDst( test )
{

  test.open( 'basic colors' );

  test.case = 'Black, dst = Array';
  var src = [ 0, 0, 1 ]
  var dst = [ 1, 2, 3 ];
  var expected = [ 0, 0, 0 ];
  var got = _.color.hwb._longToRgb( dst, src );
  test.identical( got, expected );
  test.true( got === dst );

  test.case = 'Green, dst = Long';
  var src = [ 0.3333333333333333, 0, 0 ];
  var dst = _.longFrom([ 1, 4, 13 ]);
  var expected = [ 0, 1, 0 ];
  var got = _.color.hwb._longToRgb( dst, src );
  test.identical( got, expected );
  test.true( got === dst );

  test.case = 'Red, dst = TypedArray';
  var src = [ 0, 0, 0 ];
  var dst = new I8x([ 1, 5, 15 ]); /* 1 and 0 -> Integer Typed Array can be used */
  var expected = [ 1, 0, 0 ];
  var got = _.color.hwb._longToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.identical( got[ i ], expected[ i ] );
  test.true( got === dst );

  test.case = 'White, dst = VectorAdapter';
  var src = [ 0, 1, 0 ];
  var dst = _.vad.fromLong([ 1, 2, 3 ]);
  var expected = [ 1, 1, 1 ];
  var got = _.color.hwb._longToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = '[ 0.125, 0.01, 0.36 ], dst = Array';
  var src = [ 0.125, 0.01, 0.36 ];
  var dst = [ 1, 2, 3 ];
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.hwb._longToRgb( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = '[ 0.125, 0.01, 0.36 ], dst = Long';
  var src = [ 0.125, 0.01, 0.36 ];
  var dst = _.longFrom([ 1, 2, 3 ]);
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.hwb._longToRgb( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = '[ 0.125, 0.01, 0.36 ], dst = TypedArray';
  var src = [ 0.125, 0.01, 0.36 ];
  var dst = new Float32Array([ 1, 2, 3 ]); /* ( 0, 1 ) -> Integer Typed Array can NOT be used */
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.hwb._longToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got[ i ], expected[ i ] );
  test.true( got === dst );

  test.case = '[ 0.125, 0.01, 0.36 ], dst = VectorAdapter';
  var src = [ 0.125, 0.01, 0.36 ];
  var dst = _.vad.fromLong([ 1, 2, 3 ]);
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.hwb._longToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.case = '[ 0.125, 0.01, 0.36 ] with alpha = 100, dst = Array';
  var src = [ 0.125, 0.01, 0.36 ];
  var dst = [ 1, 2, 3 ];
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.hwb._longToRgb( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = '[ 0.125, 0.01, 0.36 ] with alpha = 100, dst = VectorAdapter';
  var src = [ 0.125, 0.01, 0.36 ];
  var dst = _.vad.fromLong([ 1, 2, 3 ]);
  var expected = [ 0.6431372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.hwb._longToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.close( 'non basic colors' );

  test.case = 'first arg > 360';
  var src = [ 12, 0.01, 0.36 ]
  var expected = null;
  var got = _.color.hwb._longToRgb( [ 1, 2, 3 ], src );
  test.identical( got, expected );

  test.case = 'second arg > 100%';
  var src = [ 0.45, 12, 0.36 ]
  var expected = null;
  var got = _.color.hwb._longToRgb( [ 1, 2, 3 ], src );
  test.identical( got, expected );

  test.case = 'third arg > 100%';
  var src = [ 0.45, 1, 30 ]
  var expected = null;
  var got = _.color.hwb._longToRgb( [ 1, 2, 3 ], src );
  test.identical( got, expected );

  /* - */

  test.case = 'dst : Array; dst.length !== 3';
  var src = [ 0.12, 0.34, 0.99, 0.27, 0.31 ];
  var dst = [ 1, 2, 3, 5, 6 ];
  test.shouldThrowErrorSync( () => _.color.hwb._longToRgb( dst, src ) )

  test.case = 'dst : Long; dst.length !== 3';
  var src = [ 0.12, 0.34, 0.99, 0.27, 0.31 ];
  var dst = _.longFrom([ 1, 2 ]);
  test.shouldThrowErrorSync( () => _.color.hwb._longToRgb( dst, src ) )

  test.case = 'dst : TypedArray; dst.length !== 3';
  var src = [ 0.12, 0.34, 0.99, 0.27, 0.31 ];
  var dst = new Float32Array([ 1, 2, 3, 4 ]);
  test.shouldThrowErrorSync( () => _.color.hwb._longToRgb( dst, src ) )

  test.case = 'dst : VectorAdapter; dst.length !== 3';
  var src = [ 0.12, 0.34, 0.99, 0.27, 0.31 ];
  var dst = _.vad.fromLong([ 1 ]);
  test.shouldThrowErrorSync( () => _.color.hwb._longToRgb( dst, src ) )

}

_longToRgbWithDst.accuracy = 1e-2;

//

function _validate( test )
{

  test.case = 'normal 3 elements';
  var src = [ 11, 16, 75 ];
  var expected = true;
  var got = _.color.hwb._validate( src );
  test.identical( got, expected );

  test.case = 'normal 4 elements';
  var src = [ 11, 16, 75, 40 ];
  var expected = true;
  var got = _.color.hwb._validate( src );
  test.identical( got, expected );

  test.case = 'first arg > 360';
  var src = [ 1111, 16, 75 ];
  var expected = false;
  var got = _.color.hwb._validate( src );
  test.identical( got, expected );

  test.case = 'first arg < 0';
  var src = [ -111, 16, 75 ];
  var expected = false;
  var got = _.color.hwb._validate( src );
  test.identical( got, expected );

  test.case = 'second arg > 100';
  var src = [ 11, 160, 75 ];
  var expected = false;
  var got = _.color.hwb._validate( src );
  test.identical( got, expected );

  test.case = 'second arg < 0';
  var src = [ 11, -160, 75 ];
  var expected = false;
  var got = _.color.hwb._validate( src );
  test.identical( got, expected );

  test.case = 'third arg > 100';
  var src = [ 11, 16, 750 ];
  var expected = false;
  var got = _.color.hwb._validate( src );
  test.identical( got, expected );

  test.case = 'third arg < 0';
  var src = [ 11, 16, -750 ];
  var expected = false;
  var got = _.color.hwb._validate( src );
  test.identical( got, expected );

}

//

function _formatStringParse( test )
{
  test.case = 'normal 3';
  var src = 'hwb(0,0%,100%)';
  var expected = [ 0, 0, 100 ];
  var got = _.color.hwb._formatStringParse( src );
  test.identical( got, expected );

  test.case = 'normal spaces 3';
  var src = 'hwb(0, 0%, 100%)';
  var expected = [ 0, 0, 100 ];
  var got = _.color.hwb._formatStringParse( src );
  test.identical( got, expected );

  test.case = 'normal 4';
  var src = 'hwb(0,0%,0%,100%)';
  var expected = [ 0, 0, 0, 100 ];
  var got = _.color.hwb._formatStringParse( src );
  test.identical( got, expected );

  test.case = 'normal spaces 4';
  var src = 'hwb(0, 0%, 0%, 100%)';
  var expected = [ 0, 0, 0, 100 ];
  var got = _.color.hwb._formatStringParse( src );
  test.identical( got, expected );

  test.case = 'wrong format';
  var src = 'hwba(0,0%,0%)';
  test.shouldThrowErrorSync( () => _.color.hwb._formatStringParse( src ) );

  test.case = 'redundant channel';
  var src = 'hwb(0,0%,0%,0%,100%)';
  test.shouldThrowErrorSync( () => _.color.hwb._formatStringParse( src ) );

  test.case = 'without \'%\'';
  var src = 'hwb(0,0,0%)';
  test.shouldThrowErrorSync( () => _.color.hwb._formatStringParse( src ) );

  test.case = 'more than 3 digits \'%\'';
  var src = 'hwb(0,0%,1000%)';
  test.shouldThrowErrorSync( () => _.color.hwb._formatStringParse( src ) );
}


// --
// declare
// --

const Proto =
{

  name : 'Tools/mid/Hwb',
  silencing : 1,

  tests :
  {
    // to rgb/a

    _strToRgb,
    _strToRgbWithDst,
    _longToRgb,
    _longToRgbWithDst,
    _validate,
    _formatStringParse

  },

}

//

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
