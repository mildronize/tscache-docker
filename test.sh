#!/bin/bash

echo "Running test suite..." \
    && pip install -r tests/requirements.txt \
    && chmod a+x tests/test_query.py test/add_data.sh \
    && tests/add_data.sh \
    && tests/test_query.py \
