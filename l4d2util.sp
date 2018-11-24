#pragma semicolon 1
#pragma newdecls required

#define __IN_L4D2UTIL__

#include <l4d2util>
#include <l4d2util/rounds>
#include <l4d2util/tanks>

char sLibraryName[] = "l4d2util";

public Plugin myinfo = {
    name = "L4D2 Utilities",
    author = "Confogl Team, Saccie",
    description = "Useful functions and forwards for Left 4 Dead 2 SourceMod plugins",
    version = "1.01",
    url = "https://github.com/ConfoglTeam/l4d2util"
}

public void OnPluginStart() {
    L4D2Util_Tanks_Init();

    HookEvent("round_start", L4D2Util_RoundStart);
    HookEvent("round_end", L4D2Util_RoundEnd);
    HookEvent("tank_spawn", L4D2Util_TankSpawn);
    HookEvent("player_death", L4D2Util_PlayerDeath);
}

public void OnMapEnd() {
    L4D2Util_Rounds_OnMapEnd();
}

public APLRes AskPluginLoad2(Handle hPlugin, bool bLateLoad, char[] sError, int iErrMax) {
    L4D2Util_Rounds_CreateForwards();
    L4D2Util_Tanks_CreateForwards();

    RegPluginLibrary(sLibraryName);

    return APLRes_Success;
}

public Action L4D2Util_RoundStart(Handle event, const char[]name, bool dontBroadcast) {
    L4D2Util_Rounds_OnRoundStart();
    L4D2Util_Tanks_OnRoundStart();
}

public Action L4D2Util_RoundEnd(Handle event, const char[]name, bool dontBroadcast) {
    L4D2Util_Rounds_OnRoundEnd();
}

public Action L4D2Util_TankSpawn(Handle event, const char[]name, bool dontBroadcast) {
    int iTank = GetClientOfUserId(GetEventInt(event, "userid"));

    L4D2Util_Tanks_TankSpawn(iTank);
}

public Action L4D2Util_PlayerDeath(Handle event, const char[]name, bool dontBroadcast) {
    int iPlayer = GetClientOfUserId(GetEventInt(event, "userid"));
    L4D2Util_Tanks_PlayerDeath(iPlayer);
}

