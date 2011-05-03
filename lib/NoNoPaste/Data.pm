package NoNoPaste::Data;

use strict;
use warnings;
use utf8;
use parent qw/DBIx::Sunny::Schema/;
use Mouse::Util::TypeConstraints;
    
subtype 'Uint'
    => as 'Int'
    => where { $_ >= 0 };
    
no Mouse::Util::TypeConstraints;

sub now {
    my @lt = localtime;
    sprintf "%04d-%02d-%02d %02d:%02d:%02d",
        $lt[5]+1900, $lt[4]+1, $lt[3], $lt[2], $lt[1], $lt[0];
}

__PACKAGE__->query(
    'add_entry',
    id => 'Str',
    nick => { isa => 'Str', default => 'anonymouse' },
    body => 'Str',
    datetime => { isa => 'Str', default => \&now },
    q{INSERT INTO entries ( id, nick, body, ctime ) values ( ?, ?, ?, ? )},
);

__PACKAGE__->select_all(
    'entry_list',
    'offset' => { isa => 'Uint', default => 0 },
    q{SELECT id,nick,body,ctime FROM entries ORDER BY ctime DESC LIMIT ?,11}
);

__PACKAGE__->select_row(
    'retrieve_entry',
    'id' => 'Str',
    q{SELECT id,nick,body,ctime FROM entries WHERE id = ?}
);

1;

