# OpenComputers base control for ToastyNetworks
## by Arothe
Visit our website! **https://toastynetworks.net/**

### Usage
Download the lib using  
`wget -f 'https://raw.githubusercontent.com/Pozitrone/Arolib/master/AroLib.lua' /home/arolib.lua`  
(Internet Card Required)  

Add the library to your project using  
`arolib = require("arolib")`  

Run functions using  
`arolib.function()`  

### Docs
If there is anything missing in the documentation, please, let me know in the issues section! 

#### colorTps()
Prints out TPS in according color. 
* Green, when higher than 15
* Orange, when between 15 and 5
* Red, when under 5  

Useful for displaying the TPS. In your codes, please, use **tps()**.  

#### draconicCore()
Sets lower resolution and displays information about a Draconic Evolution energy storage.  
* Max RF  
* Current RF
* Transfer rate (colored)  

To reset the resolution, use **reset()**, or **reboot** the computer.  

#### extremeReactorStats(reactorName: string)
Offers a complex interface about an Extreme Reactor.
* Reactor Name - Your custom selected name
* Reactor Type - Actively / Passively cooled
* Core Temperature - Bar on the left
* Casing Temperature - Bar on the right
* Reactor Status - Online / Offline
* Control Rods - Amount of control rods
* Fuel Status - Percentage of fuel inside the reactor
* Reactivity - Percentage value
* Energy generated - RF/t
* Fuel consumption - in mB/t
* Waste amount - Percentage amount of waste  
* Energy stored - Battery icon
* On / Off button - touchable

Battery has three colors depending on the charge, temperature uses 8-color gradient.  
On / Off button uses two colors to determine the action.  

#### farmsControl()
In 10-second interval checks the server TPS (uses internal **tps()** function). If TPS > 15, returns redstone signal from the back.  
Set your harvester to "only active with Redstone signal" and leave it running. If the server is struggling, the farm will turn off.

#### help()
Print's out simplified list of all functions.  

#### reset()
Resets resolution back to 160\*50 (Tier 3 screen resolution). 

#### tps()
Returns server TPS.

### Changelog
###### 1.0
> * Initiated library creation, with functions tps(), farmsControl(), colorTps(), draconicCore(), reset(), extremeReactorStats() and help()  
> * Added basic documentation  
> * Added changelog  
