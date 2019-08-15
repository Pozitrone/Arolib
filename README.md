# OpenComputers base control for ToastyNetworks
## by Arothe
Visit our website! **https://toastynetworks.net/**

### Usage
Download the lib using  
`wget -f 'https://raw.githubusercontent.com/Pozitrone/Base-Control/master/AroLib.lua' /home/arolib.lua`  
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

### Changelog
###### 1.0
> * Initiated library creation, with functions tps(), farmsControl(), colorTps(), draconicCore(), reset(), extremeReactorStats() and help()  
> * Added basic documentation  
> * Added changelog  
