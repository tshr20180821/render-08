<?php

error_log('START');

//$redis = new Redis();

$hostname = parse_url(getenv('UPSTASH_REDIS_REST_URL'),  PHP_URL_HOST);
error_log($hostname);
preg_match('/(\d+)/', $hostname, $matches, PREG_OFFSET_CAPTURE);
error_log(print_r($matches, true));
//$redis->connect('tlsv1.2://' . $hostname, $port);
//$redis->auth(getenv('UPSTASH_REDIS_REST_TOKEN'));

//print_r($redis->get("foo"));


error_log('FINISH');
