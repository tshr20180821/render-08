<?php

error_log('START');

$m = new Memcached();
$m->setOption(Memcached::OPT_BINARY_PROTOCOL, true);
error_log($m->getResultCode());
error_log($m->getResultMessage());

$m->setSaslAuthData('memcached', getenv('RENDER_EXTERNAL_HOSTNAME'));
$m->addServer('127.0.0.1', 11211);
error_log($m->getResultCode());
error_log($m->getResultMessage());

$m->set('KEY_A', 'DATA_A');
error_log($m->getResultCode());
error_log($m->getResultMessage());
error_log('DATA : ' . $m->get('KEY_A'));

echo $m->get('KEY_A');
error_log($m->getResultCode());
error_log($m->getResultMessage());

error_log('FINISH');
