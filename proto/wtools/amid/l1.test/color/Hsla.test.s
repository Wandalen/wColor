( function _Hsla_test_s_( )
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
  var src = 'hsla(0,0%,0%,100%)';
  var expected = [ 0, 0, 0, 1 ];
  var got = _.color.hsla._strToRgba( null, src );
  test.equivalent( got, expected );

  test.case = 'White';
  var src = 'hsla(0, 0%, 100%,100%)';
  var expected = [ 1, 1, 1, 1 ];
  var got = _.color.hsla._strToRgba( null, src );
  test.equivalent( got, expected );

  test.case = 'Red';
  var src = 'hsla(0, 100%, 50%,100%)';
  var expected = [ 1, 0, 0, 1 ];
  var got = _.color.hsla._strToRgba( null, src );
  test.equivalent( got, expected );

  test.case = 'Green';
  var src = 'hsla(120, 100%, 50%,100%)';
  var expected = [ 0, 1, 0, 1 ];
  var got = _.color.hsla._strToRgba( null, src );
  test.equivalent( got, expected );

  test.case = 'Blue';
  var src = 'hsla(240,100%,50%,100%)';
  var expected = [ 0, 0, 1, 1 ];
  var got = _.color.hsla._strToRgba( null, src );
  test.equivalent( got, expected );

  test.case = 'Yellow';
  var src = 'hsla(60,100%,50%,100%)';
  var expected = [ 1, 1, 0, 1 ];
  var got = _.color.hsla._strToRgba( null, src );
  test.equivalent( got, expected );

  test.case = 'Cyan';
  var src = 'hsla(180,100%,50%,100%)';
  var expected = [ 0, 1, 1, 1 ];
  var got = _.color.hsla._strToRgba( null, src );
  test.equivalent( got, expected );

  test.case = 'Magenta';
  var src = 'hsla(300,100%,50%,100%)';
  var expected = [ 1, 0, 1, 1 ];
  var got = _.color.hsla._strToRgba( null, src );
  test.equivalent( got, expected );

  test.case = 'Black, no alpha';
  var src = 'hsla(0,0%,0%)';
  var expected = [ 0, 0, 0, 1 ];
  var got = _.color.hsla._strToRgba( null, src );
  test.equivalent( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = 'hsla(45, 98%, 33%, 80%)';
  var src = 'hsla(45, 98%, 33%, 80%)';
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196, 0.8 ];
  var got = _.color.hsla._strToRgba( null, src );
  test.equivalent( got, expected );

  test.case = 'hsla(157, 87%, 53%, 32%)';
  var src = 'hsla(157, 87%, 53%, 32%)';
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588, 0.32 ];
  var got = _.color.hsla._strToRgba( null, src );
  test.equivalent( got, expected );

  test.case = 'hsla(55, 68%, 55%, 1%)';
  var src = 'hsla(55, 68%, 55%, 1%)';
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981, 0.01 ];
  var got = _.color.hsla._strToRgba( null, src );
  test.equivalent( got, expected );

  test.close( 'non basic colors' );

  test.case = 'first arg > 360';
  var src = 'hsla(366,16%,75%,100%)';
  var expected = null;
  var got = _.color.hsla._strToRgba( null, src );
  test.identical( got, expected );

  test.case = 'second arg > 100%';
  var src = 'hsla(35,160%,75%,100%)';
  var expected = null;
  var got = _.color.hsla._strToRgba( null, src );
  test.identical( got, expected );

  test.case = 'third arg > 100%';
  var src = 'hsla(35,10%,175%,100%)';
  var expected = null;
  var got = _.color.hsla._strToRgba( null, src );
  test.identical( got, expected );

  test.case = 'alpha > 100%';
  var src = 'hsla(35,10%,15%,120%,120%)';
  test.shouldThrowErrorSync( () => _.color.hsla._strToRgba( null, src ) )

}

_strToRgba.accuracy = 1e-2;

//

