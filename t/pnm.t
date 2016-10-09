use Test::More tests => 5;

use warnings;
use strict;

use PDF::API2;

# Filename

my $pdf = PDF::API2->new();
$pdf->{forcecompress} = 0;

my $pnm = $pdf->image_pnm('t/resources/1x1.pbm');
isa_ok($pnm, 'PDF::API2::Resource::XObject::Image::PNM',
       q{$pdf->image_pnm(filename)});

is($pnm->width(), 1,
   q{Image from filename has a width});

my $gfx = $pdf->page->gfx();
$gfx->image($pnm, 72, 144, 216, 288);
like($pdf->stringify(), qr/q 216 0 0 288 72 144 cm \S+ Do Q/,
     q{Add PNM to PDF});

# Filehandle

$pdf = PDF::API2->new();
open my $fh, '<', 't/resources/1x1.pbm';
$pnm = $pdf->image_pnm($fh);
isa_ok($pnm, 'PDF::API2::Resource::XObject::Image::PNM',
       q{$pdf->image_pnm(filehandle)});

is($pnm->width(), 1,
   q{Image from filehandle has a width});

close $fh;
