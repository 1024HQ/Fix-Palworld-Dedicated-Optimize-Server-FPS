@echo off
cls
echo This script will keep your server running even after crashing!
title Palworld Server
:StartServer
start /wait PalServer.exe -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS -port=8211 -corelimit=32 -physicalcorelimit=24 -usehyperthreading
echo (%time%) Server closed/crashed... restarting!
goto StartServer