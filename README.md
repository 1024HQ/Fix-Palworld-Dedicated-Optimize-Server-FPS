# Fix Palworld Dedicated Optimize Server FPS (Multicore & Hyperthreading)
Fix Palworld Dedicated Optimize Server FPS
ช่วยให้ดึงประสิทธิภาพของเซิร์ฟเวอร์ออกมาดีที่สุดเท่าที่จะทำได้ในตอนนี้
ทดสอบโดยใช้ Save ที่เล่นมาหนักพอสมควร ก่อนปรับ และ หลังจาก ปรับใช้แล้ว โดย Setting จะบังคับเปิดใช้ Core และ Hyperthreading


<img src="https://img5.pic.in.th/file/secure-sv1/001388f95edf7d83d34.jpeg" alt="001388f95edf7d83d34.jpeg" border="0" />
<img src="https://img2.pic.in.th/pic/00284011c756805ae3a.jpeg" alt="00284011c756805ae3a.jpeg" border="0" />


<h1>Arguments Support</h1>

| Arguments  | Detail |
| ------------- | ------------- |
| useperfthreads  | Full Threads  |
| NoAsyncLoadingThread  | Disable Async (บังคับให้ทุก task ประมวลผลทำงานพร้อมกันโดยไม่ต้องรอtaskก่อนหน้า)  |
| UseMultithreadForDS  | Enable MultiThread  |
| port  | connecting port  |
| players  | How many max player.  |
| corelimit  | Max core processors  |
| physicalcorelimit  | Max Core  |
| usehyperthreading  | Enable Hyper Threading  |
| onethread  | Single Thread  |
| norenderthread  | Disable Thread  |
| noheartbeatthread  | Disable Swap thread  |

<h1>Sample</h1>
Example specs and settings
ตัวอย่าง Spec และ การตั้งค่าใช้งาน

| Spec  | Detail |
| ------------- | ------------- |
| CPU  | Intel i9-13900K  |
| Ram  | 64 GB  |
| Core  | 24  |
| Logical processors  | 32  |


```
PalServer.exe -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS -port=8211 -corelimit=32 -physicalcorelimit=24 -usehyperthreading
```


<h1>Runs automatically when the server shuts down.</h1>
สำหรับใช้รันเซิร์ฟเวอร์ที่มี Ram ค่อนข้างน้อยจะทำให้ server crashed ดังนั้นใส่ script สำหรับ auto restart เมื่อ process หยุดทำงานดังนี้ โดย save ไปไว้ที่เดียวกับไฟล์เซิร์ฟเวอร์ PalServer.exe (หรือ ทำเอาไว้ก็ได้เผื่อไว้ก่อน)

```
@echo off
cls
echo This script will keep your server running even after crashing!
title Palworld Server
:StartServer
start /wait PalServer.exe -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS -port=8211 -corelimit=32 -physicalcorelimit=24 -usehyperthreading
echo (%time%) Server closed/crashed... restarting!
goto StartServer
```

save script to steamapps\common\PalServer\  (Your file name : AutoStart.bat)


<h1>FPS Limit Setting</h1>
PalServer\Pal\Saved\Config\WindowsServer\Engine.ini

Paste it to the bottom line of the file.
วางไว้บรรทัดล่างสุด

```
[/Script/OnlineSubsystemUtils.IpNetDriver]
NetServerMaxTickRate=120
```

| Config  | Detail |
| ------------- | ------------- |
| Save efficiency  | 30  |
| Default  | 60  |
| High  | 120  |


*ไม่แนะนำให้ปรับสูงเกินกว่าประสิทธิภาพของเซิร์ฟเวอร์ โดยเฉพาะ ถ้าใช้ VPS ไม่ควรไปปรับมัน

Have fun. : )

https://youtu.be/Oi1cIqVIEnE