function _strToRgbaWithDst( test )
{

  test.open( 'basic colors' );

  test.case = 'Black, dst = Array';
  var src = 'hsla(0, 0%, 0%, 100%)';
  var dst = [ 1, 2, 3, 4 ];
  var expected = [ 0, 0, 0, 1 ];
  var got = _.color.hsla._strToRgba( dst, src );
  test.identical( got, expected );
  test.true( got === dst );

  test.case = 'Green, dst = Long';
  var src = 'hsla(120, 100%, 50%, 100%)';
  var dst = _.longFrom([ 1, 4, 13, 14 ]);
  var expected = [ 0, 1, 0, 1 ];
  var got = _.color.hsla._strToRgba( dst, src );
  test.identical( got, expected );
  test.true( got === dst );

  test.case = 'Red, dst = TypedArray';
  var src = 'hsla(0, 100%, 50%, 100%)';
  var dst = new I8x([ 1, 5, 15, 16 ]); /* 1 and 0 -> Integer Typed Array can be used */
  var expected = [ 1, 0, 0, 1 ];
  var got = _.color.hsla._strToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.identical( got[ i ], expected[ i ] );
  test.true( got === dst );

  test.case = 'White, dst = VectorAdapter';
  var src = 'hsla(0, 0%, 100%, 100%)';
  var dst = _.vad.fromLong([ 1, 2, 3, 4 ]);
  var expected = [ 1, 1, 1, 1 ];
  var got = _.color.hsla._strToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = 'hsla(45, 98%, 33%, 22%), dst = Arra,1';
  var src = 'hsla(45, 98%, 33%, 22%)';
  var dst = [ 1, 2, 3, 4 ];
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196, 0.22 ];
  var got = _.color.hsla._strToRgba( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = 'hsla(45, 98%, 33%, 1%), dst = Lon,100%g';
  var src = 'hsla(45, 98%, 33%, 1%)';
  var dst = _.longFrom([ 1, 2, 3, 4 ]);
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196, 0.01 ];
  var got = _.color.hsla._strToRgba( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = 'hsla(45, 98%, 33%, 99%), dst = TypedArra,100%y';
  var src = 'hsla(45, 98%, 33%, 99%)';
  var dst = new Float32Array([ 1, 2, 3, 4 ]); /* ( 0, 1 ) -> Integer Typed Array can NOT be used */
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196, 0.99 ];
  var got = _.color.hsla._strToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got[ i ], expected[ i ] );
  test.true( got === dst );

  test.case = 'hsla(45, 98%, 33%, 11%), dst = VectorAdapte,100%r';
  var src = 'hsla(45, 98%, 33%, 11%)';
  var dst = _.vad.fromLong([ 1, 2, 3, 4 ]);
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196, 0.11 ];
  var got = _.color.hsla._strToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.case = 'hsla(45, 98%, 33%, 100%, 11%) with alpha = 100, dst = Arra';
  var src = 'hsla(45, 98%, 33%, 11%)';
  var dst = [ 1, 2, 3, 4 ];
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196, 0.11 ];
  var got = _.color.hsla._strToRgba( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = 'hsla(45, 98%, 33%, 11%) with alpha = 100, dst = VectorAdapte';
  var src = 'hsla(45, 98%, 33%, 11%)';
  var dst = _.vad.fromLong([ 1, 2, 3, 4 ]);
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196, 0.11 ];
  var got = _.color.hsla._strToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.close( 'non basic colors' );

  /* - */

  test.case = 'dst : Array; dst.length !== 4';
  var src = 'hsla(55, 68%, 55%, 100%)';
  var dst = [ 1, 2, 3, 5, 6 ];
  test.shouldThrowErrorSync( () => _.color.hsla._strToRgba( dst, src ) )

  test.case = 'dst : Long; dst.length !== 4';
  var src = 'hsla(55, 68%, 55%, 100%)';
  var dst = _.longFrom([ 1, 2 ]);
  test.shouldThrowErrorSync( () => _.color.hsla._strToRgba( dst, src ) )

  test.case = 'dst : TypedArray; dst.length !== 4';
  var src = 'hsla(55, 68%, 55%, 100%)';
  var dst = new Float32Array([ 1, 2, 3, 4, 5 ]);
  test.shouldThrowErrorSync( () => _.color.hsla._strToRgba( dst, src ) )

  test.case = 'dst : VectorAdapter; dst.length !== 4';
  var src = 'hsla(55, 68%, 55%, 100%)';
  var dst = _.vad.fromLong([ 1 ]);
  test.shouldThrowErrorSync( () => _.color.hsla._strToRgba( dst, src ) )

}

