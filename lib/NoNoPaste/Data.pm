package NoNoPaste::Data;

use strict;
use warnings;
use utf8;
use parent qw/DBIx::Sunny::Schema/;
use DateTime;
use DateTime::Format::Strptime;
use Mouse::Util::TypeConstraints;
    
subtype 'Uint'
    => as 'Int'
    => where { $_ >= 0 };
    
no Mouse::Util::TypeConstraints;

my $DTFMT = DateTime::Format::Strptime->new(
    time_zone => 'UTC',
    pattern   => '%Y-%m-%d %H:%M:%S',
);

__PACKAGE__->query(
    'add_entry',
    id => 'Str',
    nick => { isa => 'Str', default => 'anonymouse' },
    body => 'Str',
    datetime => {
        isa => 'DateTime',
        default => sub { DateTime->now( time_zone=>'UTC' ) },
        deflater => sub { $DTFMT->format_datetime(shift) },
    },
    q{INSERT INTO entries ( id, nick, body, ctime ) values ( ?, ?, ?, ? )},
);

__PACKAGE__->select_all(
    'entry_list',
    'offset' => { isa => 'Uint', default => 0 },
    q{SELECT id,nick,body,ctime FROM entries ORDER BY ctime DESC LIMIT ?,11},
    sub {
        my $row = shift;
        $row->{ctime} = $DTFMT->parse_datetime($row->{ctime});
        $row->{ctime}->set_time_zone("Asia/Tokyo");
    }
);

__PACKAGE__->select_row(
    'retrieve_entry',
    'id' => 'Str',
    q{SELECT id,nick,body,ctime FROM entries WHERE id = ?},
    sub {
        my $row = shift;
        $row->{ctime} = $DTFMT->parse_datetime($row->{ctime});
        $row->{ctime}->set_time_zone("Asia/Tokyo");
    }
);

1;

