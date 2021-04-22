( function _Xyza_test_s_( )
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
  var src = 'xyza(0,0,0,100%)';
  var expected = [ 0, 0, 0, 1 ];
  var got = _.color.xyza._strToRgba( null, src );
  test.equivalent( got, expected );

  test.case = 'White';
  var src = 'xyza(95.0500, 100.0000, 108.9000, 100%)';
  var expected = [ 1, 1, 1, 1 ];
  var got = _.color.xyza._strToRgba( null, src );
  test.equivalent( got, expected );

  test.case = 'Red';
  var src = 'xyza(41.2400, 21.2600, 1.9300, 100%)';
  var expected = [ 1, 0, 0, 1 ];
  var got = _.color.xyza._strToRgba( null, src );
  test.equivalent( got, expected );

  test.case = 'Green';
  var src = 'xyza(35.7600, 71.5200, 11.9200, 100%)';
  var expected = [ 0, 1, 0, 1 ];
  var got = _.color.xyza._strToRgba( null, src );
  test.equivalent( got, expected );

  test.case = 'Blue';
  var src = 'xyza(18.0500, 7.2200, 95.0500, 100%)';
  var expected = [ 0, 0, 1, 1 ];
  var got = _.color.xyza._strToRgba( null, src );
  test.equivalent( got, expected );

  test.case = 'Yellow';
  var src = 'xyza(77.0000, 92.7800, 13.8500, 100%)';
  var expected = [ 1, 1, 0, 1 ];
  var got = _.color.xyza._strToRgba( null, src );
  test.equivalent( got, expected );

  test.case = 'Cyan';
  var src = 'xyza(53.8100, 78.7400, 106.9700, 100%)';
  var expected = [ 0, 1, 1, 1 ];
  var got = _.color.xyza._strToRgba( null, src );
  test.equivalent( got, expected );

  test.case = 'Magenta';
  var src = 'xyza(59.2900, 28.4800, 96.9800, 100%)';
  var expected = [ 1, 0, 1, 1 ];
  var got = _.color.xyza._strToRgba( null, src );
  test.equivalent( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = 'xyza(23.0303, 22.3858, 3.1645, 22%)';
  var src = 'xyza(23.0303, 22.3858, 3.1645, 22%)';
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196, 0.22 ];
  var got = _.color.xyza._strToRgba( null, src );
  test.equivalent( got, expected );

  test.case = 'xyza(38.2467, 65.2201, 44.7554, 13%)';
  var src = 'xyza(38.2467, 65.2201, 44.7554, 13%)';
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588, 0.13 ];
  var got = _.color.xyza._strToRgba( null, src );
  test.equivalent( got, expected );

  test.case = 'xyza(51.8271, 59.3850, 13.1457, 99%)';
  var src = 'xyza(51.8271, 59.3850, 13.1457, 99%)';
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981, 0.99 ];
  var got = _.color.xyza._strToRgba( null, src );
  test.equivalent( got, expected );

  test.case = 'xyza(51.8271, 59.3850, 13.1457) without alpha';
  var src = 'xyza(51.8271, 59.3850, 13.1457)';
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981, 1 ];
  var got = _.color.xyza._strToRgba( null, src );
  test.equivalent( got, expected );

  test.close( 'non basic colors' );

  test.case = 'first arg < 0';
  var src = 'xyza(-1, 59.3850, 13.1457)';
  test.shouldThrowErrorSync( () => _.color.xyza._strToRgba( null, src ) )

  test.case = 'second arg < 0';
  var src = 'xyza(51.8271, -59.3850, 13.1457)';
  test.shouldThrowErrorSync( () => _.color.xyza._strToRgba( null, src ) )

  test.case = 'third arg < 0';
  var src = 'xyza(51.8271, 59.3850, -13.1457)';
  test.shouldThrowErrorSync( () => _.color.xyza._strToRgba( null, src ) )

}

_strToRgba.accuracy = 1e-2;

//

