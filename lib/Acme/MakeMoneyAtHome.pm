## Commented heavily to try to make Gilded learn perl \o/
#
# 'package' declares the start of a namespace.
#   Named subroutines and package-scoped variables live in a namespace.
#   If no namespace is specified (as is normal in a script) 'main' is assumed.
#
#   In loadable libraries, the package declaration should match the module
#   name and be consistent with the module's path so that 'use' and 'require'
#   can find it:
#     package My::Foo::Bar;   # /My/Foo/Bar.pm
#
#   A package might be a class. There's no way (in raw perl) to explicitly
#   declare that it is, but a package might provide class or object methods.
#   There's no (well, in raw perl, but see Moops) way to explicitly declare
#   that a particular sub is a class or object method, either; these are just
#   normal subs that expect an invocant:
#   
#     package My::Foo::Bar;
#     sub new {                     # 'my $obj = My::Foo->new( ... )'
#       my ($class, @params) = @_;  # expects to be invoked on a class name
#       bless +{ @params }, $class  # returns a HASH-backed object
#     }
#     sub get_foo {                 # 'my $res = $obj->get_foo'
#       my ($self) = @_;            # expects to be invoked an object
#       $self->{_foo}               # returns an item from the backing HASH
#     }
#     1;  # loadable modules must end in a true value
#
#   Regarding packages, see: `perldoc -f package` , `perldoc perlmod`
#   Regarding methods, find a recent (perl-5.16+) `perldoc perlootut`
#
# Declare our package:
package Acme::MakeMoneyAtHome;

# Always 'use strict;' or better (like 'use strictures 1;')
#   Without the 'strict' pragma, an endless number of terrible things will
#   inevitably happen; variables will magically spring into being, mistyped
#   keywords magically become character string constants, etc.
#
#   'strictures' is even better, but you'll need to get it from CPAN.
use strict; 

# Always 'use warnings;' at the very least.
#   The 'FATAL => "all"' bit is a little contentious.
#
#   Fatal warnings can save your ass, or they can kill your production app
#   at 3am -- it depends on the codebase.
#
#   I advise spending the rest of your day reading blog wars about it.
#   Seriously.
#
# Anyway, use one of these:
#use warnings;
use warnings FATAL => 'all';

# This package exports functions. We need Exporter.
#
#   Whenever you 'use' a module, it is loaded at compile-time and 'import()'
#   is called (as if it were an object method, such as 'My::Pkg->import').
#   A pretty common thing to do is to install some set of subs to the caller's
#   namespace.
#
#   Well, we don't *need* Exporter. We could write a custom 'import()'
#   method that does what Exporter does for us -- writes some stuff
#   to a caller's piece of the symbol table. That would be clumsy and
#   annoying, and that wheel's been reinvented many times over already.
#   There is a lot of powerful functionality hidden here, though, far beyond
#   the scope of this ramble.
#
# We can get an 'import()' method from Exporter (a core module):
use Exporter 'import'; 
# We need to tell Exporter just what should be exported.
#
#   Uh oh, sigils!
#   The '@' sigil indicates that '@EXPORT' is an array:
#     our @EXPORT = ( 'myfunc', 'otherfunc', 'moarfunc' );
#   'our @EXPORT' declares @EXPORT as a package-scoped variable;
#   that is, it is a global variable whose fully qualified name is 
#   actually @Acme::MakeMoneyAtHome::EXPORT -- which lets Exporter find it.
#
#   It might not be a bad time to mention identifier convention;
#
#     package MyThing::TestStuff;  # packages are CamelCase
#
#     sub FOO () { 1 }             # constants are all-uppercase
#
#     my $foo;    # lexicals are lower case
#
#     our $Foo;   # package vars *usually* start with an uppercase letter;
#                 # there's some inconsistency here, because certain special
#                 # identifiers like $VERSION or @EXPORT are all-upper for
#                 # hysterical raisins
#
#     sub foo {}  # subroutines are usually lower case
#
#     sub _foo {} # private subs start with an underscore
#
# Exporting one subroutine, so we can skip parens (there's no list):
our @EXPORT = 'make_money_at_home';

