<?php

error_log('START');

$m = new Memcached();
$m->setOption(OPT_BINARY_PROTOCOL, true);
$m->addServer('127.0.0.1', 11211);

$m->set('KEY_A', 'DATA_A');
error_log($m->getResultCode());
error_log($m->getResultMessage());
error_log('DATA : ' . $m->get('KEY_A'));

echo $m->get('KEY_A');

error_log('FINISH');
