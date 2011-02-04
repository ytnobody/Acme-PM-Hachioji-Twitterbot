use inc::Module::Install;
name 'Acme-PM-Hachioji-TwitterBot';
all_from 'lib/Acme/PM/Hachioji/TwitterBot.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
