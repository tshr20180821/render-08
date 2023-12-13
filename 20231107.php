<?php

error_log('START');

$redis = new Redis();

$hostname = parse_url(getenv('UPSTASH_REDIS_REST_URL'),  PHP_URL_HOST);
error_log($hostname);
$port = explode('.', explode('-', $hostname)[3])[0];
error_log($port);
$redis->connect('tlsv1.2://' . $hostname, $port);
$redis->auth(getenv('UPSTASH_REDIS_PASSWORD'));

error_log(print_r($redis->get('APT_RESULT_' . getenv('RENDER_EXTERNAL_HOSTNAME')), true));

error_log('FINISH');
