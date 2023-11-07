<?php

error_log('TEST');

$mem_info = 'memory_get_usage true : ' . number_format(memory_get_usage(true))
    . "\nmemory_get_usage false : " . number_format(memory_get_usage())
    . "\nmemory_get_peak_usage true : " . number_format(memory_get_peak_usage(true))
    . "\nmemory_get_peak_usage false : " . number_format(memory_get_peak_usage());

error_log($mem_info);

echo 'TEST';
