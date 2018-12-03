@echo off
title DisplaySwitch Internal
"%SystemRoot%\System32\DisplaySwitch.exe" /internal
"%~dp0SaturationToggler.exe" --saturation=200
