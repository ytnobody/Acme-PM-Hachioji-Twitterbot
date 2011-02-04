use Test::More;
use Acme::PM::Hachioji;
use Acme::PM::Hachioji::TwitterBot;

my $bot = Acme::PM::Hachioji->twitter_bot(
    consumer_key => 'aaaa',
    consumer_secret => 'aaaa',
    access_token => 'iiii',
    access_token_secret => 'iiii',
);

isa_ok $bot, 'Acme::PM::Hachioji::TwitterBot';
done_testing();

