#!/bin/sh
echo $0
dart $(dirname $0)/main.dart <<< $1
