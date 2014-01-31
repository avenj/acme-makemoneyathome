package Acme::MakeMoneyAtHome;
use strict; use warnings FATAL => 'all';

use Exporter 'import'; our @EXPORT = 'make_money_at_home';

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
  my @people;
  do {
    my $new_subj = $Subject[rand @Subject];
    push @people, $new_subj unless grep {; $_ eq $new_subj } @people
  } until @people == 3;
  my $activity = $Activity[rand @Activity];
  my $unemploy = (int rand 36) + 4;
  my $hourly   = (int rand 60) + 40;
  my $monthly  = (int rand 10_000) + 10_000;
  my $gender   = int rand 2 ? 'He' : 'She';

  "My $people[0]'s $people[1]'s $people[2] makes \$$hourly an hour on the "
  ."computer. $gender has been without work for $unemploy months but last month "
  ."her pay was \$$monthly from just $activity a few hours per day."
}


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

Maintained by Jon Portnoy <avenj@cobaltirc.org>

This Perl implementation is based on JavaScript written by B<Gilded>, whose
real name and contact information I'll put here if he ever trusts me enough to
tell me.

=head1 LICENSE

Licensed under the same terms as Perl.

=cut