function _strToRgbaWithDst( test )
{

  test.open( 'basic colors' );

  test.case = 'Black, dst = Array';
  var src = 'xyza(0,0,0,100%)';
  var dst = [ 1, 2, 3, 4 ];
  var expected = [ 0, 0, 0, 1 ];
  var got = _.color.xyza._strToRgba( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = 'Green, dst = Long';
  var src = 'xyza(35.7600, 71.5200, 11.9200, 100%)';
  var dst = _.longFrom([ 1, 4, 13, 14 ]);
  var expected = [ 0, 1, 0, 1 ];
  var got = _.color.xyza._strToRgba( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = 'Red, dst = TypedArray';
  var src = 'xyza(41.2400, 21.2600, 1.9300, 100%)';
  var dst = new Float32Array([ 1, 5, 15, 1 ]); /* ( 0, 1 ) -> Integer Typed Array can NOT be used */
  var expected = [ 1, 0, 0, 1 ];
  var got = _.color.xyza._strToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got[ i ], expected[ i ] );
  test.true( got === dst );

  test.case = 'White, dst = VectorAdapter';
  var src = 'xyza(95.0500, 100.0000, 108.9000, 100%)';
  var dst = _.vad.fromLong([ 1, 2, 3, 4 ]);
  var expected = [ 1, 1, 1, 1 ];
  var got = _.color.xyza._strToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = 'xyza(23.0303, 22.3858, 3.1645, 22%), dst = Array';
  var src = 'xyza(23.0303, 22.3858, 3.1645, 22%)';
  var dst = [ 1, 2, 3, 4 ];
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196, 0.22 ];
  var got = _.color.xyza._strToRgba( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = 'xyza(23.0303, 22.3858, 3.1645, 5%), dst = Long';
  var src = 'xyza(23.0303, 22.3858, 3.1645, 5%)';
  var dst = _.longFrom([ 1, 2, 3, 4 ]);
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196, 0.05 ];
  var got = _.color.xyza._strToRgba( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = 'xyza(23.0303, 22.3858, 3.1645, 29%), dst = TypedArray';
  var src = 'xyza(23.0303, 22.3858, 3.1645, 29%)';
  var dst = new Float32Array([ 1, 2, 3, 4 ]); /* ( 0, 1 ) -> Integer Typed Array can NOT be used */
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196, 0.29 ];
  var got = _.color.xyza._strToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got[ i ], expected[ i ] );
  test.true( got === dst );

  test.case = 'xyza(23.0303, 22.3858, 3.1645, 29%), dst = VectorAdapter';
  var src = 'xyza(23.0303, 22.3858, 3.1645, 29%)';
  var dst = _.vad.fromLong([ 1, 2, 3, 4 ]);
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196, 0.29 ];
  var got = _.color.xyza._strToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.case = 'xyza(23.0303, 22.3858, 3.1645) without alpha, dst = Array';
  var src = 'xyza(23.0303, 22.3858, 3.1645)';
  var dst = [ 1, 2, 3, 4 ];
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196, 1 ];
  var got = _.color.xyza._strToRgba( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = 'xyza(23.0303, 22.3858, 3.1645) without alpha, dst = VectorAdapter';
  var src = 'xyza(23.0303, 22.3858, 3.1645)';
  var dst = _.vad.fromLong([ 1, 2, 3, 4 ]);
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196, 1 ];
  var got = _.color.xyza._strToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.close( 'non basic colors' );

  /* - */

  test.case = 'dst : Array; dst.length !== 4';
  var src = 'xyza(23.0303, 22.3858, 3.1645, 22%)';
  var dst = [ 1, 2, 3, 5, 6 ];
  test.shouldThrowErrorSync( () => _.color.xyza._strToRgba( dst, src ) )

  test.case = 'dst : Long; dst.length !== 4';
  var src = 'xyza(23.0303, 22.3858, 3.1645, 22%)';
  var dst = _.longFrom([ 1, 2 ]);
  test.shouldThrowErrorSync( () => _.color.xyza._strToRgba( dst, src ) )

  test.case = 'dst : TypedArray; dst.length !== 4';
  var src = 'xyza(23.0303, 22.3858, 3.1645, 22%)';
  var dst = new Float32Array([ 1, 2, 3 ]);
  test.shouldThrowErrorSync( () => _.color.xyza._strToRgba( dst, src ) )

  test.case = 'dst : VectorAdapter; dst.length !== 4';
  var src = 'xyza(23.0303, 22.3858, 3.1645, 22%)';
  var dst = _.vad.fromLong([ 1 ]);
  test.shouldThrowErrorSync( () => _.color.xyza._strToRgba( dst, src ) )

}