_strToRgbaWithDst.accuracy = 1e-2;

//

function _longToRgba( test )
{

  test.open( 'basic colors' );

  test.case = 'Black';
  var src = [ 0, 0, 0, 1 ];
  var expected = [ 0, 0, 0, 1 ];
  var got = _.color.hsla._longToRgba( null, src );
  test.equivalent( got, expected );

  test.case = 'White';
  var src = [ 0, 0, 1, 1 ];
  var expected = [ 1, 1, 1, 1 ];
  var got = _.color.hsla._longToRgba( null, src );
  test.equivalent( got, expected );

  test.case = 'Red';
  var src = [ 0, 1, 0.5, 1 ];
  var expected = [ 1, 0, 0, 1 ];
  var got = _.color.hsla._longToRgba( null, src );
  test.equivalent( got, expected );

  test.case = 'Green';
  var src = [ 0.3333333333333333, 1, 0.5, 1 ];
  var expected = [ 0, 1, 0, 1 ];
  var got = _.color.hsla._longToRgba( null, src );
  test.equivalent( got, expected );

  test.case = 'Blue';
  var src = [ 0.6666666666666666, 1, 0.5, 1 ];
  var expected = [ 0, 0, 1, 1 ];
  var got = _.color.hsla._longToRgba( null, src );
  test.equivalent( got, expected );

  test.case = 'Yellow';
  var src = [ 0.1666666666666666, 1, 0.5, 1 ];
  var expected = [ 1, 1, 0, 1 ];
  var got = _.color.hsla._longToRgba( null, src );
  test.equivalent( got, expected );

  test.case = 'Cyan';
  var src = [ 0.5, 1, 0.5, 1 ];
  var expected = [ 0, 1, 1, 1 ];
  var got = _.color.hsla._longToRgba( null, src );
  test.equivalent( got, expected );

  test.case = 'Magenta';
  var src = [ 0.8333333333333333, 1, 0.5, 1 ];
  var expected = [ 1, 0, 1, 1 ];
  var got = _.color.hsla._longToRgba( null, src );
  test.equivalent( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = '[ 0.125, 0.98, 0.33, 0.22 ]';
  var src = [ 0.125, 0.98, 0.33, 0.22 ];
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196, 0.22 ];
  var got = _.color.hsla._longToRgba( null, src );
  test.equivalent( got, expected );

  test.case = '[ 0.4361111111111111, 0.87, 0.53, 0.1 ]';
  var src = [ 0.4361111111111111, 0.87, 0.53, 0.1 ];
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588, 0.1 ];
  var got = _.color.hsla._longToRgba( null, src );
  test.equivalent( got, expected );

  test.case = '[ 0.1527777777777778, 0.68, 0.55, 0.99 ]';
  var src = [ 0.1527777777777778, 0.68, 0.55, 0.99 ];
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981, 0.99 ];
  var got = _.color.hsla._longToRgba( null, src );
  test.equivalent( got, expected );

  test.close( 'non basic colors' );

  test.case = 'first arg > 360';
  var src = [ 1.1, 0.24, 0.15 ];
  var expected = null;
  var got = _.color.hsla._longToRgba( null, src );
  test.identical( got, expected );

  test.case = 'second arg > 100%';
  var src = [ 0.11, 24, 0.15 ];
  var expected = null;
  var got = _.color.hsla._longToRgba( null, src );
  test.identical( got, expected );

  test.case = 'third arg > 100%';
  var src = [ 0.11, 0.24, 15 ];
  var expected = null;
  var got = _.color.hsla._longToRgba( null, src );
  test.identical( got, expected );

}

_longToRgba.accuracy = 1e-2;

//

