#!/bin/bash
#

DIR=`dirname $0`

# Run server:stmgr_unittest
for i in `seq 1 100`; do
  echo === repeat test $i ===
  bazel --bazelrc=tools/travis-ci/bazel.rc test --config=ubuntu --nocache_test_results --test_output=all //heron/stmgr/tests/cpp/server/...
  RESULT=$?
  if [ $RESULT -ne 0 ]; then
    # Dump out stream manager log
    echo "DUMPING STMGR TEST LOG"
    tail -n +1 /home/travis/.cache/bazel/_bazel_travis/*/execroot/heron/bazel-out/local_linux-fastbuild/testlogs/heron/stmgr/tests/cpp/server/stmgr_unittest/test.log
    exit 1
  fi
done
