
if( typeof module !== 'undefined' )
require( 'wColor' );

let _ = wTools;

var c1 = 0xff0000;
var c2 = 'red';

c1 = _.color.rgbaFrom( c1 );
c2 = _.color.rgbaFrom( c2 );

console.log( 'c1 :', c1 );
console.log( 'c2 :', c2 );