_strToRgbaWithDst.accuracy = 1e-2;

//

function _longToRgba( test )
{

  test.open( 'basic colors' );

  test.case = 'Black';
  var src = [ 0, 0, 0, 1 ];
  var expected = [ 0, 0, 0, 1 ];
  var got = _.color.xyza._longToRgba( null, src );
  test.equivalent( got, expected );

  test.case = 'White';
  var src = [ 95.0500/100, 100.0000/100, 108.9000/100, 1 ];
  var expected = [ 1, 1, 1, 1 ];
  var got = _.color.xyza._longToRgba( null, src );
  test.equivalent( got, expected );

  test.case = 'Red';
  var src = [ 41.2400/100, 21.2600/100, 1.9300/100, 1 ];
  var expected = [ 1, 0, 0, 1 ];
  var got = _.color.xyza._longToRgba( null, src );
  test.equivalent( got, expected );

  test.case = 'Green';
  var src = [ 35.7600/100, 71.5200/100, 11.9200/100, 1 ];
  var expected = [ 0, 1, 0, 1 ];
  var got = _.color.xyza._longToRgba( null, src );
  test.equivalent( got, expected );

  test.case = 'Blue';
  var src = [ 18.0500/100, 7.2200/100, 95.0500/100, 1 ];
  var expected = [ 0, 0, 1, 1 ];
  var got = _.color.xyza._longToRgba( null, src );
  test.equivalent( got, expected );

  test.case = 'Yellow';
  var src = [ 77.0000/100, 92.7800/100, 13.8500/100, 1 ];
  var expected = [ 1, 1, 0, 1 ];
  var got = _.color.xyza._longToRgba( null, src );
  test.equivalent( got, expected );

  test.case = 'Cyan';
  var src = [ 53.8100/100, 78.7400/100, 106.9700/100, 1 ];
  var expected = [ 0, 1, 1, 1 ];
  var got = _.color.xyza._longToRgba( null, src );
  test.equivalent( got, expected );

  test.case = 'Magenta';
  var src = [ 59.2900/100, 28.4800/100, 96.9800/100, 1 ];
  var expected = [ 1, 0, 1, 1 ];
  var got = _.color.xyza._longToRgba( null, src );
  test.equivalent( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = '[ 23.0303/100, 22.3858/100, 3.1645/100, 0.22 ]';
  var src = [ 23.0303/100, 22.3858/100, 3.1645/100, 0.22 ];
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196, 0.22 ];
  var got = _.color.xyza._longToRgba( null, src );
  test.equivalent( got, expected );

  test.case = '[ 38.2467/100, 65.2201/100, 44.7554/100, 0.05 ]';
  var src = [ 38.2467/100, 65.2201/100, 44.7554/100, 0.05 ];
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588, 0.05 ];
  var got = _.color.xyza._longToRgba( null, src );
  test.equivalent( got, expected );

  test.case = '[ 51.8271/100, 59.3850/100, 13.1457/100, 0.05 ]';
  var src = [ 51.8271/100, 59.3850/100, 13.1457/100, 0.05 ];
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981, 0.05 ];
  var got = _.color.xyza._longToRgba( null, src );
  test.equivalent( got, expected );

  test.case = '[ 51.8271/100, 59.3850/100, 13.1457/100 ] without alpha ';
  var src = [ 51.8271/100, 59.3850/100, 13.1457/100 ];
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981, 1 ];
  var got = _.color.xyza._longToRgba( null, src );
  test.equivalent( got, expected );

  test.close( 'non basic colors' );

  test.case = 'first arg < 1';
  var src = [ -1, 0.5, 0.5, 0.8 ];
  var expected = null;
  var got = _.color.xyza._longToRgba( null, src );
  test.identical( got, expected );

  test.case = 'second arg < 1';
  var src = [ 0.2, -5, 0.5, 0.8 ];
  var expected = null;
  var got = _.color.xyza._longToRgba( null, src );
  test.identical( got, expected );

  test.case = 'third arg < 1';
  var src = [ 0.2, 0.5, -1.1, 0.8 ];
  var expected = null;
  var got = _.color.xyza._longToRgba( null, src );
  test.identical( got, expected );

}

