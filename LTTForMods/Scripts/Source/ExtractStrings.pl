#!/usr/bin/perl

use Data::Dumper;

@f = ();
opendir( $d, "." );
while( readdir( $d ) ) {
	push( @f, $_ ) if ( -f $_ && $_ =~ /\.psc$/i );
}
closedir( $d );

#print Dumper \@f;

%strings = ();

foreach $f ( @f ) {
	open( $fh, "<", $f );
	while( <$fh> ) {
#		print "Line:".$_;
		foreach ( split( /"/, $_ ) ) {
			$strings{$_} = 1 if /^\$\w+$/;
		}
	}
	close( $fh );
}

foreach $_ ( sort keys( %strings ) ) {
	print "$_\n";
}