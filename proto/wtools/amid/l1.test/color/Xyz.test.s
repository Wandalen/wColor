( function _Xyz_test_s_( )
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
  var src = 'xyz(0,0,0)';
  var expected = [ 0, 0, 0 ];
  var got = _.color.xyz._strToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'White';
  var src = 'xyz(95.0500, 100.0000, 108.9000)';
  var expected = [ 1, 1, 1 ];
  var got = _.color.xyz._strToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'Red';
  var src = 'xyz(41.2400, 21.2600, 1.9300)';
  var expected = [ 1, 0, 0 ];
  var got = _.color.xyz._strToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'Green';
  var src = 'xyz(35.7600, 71.5200, 11.9200)';
  var expected = [ 0, 1, 0 ];
  var got = _.color.xyz._strToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'Blue';
  var src = 'xyz(18.0500, 7.2200, 95.0500)';
  var expected = [ 0, 0, 1 ];
  var got = _.color.xyz._strToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'Yellow';
  var src = 'xyz(77.0000, 92.7800, 13.8500)';
  var expected = [ 1, 1, 0 ];
  var got = _.color.xyz._strToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'Cyan';
  var src = 'xyz(53.8100, 78.7400, 106.9700)';
  var expected = [ 0, 1, 1 ];
  var got = _.color.xyz._strToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'Magenta';
  var src = 'xyz(59.2900, 28.4800, 96.9800)';
  var expected = [ 1, 0, 1 ];
  var got = _.color.xyz._strToRgb( null, src );
  test.equivalent( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = 'xyz(23.0303, 22.3858, 3.1645)';
  var src = 'xyz(23.0303, 22.3858, 3.1645)';
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.xyz._strToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'xyz(38.2467, 65.2201, 44.7554)';
  var src = 'xyz(38.2467, 65.2201, 44.7554)';
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588 ];
  var got = _.color.xyz._strToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'xyz(51.8271, 59.3850, 13.1457)';
  var src = 'xyz(51.8271, 59.3850, 13.1457)';
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981 ];
  var got = _.color.xyz._strToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'xyz(51.8271, 59.3850, 13.1457, 100%) with alpha = 100%';
  var src = 'xyz(51.8271, 59.3850, 13.1457, 100%)';
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981 ];
  var got = _.color.xyz._strToRgb( null, src );
  test.equivalent( got, expected );

  test.close( 'non basic colors' );

  test.case = 'first arg < 0';
  var src = 'xyz(-1, 59.3850, 13.1457)';
  test.shouldThrowErrorSync( () => _.color.xyz._strToRgb( null, src ) )

  test.case = 'second arg < 0';
  var src = 'xyz(51.8271, -59.3850, 13.1457)';
  test.shouldThrowErrorSync( () => _.color.xyz._strToRgb( null, src ) )

  test.case = 'third arg < 0';
  var src = 'xyz(51.8271, 59.3850, -13.1457)';
  test.shouldThrowErrorSync( () => _.color.xyz._strToRgb( null, src ) )

  test.case = 'alpha !== 100%';
  var src = 'xyz(51.8271, 59.3850, 13.1457, 99%)';
  test.shouldThrowErrorSync( () => _.color.xyz._strToRgb( null, src ) )

}

_strToRgb.accuracy = 1e-2;

//

