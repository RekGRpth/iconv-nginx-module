# vi:filetype=perl

use lib 'lib';
use Test::Nginx::Socket;

repeat_each(3);

plan tests => repeat_each() * 2 * blocks();

#no_long_string();

run_tests();

#no_diff();

__DATA__

=== TEST 1
--- config
    location /foo {
        rds_json_ret 100 '你好';
        iconv_filter from=utf8 to=gbk;
    }
--- request
GET /foo
--- charset: gbk
--- response_body eval
"{\"errcode\":100,\"errstr\":\"你好\"}"



=== TEST 2
--- config
    location /foo {
        echo -n '你';
        echo_flush;
        echo '好';
        iconv_filter from=utf8 to=gbk;
    }
--- request
GET /foo
--- charset: gbk
--- response_body
你好
