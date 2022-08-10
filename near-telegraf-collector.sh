#!/bin/bash

set -u

# Required ENV VARIABLES:
#   ACCOUNT_NAME (e.g. sotcsa)
#   POOLID (e.g. sotcsa.factory.shardnet.near)

# Change the 127.0.0.1 if you are running telegraf not on your near server
export MY_RCP_URL=http://127.0.0.1:3030
export RCP_URL=https://rpc.shardnet.near.org

STATUS=$(curl -s  -H 'Content-Type: application/json' $MY_RCP_URL/status | jq)
VERSION=$(echo "$STATUS" | jq -r .version.build)
COMMIT_ID=$(echo "$VERSION" | cut -d'-' -f3)

validators=$(curl -s -d '{"jsonrpc": "2.0", "method": "validators", "id": "dontcare", "params": [null]}' -H 'Content-Type: application/json' $RCP_URL | jq -c '.result')
val_result=$(echo $validators | jq -c '.current_validators[] | select(.account_id | contains ("'$ACCOUNT_NAME'"))')

stake_raw=$(echo $val_result | jq -r .stake)
stake=$(echo "$stake_raw / 10^24" | bc)

echo '{
  "measurement": "'$POOLID'",
  "time": '$(date +%s)',
  "near_version": "'$VERSION'",
  "near_version_commit_id": "'$COMMIT_ID'",
  "validator_account_id": '$(echo $STATUS | jq .validator_account_id)',
  "node_key": '$(echo $STATUS | jq .node_key)',
  "chain_id": '$(echo $STATUS | jq .chain_id)',
  "protocol_version": '$(echo $STATUS | jq .protocol_version)',
  "latest_protocol_version": '$(echo $STATUS | jq .latest_protocol_version)',
  "fields": {
    "latest_block_height": '$(echo $STATUS | jq .sync_info.latest_block_height)',
    "latest_block_time": '$(echo $STATUS | jq .sync_info.latest_block_time)',
    "syncing": "'$(echo $STATUS | jq .sync_info.syncing)'",
    "earliest_block_height": '$(echo $STATUS | jq .sync_info.earliest_block_height)',
    "earliest_block_time": '$(echo $STATUS | jq .sync_info.earliest_block_time)',
    "epoch_id": '$(echo $STATUS | jq .sync_info.epoch_id)',
    "epoch_start_height": '$(echo $STATUS | jq .sync_info.epoch_start_height)',
    "nr_validators": '$(echo $STATUS | jq .validators[].account_id | wc -l)',
    "num_expected_chunks": '$(echo $val_result | jq -r .num_expected_chunks)',
    "num_produced_chunks": '$(echo $val_result | jq -r .num_produced_chunks)',
    "num_expected_blocks": '$(echo $val_result | jq -r .num_expected_blocks)',
    "num_produced_blocks": '$(echo $val_result | jq -r .num_produced_blocks)',
    "current_stake": '$stake'
  }
}'
