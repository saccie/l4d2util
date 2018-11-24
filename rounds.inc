#include <sourcemod>

bool bInRound = false;

static Handle hFwdOnRoundStart;
static Handle hFwdOnRoundEnd;

void L4D2Util_Rounds_OnMapEnd() {
    bInRound = false;
}

void L4D2Util_Rounds_OnRoundStart() {
    if (!bInRound) {
        bInRound = true;
        Call_StartForward(hFwdOnRoundStart);
        Call_Finish();
    }
}

void L4D2Util_Rounds_OnRoundEnd() {
    if (bInRound) {
        bInRound = false;
        Call_StartForward(hFwdOnRoundEnd);
        Call_Finish();
    }
}

void L4D2Util_Rounds_CreateForwards() {
    hFwdOnRoundStart = CreateGlobalForward("OnRoundStart", ET_Ignore);
    hFwdOnRoundEnd = CreateGlobalForward("OnRoundEnd", ET_Ignore);
}

