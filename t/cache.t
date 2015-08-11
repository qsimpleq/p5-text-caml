use strict;
use warnings;

use Test::More tests => 6;

use Text::Caml;

use File::Basename ();
use File::Spec     ();

my $templates_path =
  File::Spec->catfile(File::Basename::dirname(__FILE__), 'templates');

my $c0 = Text::Caml->new(templates_path => $templates_path);
my $c2 = Text::Caml->new(templates_path => $templates_path, use_cache => 2);

is $c0->use_cache => 0, 'use_cache default attribute 0';
is $c2->use_cache => 2, 'use_cache attribute set 2';
is $c0->use_cache(1) => 1, 'use_cache set 1';
is $c0->use_cache => 1, 'use_cache get value after set 1';
is $c2->render_file('cache', {body => 'wow-wow-wow'}) => 'wow-wow-wow', 'run cache 2';

my $file = File::Spec->file_name_is_absolute($c2->{cache}{cache});
is $file => 1, 'cache 2 really works';
