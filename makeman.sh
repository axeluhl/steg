#!/bin/bash
pandoc steg.1.md -s -t man -o steg.1
gzip steg.1
