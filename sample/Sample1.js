
if( typeof module !== 'undefined' )
require( 'wColor' );
//require( '../staging/amid/color/Color.s' );

var _ = wTools;

var c1 = 0xff0000;
var c2 = 'red';

c1 = _.colorFrom( c1 );
c2 = _.colorFrom( c2 );

console.log( 'c1 :',c1 );
console.log( 'c2 :',c2 );
