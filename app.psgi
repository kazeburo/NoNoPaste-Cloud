use strict;
return sub {
    my $env = shift;
    return [
        200,
        [ 'Content-Type' => 'text/html' ],
        [
            "<html><head><title>Hello</title></head>",
            "<body><h1>Hello, Stranger</h1><p>Here's a dump of what I know about you</p>",
            (map { "<tr><td>$_</td><td>$env->{$_}</td></tr>\n" }
                grep { /^HTTP_/ }
                keys %$env),
            "</table></body></html>"
        ],
    ]
};