function _longToRgbaWithDst( test )
{

  test.open( 'basic colors' );

  test.case = 'Black, dst = Array';
  var src = [ 0, 0, 0, 1 ];
  var dst = [ 1, 2, 3, 4 ];
  var expected = [ 0, 0, 0, 1 ];
  var got = _.color.hsla._longToRgba( dst, src );
  test.identical( got, expected );
  test.true( got === dst );

  test.case = 'Green, dst = Long';
  var src = [ 0.3333333333333333, 1, 0.5, 1 ];
  var dst = _.longFrom([ 1, 4, 13, 14 ]);
  var expected = [ 0, 1, 0, 1 ];
  var got = _.color.hsla._longToRgba( dst, src );
  test.identical( got, expected );
  test.true( got === dst );

  test.case = 'Red, dst = TypedArray';
  var src = [ 0, 1, 0.5, 1 ];
  var dst = new I8x([ 1, 5, 15, 11 ]); /* 1 and 0 -> Integer Typed Array can be used */
  var expected = [ 1, 0, 0, 1 ];
  var got = _.color.hsla._longToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.identical( got[ i ], expected[ i ] );
  test.true( got === dst );

  test.case = 'White, dst = VectorAdapter';
  var src = [ 0, 0, 1, 1 ];
  var dst = _.vad.fromLong([ 1, 2, 3, 4 ]);
  var expected = [ 1, 1, 1, 1 ];
  var got = _.color.hsla._longToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.case = 'Black, no alpha, dst = Array';
  var src = [ 0, 0, 0 ];
  var dst = [ 1, 2, 3, 4 ];
  var expected = [ 0, 0, 0, 1 ];
  var got = _.color.hsla._longToRgba( dst, src );
  test.identical( got, expected );
  test.true( got === dst );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = '[ 0.125, 0.98, 0.33, 1 ], dst = Array';
  var src = [ 0.125, 0.98, 0.33, 1 ];
  var dst = [ 1, 2, 3, 4 ];
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196, 1 ];
  var got = _.color.hsla._longToRgba( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = '[ 0.125, 0.98, 0.33, 0.22 ], dst = Long';
  var src = [ 0.125, 0.98, 0.33, 0.22 ];
  var dst = _.longFrom([ 1, 2, 3, 4 ]);
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196, 0.22 ];
  var got = _.color.hsla._longToRgba( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = '[ 0.125, 0.98, 0.33, 0.13 ], dst = TypedArray';
  var src = [ 0.125, 0.98, 0.33, 0.13 ];
  var dst = new Float32Array([ 1, 2, 3, 4 ]); /* ( 0, 1 ) -> Integer Typed Array can NOT be used */
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196, 0.13 ];
  var got = _.color.hsla._longToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got[ i ], expected[ i ] );
  test.true( got === dst );

  test.case = '[ 0.125, 0.98, 0.33, 0.09 ], dst = VectorAdapter';
  var src = [ 0.125, 0.98, 0.33, 0.09 ];
  var dst = _.vad.fromLong([ 1, 2, 3, 4 ]);
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196, 0.09 ];
  var got = _.color.hsla._longToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.close( 'non basic colors' );

  test.case = 'first arg > 360';
  var src = [ 450, 1, 0.5 ]
  var expected = null;
  var got = _.color.hsla._longToRgba( [ 1, 2, 3, 4 ], src );
  test.identical( got, expected );

  test.case = 'second arg > 100%';
  var src = [ 0.45, 102, 0.36 ]
  var expected = null;
  var got = _.color.hsla._longToRgba( [ 1, 2, 3 ], src );
  test.identical( got, expected );

  test.case = 'third arg > 100%';
  var src = [ 0.45, 1, 360 ]
  var expected = null;
  var got = _.color.hsla._longToRgba( [ 1, 2, 3 ], src );
  test.identical( got, expected );

  /* - */

  test.case = 'dst : Array; dst.length !== 4';
  var src = [ 0.125, 0.98, 0.33, 0.13 ];
  var dst = [ 1, 2, 3, 5, 6 ];
  test.shouldThrowErrorSync( () => _.color.hsla._longToRgba( dst, src ) )

  test.case = 'dst : Long; dst.length !== 4';
  var src = [ 0.125, 0.98, 0.33, 0.13 ];
  var dst = _.longFrom([ 1, 2 ]);
  test.shouldThrowErrorSync( () => _.color.hsla._longToRgba( dst, src ) )

  test.case = 'dst : TypedArray; dst.length !== 4';
  var src = [ 0.125, 0.98, 0.33, 0.13 ];
  var dst = new Float32Array([ 1, 2, 3, 4, 5 ]);
  test.shouldThrowErrorSync( () => _.color.hsla._longToRgba( dst, src ) )

  test.case = 'dst : VectorAdapter; dst.length !== 4';
  var src = [ 0.125, 0.98, 0.33, 0.13 ];
  var dst = _.vad.fromLong([ 1 ]);
  test.shouldThrowErrorSync( () => _.color.hsla._longToRgba( dst, src ) )

}

