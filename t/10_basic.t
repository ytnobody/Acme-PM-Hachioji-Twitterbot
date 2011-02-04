use Test::More;
use Acme::PM::Hachioji;
use Acme::PM::Hachioji::TwitterBot;

my $bot = Acme::PM::Hachioji->twitter_bot(
    consumer_key => 'yd0O9ptdCynDm6NZbOHOw',
    consumer_secret => 'I4ir7wUU89siZuXBOwABFRmJv2x2Mbren9jFiAMflU',
    access_token => '242296355-ksaHd7Ra3N2BmyHq8cmyFDAkVNb6CNq25f7ou7P0',
    access_token_secret => 'l4Y46StcmS22aCBvLSkNul9aeiuEEQmAxakRAzsLlk',
);

isa_ok $bot, 'Acme::PM::Hachioji::TwitterBot';
done_testing();

