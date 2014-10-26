use strict;
use warnings;
package App::Whiff;
{
  $App::Whiff::VERSION = '0.003';
}
# ABSTRACT: find the first executable of a series of alternatives

use File::Which ();


sub find_first {
  my ($self, $names) = @_;

  my $file;
  for my $name (@$names) {
    $file = File::Which::which($name);
    return $file if $file;
  }

  return;
}


sub run {
  my ($self) = @_;

  die "usage: whiff <command ...>\n" unless @ARGV;
  my $file = $self->find_first([ @ARGV ]);
  die "no alternative found\n" unless $file;
  print "$file\n";
}

1;

__END__

=pod

=head1 NAME

App::Whiff - find the first executable of a series of alternatives

=head1 VERSION

version 0.003

=head1 DESCRIPTION

This module implements logic used by the F<whiff> command, which takes a number
of command names and returns the first one that exists and is executable.

=head1 METHODS

=head2 find_first

  my $filename = App::Whiff->find_first(\@names);

Given an arrayref of command names (which should I<not> be anything other than
base filename), this method either returns an absolute path to the first of the
alternatives found in the path (using L<File::Which>) or false.

=head2 run

This method is called by the F<whiff> program to ... well, run.

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
