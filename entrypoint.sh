#!/bin/bash
set -e

rm -f /virtual_credit_api/tmp/pids/server.pid

exec "$@"