_longToRgba.accuracy = 1e-2;

//

function _longToRgbaWithDst( test )
{

  test.open( 'basic colors' );

  test.case = 'Black, dst = Array';
  var src = [ 0, 0, 0, 1 ];
  var dst = [ 1, 2, 3, 1 ];
  var expected = [ 0, 0, 0, 1 ];
  var got = _.color.xyza._longToRgba( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = 'Green, dst = Long';
  var src = [ 35.7600/100, 71.5200/100, 11.9200/100, 1 ];
  var dst = _.longFrom([ 1, 4, 13, 14 ]);
  var expected = [ 0, 1, 0, 1 ];
  var got = _.color.xyza._longToRgba( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = 'Red, dst = TypedArray';
  var src = [ 41.2400/100, 21.2600/100, 1.9300/100, 1 ];
  var dst = new Float32Array([ 1, 5, 15, 16 ]); /* ( 0, 1 ) -> Integer Typed Array can NOT be used */
  var expected = [ 1, 0, 0, 1 ];
  var got = _.color.xyza._longToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got[ i ], expected[ i ] );
  test.true( got === dst );

  test.case = 'White, dst = VectorAdapter';
  var src = [ 95.0500/100, 100.0000/100, 108.9000/100, 1 ];
  var dst = _.vad.fromLong([ 1, 2, 3, 4 ]);
  var expected = [ 1, 1, 1, 1 ];
  var got = _.color.xyza._longToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = '[ 23.0303/100, 22.3858/100, 3.1645/100, 0.22 ], dst = Array';
  var src = [ 23.0303/100, 22.3858/100, 3.1645/100, 0.22 ];
  var dst = [ 1, 2, 3, 4 ];
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196, 0.22 ];
  var got = _.color.xyza._longToRgba( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = '[ 23.0303/100, 22.3858/100, 3.1645/100, 0.01 ], dst = Long';
  var src = [ 23.0303/100, 22.3858/100, 3.1645/100, 0.01 ];
  var dst = _.longFrom([ 1, 2, 3, 4 ]);
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196, 0.01 ];
  var got = _.color.xyza._longToRgba( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = '[ 23.0303/100, 22.3858/100, 3.1645/100, 0.01 ], dst = TypedArray';
  var src = [ 23.0303/100, 22.3858/100, 3.1645/100, 0.01 ];
  var dst = new Float32Array([ 1, 2, 3, 4 ]); /* ( 0, 1 ) -> Integer Typed Array can NOT be used */
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196, 0.01 ];
  var got = _.color.xyza._longToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got[ i ], expected[ i ] );
  test.true( got === dst );

  test.case = '[ 23.0303/100, 22.3858/100, 3.1645/100, 0.01 ], dst = VectorAdapter';
  var src = [ 23.0303/100, 22.3858/100, 3.1645/100, 0.01 ];
  var dst = _.vad.fromLong([ 1, 2, 3, 4 ]);
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196, 0.01 ];
  var got = _.color.xyza._longToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.case = '[ 23.0303/100, 22.3858/100, 3.1645/100 ] without alpha, dst = Array';
  var src = [ 23.0303/100, 22.3858/100, 3.1645/100 ];
  var dst = [ 1, 2, 3, 4 ];
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196, 1 ];
  var got = _.color.xyza._longToRgba( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = '[ 23.0303/100, 22.3858/100, 3.1645/100 ] without alpha, dst = VectorAdapter';
  var src = [ 23.0303/100, 22.3858/100, 3.1645/100 ];
  var dst = _.vad.fromLong([ 1, 2, 3, 4 ]);
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196, 1 ];
  var got = _.color.xyza._longToRgba( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.close( 'non basic colors' );

  test.case = 'first arg < 0';
  var src = [ -4.5, 0.9, 0.36 ]
  var expected = null;
  var got = _.color.xyza._longToRgba( [ 1, 2, 3, 4 ], src );
  test.identical( got, expected );

  test.case = 'second arg < 0';
  var src = [ 0.45, -9, 0.36 ]
  var expected = null;
  var got = _.color.xyza._longToRgba( [ 1, 2, 3 ], src );
  test.identical( got, expected );

  test.case = 'third arg < 0';
  var src = [ 0.45, 0.9, -1.2 ]
  var expected = null;
  var got = _.color.xyza._longToRgba( [ 1, 2, 3 ], src );
  test.identical( got, expected );

  /* - */

  test.case = 'dst : Array; dst.length !== 4';
  var src = [ 0.45, 0.45, 0.45 ];
  var dst = [ 1, 2, 3, 5, 6 ];
  test.shouldThrowErrorSync( () => _.color.xyza._longToRgba( dst, src ) )

  test.case = 'dst : Long; dst.length !== 4';
  var src = [ 0.45, 0.45, 0.45 ];
  var dst = _.longFrom([ 1, 2 ]);
  test.shouldThrowErrorSync( () => _.color.xyza._longToRgba( dst, src ) )

  test.case = 'dst : TypedArray; dst.length !== 4';
  var src = [ 0.45, 0.45, 0.45 ];
  var dst = new Float32Array([ 1, 2, 3 ]);
  test.shouldThrowErrorSync( () => _.color.xyza._longToRgba( dst, src ) )

  test.case = 'dst : VectorAdapter; dst.length !== 4';
  var src = [ 0.45, 0.45, 0.45 ];
  var dst = _.vad.fromLong([ 1 ]);
  test.shouldThrowErrorSync( () => _.color.xyza._longToRgba( dst, src ) )

}

