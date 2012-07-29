package Daemon;

use feature q/:5.10/;
use utf8;
use strict;
use warnings;
use Carp qw/croak cluck/;
use LWP::Simple;

sub new{
    my $this= shift;

    bless {save_to => '.', @_}, $this;
}

sub download{
    my $this= shift;
    my ($url, $name)= @_;
    my $filename= join '/', split(/\//, $this->{save_to}), $name;

    my $content= get $url;
    croak "cant get '$url': $!" unless defined $content;

    open my $f, '>', $filename or croak "cant open '$filename': $!";
    binmode $f, ':utf8';
    print $f $content;
    close $f or croak "cant close '$filename': $!";
}

1;

