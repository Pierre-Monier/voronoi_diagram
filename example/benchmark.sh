#!/bin/bash

# You must have a compatible device connected to your computer

flutter drive \
  --driver=test_driver/benchmark_driver.dart \
  --target=integration_test/benchmark_test.dart \
  --profile