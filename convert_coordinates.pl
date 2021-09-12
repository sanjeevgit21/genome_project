#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dumper;
use Getopt::Long;


use Bio::EnsEMBL::Registry;

my ($asm_one, $region_start, $region_end, $asm_two, $seq_region_name);

GetOptions (
    "asm_one=s"     => \$asm_one,
    "region_start=i"   => \$region_start,
    "region_end=i"   => \$region_end,
    "asm_two=s"   => \$asm_two,
    "seq_region_name=s"   => \$seq_region_name,
)
or die("Error in command line arguments\n");



print "\033[2J";    #Clear the screen
print "\033[0;0H"; #Goto to 0,0 on screen

print "Perl Script to convert coordinates on chromosome using the uman data from Ensembl release and the Ensembl Perl API to convert coordinates on chromosome\n";

print "\n\nArguments passed :\n";
print "asm_one: $asm_one\n";
print "region_start: $region_start\n";
print "region_end: $region_end\n";
print "asm_two: $asm_two\n";
print "seq_region_name: $seq_region_name\n";
#Connect to the latest GRCh37 database.


my $registry = 'Bio::EnsEMBL::Registry';
$registry->load_registry_from_db(
  -host => 'ensembldb.ensembl.org',
  -user => 'anonymous',
  -port => 3337, #Specific to GRCh37 database
);

#Assemblymapper adaptor for the human core database
my $asma = Bio::EnsEMBL::Registry->get_adaptor( "human", "core", "assemblymapper" );
#Coordsystem adaptor for the human core database
my $csa = Bio::EnsEMBL::Registry->get_adaptor( "human", "core", "coordsystem" );
my $chr_cs1 = $csa->fetch_by_name( 'chromosome', $asm_one );
my $chr_cs2 = $csa->fetch_by_name( 'chromosome', $asm_two );
my $asm_mapper = $asma->fetch_by_CoordSystems( $chr_cs1, $chr_cs2 );
    
# Map to GRCh37 coordinate system.
my @coords =
      $asm_mapper->map( $seq_region_name, $region_start, $region_end, 1, $chr_cs1 );

foreach my $gap (@coords){
    print "Start : ".$gap->start."\n";
    print "End : ".$gap->end."\n";
    print "Length : ".$gap->length."\n";
    print "Rank : ".$gap->rank."\n";
}    
