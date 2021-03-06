package Acme::PM::Hachioji::TwitterBot;
use strict;
use warnings;
our $VERSION = '0.01';

use parent qw/ WebService::ATND Class::Accessor::Fast /;
use SUPER;
use Net::Twitter::Lite;
use Encode;
use WWW::Shorten 'TinyURL', ':short';
use POSIX qw/ strftime /;
use utf8;

__PACKAGE__->mk_accessors( qw/ bot / );

sub import {
    no strict 'refs';
    no warnings 'redefine';
    *{ 'Acme::PM::Hachioji::twitter_bot' } = sub {
        my ( $class, %arg ) = @_;
        Acme::PM::Hachioji::TwitterBot->new( %arg );
    };
}

sub new {
    my ( $class, %arg ) = @_;
    my $self = $class->SUPER::new();
    my $bot = Net::Twitter::Lite->new(
        consumer_key => $arg{ consumer_key },
        consumer_secret => $arg{ consumer_secret },
    );
    $bot->access_token( $arg{ access_token } );
    $bot->access_token_secret( $arg{ access_token_secret } );
    $self->bot( $bot );
    return $self;
}

sub tweet {
    my $self = shift;
    my $now = time;
    $self->fetch( 'events', keyword => 'hachioji.pm' );
    while ( my $event = $self->next ) {
        next if $event->start->epoch <= $now;
        $self->_tweet( $self->_make_tweet_text( $event ) );
    }
}

sub _make_tweet_text {
    my ( $self, $event ) = @_;
    my $desc  = $event->description;
    my $catch = $event->catch;

    $catch = '' if ( length $catch > 30 ); # so long
    $desc  = $desc =~ /(テーマは.+\n)/ ? $1 : '';

    my $text = $event->title
     . ' - ' . $catch . ' '
     . short_link( $event->event_url )
     . " 日時:" . $event->start->strftime( '%Y/%m/%d %H:%M' )
     . sprintf( '(参加希望%d/%d人)', $event->accepted->{ value } + $event->waiting, $event->limit )
     . " #hachiojipm $desc";

    substr( $text, 132 ) = '...' if ( length($text) > 132 );

    return $text . "\n";
}


sub _tweet {
    shift->bot->update( { status => shift } );
}

1;
__END__

=head1 NAME

Acme::PM::Hachioji::TwitterBot -

=head1 SYNOPSIS

  use Acme::PM::Hachioji::TwitterBot;

=head1 DESCRIPTION

Acme::PM::Hachioji::TwitterBot is

=head1 AUTHOR

satoshi azuma E<lt>ytnobody@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