function _strToRgbWithDst( test )
{

  test.open( 'basic colors' );

  test.case = 'Black, dst = Array';
  var src = 'xyz(0,0,0)';
  var dst = [ 1, 2, 3 ];
  var expected = [ 0, 0, 0 ];
  var got = _.color.xyz._strToRgb( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = 'Green, dst = Long';
  var src = 'xyz(35.7600, 71.5200, 11.9200)';
  var dst = _.longFrom([ 1, 4, 13 ]);
  var expected = [ 0, 1, 0 ];
  var got = _.color.xyz._strToRgb( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = 'Red, dst = TypedArray';
  var src = 'xyz(41.2400, 21.2600, 1.9300)';
  var dst = new Float32Array([ 1, 5, 15 ]); /* ( 0, 1 ) -> Integer Typed Array can NOT be used */
  var expected = [ 1, 0, 0 ];
  var got = _.color.xyz._strToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got[ i ], expected[ i ] );
  test.true( got === dst );

  test.case = 'White, dst = VectorAdapter';
  var src = 'xyz(95.0500, 100.0000, 108.9000)';
  var dst = _.vad.fromLong([ 1, 2, 3 ]);
  var expected = [ 1, 1, 1 ];
  var got = _.color.xyz._strToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = 'xyz(23.0303, 22.3858, 3.1645), dst = Array';
  var src = 'xyz(23.0303, 22.3858, 3.1645)';
  var dst = [ 1, 2, 3 ];
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.xyz._strToRgb( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = 'xyz(23.0303, 22.3858, 3.1645), dst = Long';
  var src = 'xyz(23.0303, 22.3858, 3.1645)';
  var dst = _.longFrom([ 1, 2, 3 ]);
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.xyz._strToRgb( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = 'xyz(23.0303, 22.3858, 3.1645), dst = TypedArray';
  var src = 'xyz(23.0303, 22.3858, 3.1645)';
  var dst = new Float32Array([ 1, 2, 3 ]); /* ( 0, 1 ) -> Integer Typed Array can NOT be used */
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.xyz._strToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got[ i ], expected[ i ] );
  test.true( got === dst );

  test.case = 'xyz(23.0303, 22.3858, 3.1645), dst = VectorAdapter';
  var src = 'xyz(23.0303, 22.3858, 3.1645)';
  var dst = _.vad.fromLong([ 1, 2, 3 ]);
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.xyz._strToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.case = 'xyz(23.0303, 22.3858, 3.1645, 100%) with alpha = 100, dst = Array';
  var src = 'xyz(23.0303, 22.3858, 3.1645, 100%)';
  var dst = [ 1, 2, 3 ];
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.xyz._strToRgb( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = 'xyz(23.0303, 22.3858, 3.1645, 100%) with alpha = 100, dst = VectorAdapter';
  var src = 'xyz(23.0303, 22.3858, 3.1645, 100%)';
  var dst = _.vad.fromLong([ 1, 2, 3 ]);
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.xyz._strToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.close( 'non basic colors' );

  /* - */

  test.case = 'dst : Array; dst.length !== 3';
  var src = 'xyz(23.0303, 22.3858, 3.1645)';
  var dst = [ 1, 2, 3, 5, 6 ];
  test.shouldThrowErrorSync( () => _.color.xyz._strToRgb( dst, src ) )

  test.case = 'dst : Long; dst.length !== 3';
  var src = 'xyz(23.0303, 22.3858, 3.1645)';
  var dst = _.longFrom([ 1, 2 ]);
  test.shouldThrowErrorSync( () => _.color.xyz._strToRgb( dst, src ) )

  test.case = 'dst : TypedArray; dst.length !== 3';
  var src = 'xyz(23.0303, 22.3858, 3.1645)';
  var dst = new Float32Array([ 1, 2, 3, 4 ]);
  test.shouldThrowErrorSync( () => _.color.xyz._strToRgb( dst, src ) )

  test.case = 'dst : VectorAdapter; dst.length !== 3';
  var src = 'xyz(23.0303, 22.3858, 3.1645)';
  var dst = _.vad.fromLong([ 1 ]);
  test.shouldThrowErrorSync( () => _.color.xyz._strToRgb( dst, src ) )

}

_strToRgbWithDst.accuracy = 1e-2;

//

function _longToRgb( test )
{

  test.open( 'basic colors' );

  test.case = 'Black';
  var src = [ 0, 0, 0 ];
  var expected = [ 0, 0, 0 ];
  var got = _.color.xyz._longToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'White';
  var src = [ 95.0500/100, 100.0000/100, 108.9000/100 ];
  var expected = [ 1, 1, 1 ];
  var got = _.color.xyz._longToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'Red';
  var src = [ 41.2400/100, 21.2600/100, 1.9300/100 ];
  var expected = [ 1, 0, 0 ];
  var got = _.color.xyz._longToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'Green';
  var src = [ 35.7600/100, 71.5200/100, 11.9200/100 ];
  var expected = [ 0, 1, 0 ];
  var got = _.color.xyz._longToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'Blue';
  var src = [ 18.0500/100, 7.2200/100, 95.0500/100 ];
  var expected = [ 0, 0, 1 ];
  var got = _.color.xyz._longToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'Yellow';
  var src = [ 77.0000/100, 92.7800/100, 13.8500/100 ];
  var expected = [ 1, 1, 0 ];
  var got = _.color.xyz._longToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'Cyan';
  var src = [ 53.8100/100, 78.7400/100, 106.9700/100 ];
  var expected = [ 0, 1, 1 ];
  var got = _.color.xyz._longToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'Magenta';
  var src = [ 59.2900/100, 28.4800/100, 96.9800/100 ];
  var expected = [ 1, 0, 1 ];
  var got = _.color.xyz._longToRgb( null, src );
  test.equivalent( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = '[ 23.0303/100, 22.3858/100, 3.1645/100 ]';
  var src = [ 23.0303/100, 22.3858/100, 3.1645/100 ];
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.xyz._longToRgb( null, src );
  test.equivalent( got, expected );

  test.case = '[ 38.2467/100, 65.2201/100, 44.7554/100 ]';
  var src = [ 38.2467/100, 65.2201/100, 44.7554/100 ];
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588 ];
  var got = _.color.xyz._longToRgb( null, src );
  test.equivalent( got, expected );

  test.case = '[ 51.8271/100, 59.3850/100, 13.1457/100 ]';
  var src = [ 51.8271/100, 59.3850/100, 13.1457/100 ];
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981 ];
  var got = _.color.xyz._longToRgb( null, src );
  test.equivalent( got, expected );

  test.case = '[ 51.8271/100, 59.3850/100, 13.1457/100, 1 ] with alpha = 1';
  var src = [ 51.8271/100, 59.3850/100, 13.1457/100, 1 ];
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981 ];
  var got = _.color.xyz._longToRgb( null, src );
  test.equivalent( got, expected );

  test.close( 'non basic colors' );

  test.case = 'first arg < 1';
  var src = [ -1, 0.5, 0.5 ];
  var expected = null;
  var got = _.color.xyz._longToRgb( null, src );
  test.identical( got, expected );

  test.case = 'second arg < 1';
  var src = [ 0.2, -5, 0.5 ];
  var expected = null;
  var got = _.color.xyz._longToRgb( null, src );
  test.identical( got, expected );

  test.case = 'third arg < 1';
  var src = [ 0.2, 0.5, -1.1 ];
  var expected = null;
  var got = _.color.xyz._longToRgb( null, src );
  test.identical( got, expected );

}

_longToRgb.accuracy = 1e-2;

//

function _longToRgbWithDst( test )
{

  test.open( 'basic colors' );

  test.case = 'Black, dst = Array';
  var src = [ 0, 0, 0 ]
  var dst = [ 1, 2, 3 ];
  var expected = [ 0, 0, 0 ];
  var got = _.color.xyz._longToRgb( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = 'Green, dst = Long';
  var src = [ 35.7600/100, 71.5200/100, 11.9200/100 ];
  var dst = _.longFrom([ 1, 4, 13 ]);
  var expected = [ 0, 1, 0 ];
  var got = _.color.xyz._longToRgb( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = 'Red, dst = TypedArray';
  var src = [ 41.2400/100, 21.2600/100, 1.9300/100 ];
  var dst = new Float32Array([ 1, 5, 15 ]); /* ( 0, 1 ) -> Integer Typed Array can NOT be used */
  var expected = [ 1, 0, 0 ];
  var got = _.color.xyz._longToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got[ i ], expected[ i ] );
  test.true( got === dst );

  test.case = 'White, dst = VectorAdapter';
  var src = [ 95.0500/100, 100.0000/100, 108.9000/100 ];
  var dst = _.vad.fromLong([ 1, 2, 3 ]);
  var expected = [ 1, 1, 1 ];
  var got = _.color.xyz._longToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = '[ 23.0303/100, 22.3858/100, 3.1645/100 ], dst = Array';
  var src = [ 23.0303/100, 22.3858/100, 3.1645/100 ];
  var dst = [ 1, 2, 3 ];
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.xyz._longToRgb( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = '[ 23.0303/100, 22.3858/100, 3.1645/100 ], dst = Long';
  var src = [ 23.0303/100, 22.3858/100, 3.1645/100 ];
  var dst = _.longFrom([ 1, 2, 3 ]);
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.xyz._longToRgb( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = '[ 23.0303/100, 22.3858/100, 3.1645/100 ], dst = TypedArray';
  var src = [ 23.0303/100, 22.3858/100, 3.1645/100 ];
  var dst = new Float32Array([ 1, 2, 3 ]); /* ( 0, 1 ) -> Integer Typed Array can NOT be used */
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.xyz._longToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got[ i ], expected[ i ] );
  test.true( got === dst );

  test.case = '[ 23.0303/100, 22.3858/100, 3.1645/100 ], dst = VectorAdapter';
  var src = [ 23.0303/100, 22.3858/100, 3.1645/100 ];
  var dst = _.vad.fromLong([ 1, 2, 3 ]);
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.xyz._longToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.case = '[ 23.0303/100, 22.3858/100, 3.1645/100, 1 ] with alpha = 100, dst = Array';
  var src = [ 23.0303/100, 22.3858/100, 3.1645/100, 1 ];
  var dst = [ 1, 2, 3 ];
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.xyz._longToRgb( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = '[ 23.0303/100, 22.3858/100, 3.1645/100, 1 ] with alpha = 100, dst = VectorAdapter';
  var src = [ 23.0303/100, 22.3858/100, 3.1645/100, 1 ];
  var dst = _.vad.fromLong([ 1, 2, 3 ]);
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.xyz._longToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.close( 'non basic colors' );

  test.case = 'first arg < 0';
  var src = [ -4.5, 0.9, 0.36 ]
  var expected = null;
  var got = _.color.xyz._longToRgb( [ 1, 2, 3, 4 ], src );
  test.identical( got, expected );

  test.case = 'second arg < 0';
  var src = [ 0.45, -9, 0.36 ]
  var expected = null;
  var got = _.color.xyz._longToRgb( [ 1, 2, 3 ], src );
  test.identical( got, expected );

  test.case = 'third arg < 0';
  var src = [ 0.45, 0.9, -1.2 ]
  var expected = null;
  var got = _.color.xyz._longToRgb( [ 1, 2, 3 ], src );
  test.identical( got, expected );

  /* - */

  test.case = 'dst : Array; dst.length !== 3';
  var src = [ 0.45, 0.45, 0.45 ];
  var dst = [ 1, 2, 3, 5, 6 ];
  test.shouldThrowErrorSync( () => _.color.xyz._longToRgb( dst, src ) )

  test.case = 'dst : Long; dst.length !== 3';
  var src = [ 0.45, 0.45, 0.45 ];
  var dst = _.longFrom([ 1, 2 ]);
  test.shouldThrowErrorSync( () => _.color.xyz._longToRgb( dst, src ) )

  test.case = 'dst : TypedArray; dst.length !== 3';
  var src = [ 0.45, 0.45, 0.45 ];
  var dst = new Float32Array([ 1, 2, 3, 4 ]);
  test.shouldThrowErrorSync( () => _.color.xyz._longToRgb( dst, src ) )

  test.case = 'dst : VectorAdapter; dst.length !== 3';
  var src = [ 0.45, 0.45, 0.45 ];
  var dst = _.vad.fromLong([ 1 ]);
  test.shouldThrowErrorSync( () => _.color.xyz._longToRgb( dst, src ) )

}

_longToRgbWithDst.accuracy = 1e-2;

//

function _validate( test )
{

  test.case = 'normal 3 elements';
  var src = [ 11, 16, 75 ];
  var expected = true;
  var got = _.color.xyz._validate( src );
  test.identical( got, expected );

  test.case = 'normal 4 elements';
  var src = [ 11, 16, 75, 100 ];
  var expected = true;
  var got = _.color.xyz._validate( src );
  test.identical( got, expected );

  test.case = 'first arg < 0';
  var src = [ -1, 16, 75 ];
  var expected = false;
  var got = _.color.xyz._validate( src );
  test.identical( got, expected );

  test.case = 'second arg < 0';
  var src = [ 11, -160, 75 ];
  var expected = false;
  var got = _.color.xyz._validate( src );
  test.identical( got, expected );

  test.case = 'third arg < 0';
  var src = [ 11, 16, -750 ];
  var expected = false;
  var got = _.color.xyz._validate( src );
  test.identical( got, expected );

}

//

function _formatStringParse( test )
{
  test.case = 'normal 3';
  var src = 'xyz(0,0,100)';
  var expected = [ 0, 0, 100 ];
  var got = _.color.xyz._formatStringParse( src );
  test.identical( got, expected );

  test.case = 'normal spaces 3';
  var src = 'xyz(0, 0, 100)';
  var expected = [ 0, 0, 100 ];
  var got = _.color.xyz._formatStringParse( src );
  test.identical( got, expected );

  test.case = 'normal 4';
  var src = 'xyz(0,0,0,100%)';
  var expected = [ 0, 0, 0, 100 ];
  var got = _.color.xyz._formatStringParse( src );
  test.identical( got, expected );

  test.case = 'normal spaces 4';
  var src = 'xyz(0, 0, 0, 100%)';
  var expected = [ 0, 0, 0, 100 ];
  var got = _.color.xyz._formatStringParse( src );
  test.identical( got, expected );

  test.case = 'wrong format';
  var src = 'hwba(0,0,0)';
  test.shouldThrowErrorSync( () => _.color.xyz._formatStringParse( src ) );

  test.case = 'redundant channel';
  var src = 'xyz(0,0,0,0%,100)';
  test.shouldThrowErrorSync( () => _.color.xyz._formatStringParse( src ) );

  test.case = 'second channel with \'%\'';
  var src = 'xyz(0,0%,0)';
  test.shouldThrowErrorSync( () => _.color.xyz._formatStringParse( src ) );

}


// --
// declare
// --

let Self =
{

  name : 'Tools/mid/Xyz',
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

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
