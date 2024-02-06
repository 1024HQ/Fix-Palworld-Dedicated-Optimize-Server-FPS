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

<h1>Optimize For 12th Gen Intel +</h1>
Only CPUs that support Hyperthreading are supported.
which must be Enable Hyperthreading at the BIOS

for intel support P-Core & E-core hyperthreading work on p-core only not support e-core.<br>
sample : i9-13900K p-core work on core#0 - #15<br>
Use Task Manager to limit CPU runs on cores # 0 - # 15 only (disable e-core # 16 - # 31)<br>
It will help the server work with maximum efficiency.<br>
(Check p-core & e-core with HWMonitor <a herf="https://www.cpuid.com/softwares/hwmonitor.html">https://www.cpuid.com/softwares/hwmonitor.html</a>)<br><br>
1.Task Manager -> Details<br>
2.Find the processname PalServer-Win64-Test-Cmd.exe<br>
3.Right click and click on set affinity (unchecked all e-core CPU)(check p-core with HWMonitor)<br>
<img src="https://img2.pic.in.th/pic/p46245060717fd7fdc.jpeg" alt="p46245060717fd7fdc.jpeg" border="0" width="40%"/><br>
<img src="https://img5.pic.in.th/file/secure-sv1/p277c72cc00979735c.jpeg" alt="p277c72cc00979735c.jpeg" border="0" />
<br>
<br>
*ฟีเจอร์นี้จะใช้ได้จำเป็นต้องเปิด Hyperthreading ที่ BIOS ก่อน<br>
โดยสำหรับปัญหา Intel 12th Gen นั้นจะมี P-core และ E-core เข้ามาซึ่งเราจะต้องไปตั้งค่าให้มันทำงานแค่ P-core เท่านั้น เนื่องจาก E-core ทำให้ประสิทธิภาพเซิร์ฟเวอร์ลดลง และ E-core ไม่รองรับ Hyperthreading ครับ<br><br>
P-core นั้นจะแรงกว่า โดยสามารถตั้งค่าได้ดังนี้<br>
1.Task Manager -> Details<br>
2.หา Process PalServer-Win64-Test-Cmd.exe<br>
3.คลิกขวา เลือก Set affinity เลือกเฉพาะ CPU 0 - CPU 15 และ เอาติ๊กถูก CPU 16 - CPU 31 ออก (เช็คแต่ละรุ่นด้วยโปรแกรม HWMonitor <a herf="https://www.cpuid.com/softwares/hwmonitor.html">https://www.cpuid.com/softwares/hwmonitor.html</a>) จะเป็นการบังคับให้ทำงานเฉพาะแกน CPU ที่เราต้องการ<br>
<br>
<br>

Have fun. : )

https://youtu.be/Oi1cIqVIEnE
