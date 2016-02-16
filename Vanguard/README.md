# Vanguard

## Overview

V consists of a CoreHypervisor, Workers, a Dashboard, and assorted tests and harnesses. In addition V pulls in models from Keystone and Keystone Credibility

## Major Projects (move to main readme)

APIs
BackBone
BattleField
Dashboards
KeyStone
KeyStone-Credibility-> Attrition.io specific models).
PowerPlant
Vanguard

## Deployment

__To start Vanguard__
run the following on each Vanguard host (the process cluster)
 sidekiq -r ./coreHypervisor.rb

__Initiate Jobs__

Initiate jobs by running vanguard.rb for automated tasks, or run corresponding rake tasks. For individual jobs use the CLI (with optional repl)
