# Bot Drafting Logic

## Problem
Pack ordering

Add pack # to pack

Sort by smalles pack #, greatest card # 

## Solution
- Periodic Job to Pick for all Bots
  - Job runs every 2? seconds
  - Iterates over all bots
    - Iterates over each bot's packs
      - Pick and enqueue passing Job

## TODO

- Add back expected card # check before picking from pack