use inc::Module::Install;
name 'Acme-PM-Hachioji-TwitterBot';
all_from 'lib/Acme/PM/Hachioji/TwitterBot.pm';

requires 'Acme::PM::Hachioji';
requires 'WebService::ATND';
requires 'Time::Timezone';
requires 'Net::Twitter::Lite';
requires 'Class::Accessor::Fast';
requires 'WWW::Shorten';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
install_script 'bin/hachiojipm_twitterbot';
WriteAll;
