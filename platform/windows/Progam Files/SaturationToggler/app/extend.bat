@echo off
title DisplaySwitch Extend
"%SystemRoot%\System32\DisplaySwitch.exe" /extend
"%~dp0SaturationToggler.exe" --saturation=100