_longToRgbaWithDst.accuracy = 1e-2;

//

function _validate( test )
{

  test.case = 'normal 3 elements';
  var src = [ 11, 16, 75 ];
  var expected = true;
  var got = _.color.hsla._validate( src );
  test.identical( got, expected );

  test.case = 'normal 4 elements';
  var src = [ 11, 16, 75, 40 ];
  var expected = true;
  var got = _.color.hsla._validate( src );
  test.identical( got, expected );

  test.case = 'first arg > 360';
  var src = [ 1111, 16, 75 ];
  var expected = false;
  var got = _.color.hsla._validate( src );
  test.identical( got, expected );

  test.case = 'first arg < 0';
  var src = [ -111, 16, 75 ];
  var expected = false;
  var got = _.color.hsla._validate( src );
  test.identical( got, expected );

  test.case = 'second arg > 100';
  var src = [ 11, 160, 75 ];
  var expected = false;
  var got = _.color.hsla._validate( src );
  test.identical( got, expected );

  test.case = 'second arg < 0';
  var src = [ 11, -160, 75 ];
  var expected = false;
  var got = _.color.hsla._validate( src );
  test.identical( got, expected );

  test.case = 'third arg > 100';
  var src = [ 11, 16, 750 ];
  var expected = false;
  var got = _.color.hsla._validate( src );
  test.identical( got, expected );

  test.case = 'third arg < 0';
  var src = [ 11, 16, -750 ];
  var expected = false;
  var got = _.color.hsla._validate( src );
  test.identical( got, expected );

}

//

function _formatStringParse( test )
{
  test.case = 'normal 3';
  var src = 'hsla(0,0%,100%,100%)';
  var expected = [ 0, 0, 100, 100 ];
  var got = _.color.hsla._formatStringParse( src );
  test.identical( got, expected );

  test.case = 'normal spaces 3';
  var src = 'hsla(0, 0%, 100%)';
  var expected = [ 0, 0, 100 ];
  var got = _.color.hsla._formatStringParse( src );
  test.identical( got, expected );

  test.case = 'normal 4';
  var src = 'hsla(0,0%,0%,100%)';
  var expected = [ 0, 0, 0, 100 ];
  var got = _.color.hsla._formatStringParse( src );
  test.identical( got, expected );

  test.case = 'normal spaces 4';
  var src = 'hsla(0, 0%, 0%, 100%)';
  var expected = [ 0, 0, 0, 100 ];
  var got = _.color.hsla._formatStringParse( src );
  test.identical( got, expected );

  test.case = 'wrong format';
  var src = 'hwba(0,0%,0%)';
  test.shouldThrowErrorSync( () => _.color.hsla._formatStringParse( src ) );

  test.case = 'redundant channel';
  var src = 'hsla(0,0%,0%,0%,100%,100%)';
  test.shouldThrowErrorSync( () => _.color.hsla._formatStringParse( src ) );

  test.case = 'without \'%\'';
  var src = 'hsla(0,0,0%,100%)';
  test.shouldThrowErrorSync( () => _.color.hsla._formatStringParse( src ) );

  test.case = 'more than 3 digits \'%\'';
  var src = 'hsla(0,0%,1000%,100%)';
  test.shouldThrowErrorSync( () => _.color.hsla._formatStringParse( src ) );
}


// --
// declare
// --

const Proto =
{

  name : 'Tools/mid/Hsla',
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
