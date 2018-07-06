## Stretch OS & Jessie OS versions included. New script!

# moonlight-steam-script-retropie
The Install & Setup Script for Moonlight (Steam) to RetroPie. Based on Jessie script written by **TechWizTime**.
New revamped script that supports both Steatch OS and Jessie OS by **2Play!**

NOTE: This will be pre-installed on PlayBox release. You can use this to install tot your existing retropiemenu.

This script will install the Steam Streaming application Moonlight on your Raspberry Pi.
Highly recommended using/updating to the latest version of RetroPie script (currently at 4.4.1 last commit 111043b).

## What does this do
This script currently will do the following:
- Install Moonlight Stretch or Jessie version
- Create Launch Scripts for 720p 30fps, 720p 60ps, 1080p 30fps, 1080p 60fps
- Pair With GameStream on PC
- Setup a Steam System in RetroPie Menu

## How to use this
In RetroPie, go to the Command Line and type the following to download the script:
```

cd /home/pi/RetroPie/retropiemenu
wget https://raw.githubusercontent.com/2play/moonlight-steam-script-retropie/master/moonlight.sh
sudo chmod +x moonlight.sh
```
Then run the script:
```
./moonlight.sh
```

## If you get a TLS or SSL Error
Sometimes, this can happen when trying to wget the script above. If it does, try below command instead:
```
wget https://raw.githubusercontent.com/2play/moonlight-steam-script-retropie/master/moonlight.sh  --no-check
```

## Other Information
If you use this script in a YouTube video, please give my channel a shout out/subscribe.

| [Discord](https://discord.gg/ZeGCBdm) | [YouTube](https://www.youtube.com/channel/UCHj6THhkEawrZU2bqCn1geA)|
| --- | --- | --- | --- |

