#!/usr/bin/perl
#
# Taken from SkyUI source on GitHub.
#
sub error
{
	print	"\n=========================\n\n"
		.	"ERROR: $_[0]\n";
	getc(STDIN);
	exit(1);
}

# Run on all *_translations.txt in pwd
#my $ModName = "LTT_Hunterborn";



my $sourcePath = $ModName."_Translations.txt";
my $dstdir = "../LTTForMods/Interface/Translations/";

@sources = <*>;
foreach $sourcePath (@sources) {
	next unless $sourcePath =~ /_Translations.txt\s*$/i;
	$modname = $sourcePath;
	$modname =~ s/_Translations.txt\s*$//i;

	open SOURCE, "<:utf8", $sourcePath or error("Cannot open $sourcePath: $!");

	my @langs = split("\t", <SOURCE>);
	shift @langs;

	my @files;

	foreach $lang (@langs) {
		chomp($lang);
		$lang = lc($lang);
		local *FILE;
		local $fileName = $modname."_".$lang.".txt";
		open(FILE, ">:raw:encoding(UCS2-LE):crlf:utf8", $dstdir."$fileName");
		print FILE ("\x{FEFF}"); # print BOM
		push(@files,*FILE);
	}

	while (my $line = <SOURCE>) {
		chomp($line);
		local @buf = split("\t", $line);
		local $key = shift @buf;
		
		next unless $key and $key =~ /^\$/;

		local $i=0;

		foreach $file (@files) {
			local $str = $buf[$i] ? $buf[$i] : $buf[0]; # fall back to english if no translate present
			print $file ($key . "\t" . $str . "\n") unless $str eq "\$";
			$i++;
		}
	}
	close(SOURCE);

	foreach $file (@files) {
		close $file;
	}
}

#print "Done.\n\n";
#getc(STDIN);
exit(0);