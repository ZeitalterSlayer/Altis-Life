#include <macro.h>
enableSaving [false, false];

X_Server = false;
X_Client = false;
X_JIP = false;
StartProgress = false;

if(!isDedicated) then { X_Client = true;};
enableSaving[false,false];

life_versionInfo = "Altis Life RPG v3.1.4.7";
[] execVM "briefing.sqf"; //MapRegeln
[] execVM "KRON_Strings.sqf";
//meine if abfragen 
if(isDedicated && isNil("life_market_prices")) then
{
[] call life_fnc_marketconfiguration;
diag_log "Market prices generated!";
"life_market_prices" addPublicVariableEventHandler
{
diag_log format["Market prices updated! %1", _this select 1];
};
//Start server fsm
[] execFSM "core\fsm\server.fsm";
diag_log "Server FSM executed";
};
// Check if the addon version is running - if not, run the mission included script version 
if (!(isClass (configFile >> "CfgPatches" >> "btk_wirecutter"))) then { 
    _null = [] execVM "scripts\btk_wirecutter\init.sqf"; 
};
//Scriptsausführungsbefehle
////////////////////ADMIN///////////////////////
[] execVM "scripts\anticheat.sqf"; //Admintool
//[] execVM "scripts\AdminTool\loop.sqf"; //Admintool aaalt
//[] execVM "scripts\AdminTool\atools\prio1\loop.sqf"; //ADMIN TOOL
[] execVM "scripts\AdminTool\atools\prio2\loop.sqf"; //com betreuer slayer 
[] execVM "scripts\AdminTool\atools\prio3\loop.sqf"; //quester ripper 
//////////////////////////////////////////////////
[] execVM "scripts\zlt_fastrope.sqf"; //Abseilscript
[] execVM "scripts\monitor.sqf"; //des is de anzeige do rechts untn
[] execVM "scripts\Wetterdienst.sqf"; //Wedabericht
[] execVM "scripts\teargas.sqf"; //tränengas
[] execVM "scripts\intro.sqf"; // des intro untn rechts
[] execVM "scripts\safezone.sqf"; // in kavalla wird ned gschossn
[] execVM "scripts\Intel\Intel_init.sqf"; //buidl wechsl
[] execVM "scripts\unfall.sqf"; // du fliagst ausm auto
[] execVM "scripts\restart.sqf"; // du fliagst ausm auto
[] execVM "scripts\nosidechat.sqf"; // du fliagst ausm auto
//[] execVM "scripts\adac\schluessel.sqf"; // adac kommt noch
player execVM "scripts\unflip\init_umdrehen.sqf"; //autos umdrahn
null = execVM "scripts\killTicker.sqf"; //sogt wea wen umbrocht hod
_igiload = execVM "scripts\IgiLoad\IgiLoadInit.sqf"; //Cargoscript
[] spawn life_fnc_autoSave; // autosave
//logistic

StartProgress = true;

"BIS_fnc_MP_packet" addPublicVariableEventHandler {_this call life_fnc_MPexec};