_longToRgbaWithDst.accuracy = 1e-2;

//

function _validate( test )
{

  test.case = 'normal 3 elements';
  var src = [ 11, 16, 75 ];
  var expected = true;
  var got = _.color.xyza._validate( src );
  test.identical( got, expected );

  test.case = 'normal 4 elements';
  var src = [ 11, 16, 75, 100 ];
  var expected = true;
  var got = _.color.xyza._validate( src );
  test.identical( got, expected );

  test.case = 'first arg < 0';
  var src = [ -1, 16, 75 ];
  var expected = false;
  var got = _.color.xyza._validate( src );
  test.identical( got, expected );

  test.case = 'second arg < 0';
  var src = [ 11, -160, 75 ];
  var expected = false;
  var got = _.color.xyza._validate( src );
  test.identical( got, expected );

  test.case = 'third arg < 0';
  var src = [ 11, 16, -750 ];
  var expected = false;
  var got = _.color.xyza._validate( src );
  test.identical( got, expected );

}

//

function _formatStringParse( test )
{
  test.case = 'normal 3';
  var src = 'xyza(0,0,100)';
  var expected = [ 0, 0, 100 ];
  var got = _.color.xyza._formatStringParse( src );
  test.identical( got, expected );

  test.case = 'normal spaces 3';
  var src = 'xyza(0, 0, 100)';
  var expected = [ 0, 0, 100 ];
  var got = _.color.xyza._formatStringParse( src );
  test.identical( got, expected );

  test.case = 'normal 4';
  var src = 'xyza(0,0,0,100%)';
  var expected = [ 0, 0, 0, 100 ];
  var got = _.color.xyza._formatStringParse( src );
  test.identical( got, expected );

  test.case = 'normal spaces 4';
  var src = 'xyza(0, 0, 0, 100%)';
  var expected = [ 0, 0, 0, 100 ];
  var got = _.color.xyza._formatStringParse( src );
  test.identical( got, expected );

  test.case = 'wrong format';
  var src = 'hwba(0,0,0)';
  test.shouldThrowErrorSync( () => _.color.xyza._formatStringParse( src ) );

  test.case = 'redundant channel';
  var src = 'xyza(0,0,0,0%,100)';
  test.shouldThrowErrorSync( () => _.color.xyza._formatStringParse( src ) );

  test.case = 'second channel with \'%\'';
  var src = 'xyza(0,0%,0)';
  test.shouldThrowErrorSync( () => _.color.xyza._formatStringParse( src ) );

}


// --
// declare
// --

let Self =
{

  name : 'Tools/mid/Xyza',
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