# ... but we do need to construct a couple other lists:
our @Subject = (
  "roommate",
  "cousin",
  "neighbor",
  "mother",
  "father",
  "sensei",
  "associate",
  "senator",
  "friend",
  "aunt",
  "employer",
  "car dealer",
  "housemaid",
  "limousine driver",
  "study partner",
  "roommate",
  "half-sister",
  "step-uncle",
  "Perl mentor",
  "third cousin",
  "mother-in-law",
  "father-in-law",
  "tennis partner",
  "gym spotter",
  "statistician",
  "hairdresser",
  "dungeon master",
  "priest",
  "BFF",
  "sugar daddy",
  "secret lover",
  "great grandmother",
  "retarded parakeet",
  "chemistry assistant",
  "meth cook",
  "crippled dog",
  "deaf cat",
  "PHP advisor",
  "personal trainer",
  "neighbor",
  "lacrosse teammate",
  "distant Russian relative",
  "personal cheerleader",
  "autistic goldfish",
  "dishwasher",
);

our @Activity = (
  "photoshopping dicks",
  "browsing 4chan",
  "posting memes",
  "mining scamcoins",
  "browsing CPAN",
  "avoiding honest work",
  "being a fucktard on Tumblr",
  "smoking weed",
  "scamming people",
  "writing to Nigerian princes",
  "collecting reddit karma",
  "mocking celebrities",
  "playing Farm Birds on MyFace+",
  "IRCing",
  "answering fetish surveys",
);


sub make_money_at_home {
  # rand() takes a scalar (which should be a number);
  # imposing scalar context on an array returns the number of elements:
  my $activity = $Activity[rand @Activity];

  # Declare an empty lexical array '@people':
  my @people;
  # 'do-until' should be self-explanatory to anyone who's seen 'do-while';
  # the BLOCK is executed at least once, and then loops until the condition is
  # true. In this case, we want to loop until we have 3 elements in '@people':
  do {
    my $new_subj = $Subject[rand @Subject];
    # grep BLOCK LIST returns all items in LIST for which BLOCK evaluates
    # true. Here we're using it as an inefficient way to avoid duplicates.
    #
    # List::Util and List::MoreUtils contain better tooling for this;
    # 'grep' will always apply BLOCK to every element of LIST, but here we
    # could optimize by short-circuiting out as soon as a match is found.
    push @people, $new_subj unless grep {; $_ eq $new_subj } @people
  } until @people == 3;

  my $unemploy = (int rand 36) + 4;
  my $hourly   = (int rand 60) + 40;
  my $monthly  = (int rand 10_000) + 10_000;

  my @gender   = int rand 2 ? ('He', 'his') : ('She', 'her') ;

  # A sub returns the result of the last expression -- unless 'return' is
  # called, of course. Here we return a string.
  #
  # These scalar non-reference variables will interpolate into a double-quoted
  # string just fine. If we were dealing with references or any other more
  # complicated expressions, we'd need to use the '.' concatenation operator.
  "My $people[0]'s $people[1]'s $people[2] makes \$$hourly an hour on the "
  ."computer. $gender[0] has been without work for $unemploy months but last "
  ."month $gender[1] pay was \$$monthly from just $activity "
  ."a few hours per day."
}

# A loadable module has to return a true value:
1;


=pod

=head1 NAME

Acme::MakeMoneyAtHome - I made 17047 dollars just posting Acme dists to CPAN

=head1 SYNOPSIS

  use Acme::MakeMoneyAtHome;
  print make_money_at_home();

=head1 DESCRIPTION

Exports the function B<make_money_at_home>, which can tell you how
much money your father's gym spotter's autistic goldfish made last month just
browsing 4chan a few hours per day.

=head1 CONTRIBUTORS

Perl-ified and maintained by Jon Portnoy <avenj@cobaltirc.org>

This Perl implementation is based on JavaScript written by B<Gilded>, whose
real name and contact information I'll put here if he ever trusts me enough to
tell me.

=head1 LICENSE

Licensed under the same terms as Perl.

=cut
