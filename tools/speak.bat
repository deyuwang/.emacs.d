@echo off
echo CreateObject("SAPI.SpVoice").Speak %1% > speak.vbs
start wscript speak.vbs