use inc::Module::Install;
name 'NoNoPaste';
all_from 'lib/NoNoPaste.pm';

tests 't/*.t';
#author_tests 'xt';

test_requires 'Test::More';

requires 'Class::Accessor::Lite';
requires 'Data::Section::Simple';
requires 'Path::Class';
requires 'Scalar::Util';
requires 'Plack', 0.9937;
requires 'Net::IP';
requires 'Plack::Middleware::Access';
requires 'Plack::Middleware::ReverseProxy';
requires 'Plack::Middleware::Scope::Container';
requires 'Scope::Container';
requires 'Scope::Container::DBI';
requires 'Digest::SHA';
requires 'Plack::Builder::Conditionals';
requires 'Router::Simple';
requires 'Text::Xslate', 0.1044;
requires 'HTML::FillInForm::Lite', 1.09;
requires 'Cwd';
requires 'File::Basename';

requires 'DBI';
requires 'DBD::SQLite', 1.25;
requires 'Digest::MD5';
requires 'DBIx::Sunny';

#auto_set_repository;
auto_include;
WriteAll;
