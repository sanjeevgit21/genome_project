# genome_project
My genome project

#Software requirements / dependencies

Please follow the instructions at http://asia.ensembl.org/info/docs/api/api_installation.html to install all required Ensembl Perl API

# Perl Script

Perl Script to convert coordinates on chromosome using the human data from Ensembl release and the Ensembl Perl API to convert coordinates on chromosome (e.g chromosome 10 from 25000 to 30000 )to the same region in GRCh37.

### How to run

  - Open a terminal.
  - Execute script with required arguments.
  - See results.


```sh
$  perl convert_coordinates.pl  --asm_one GRCh37  --seq_region_name X --region_start 25000 --region_end 30000 --asm_two GRCh37
```

