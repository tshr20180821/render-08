<?php

error_log('TEST');
error_log(memory_get_usage(true));
error_log(memory_get_usage());
error_log(memory_get_peak_usage(true));
error_log(memory_get_peak_usage());

echo 'TEST';
