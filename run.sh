#!/bin/bash
echo $(dirname $0)/main.dart -e $1 <<< $2
dart $(dirname $0)/main.dart -e $1 <<< $2
