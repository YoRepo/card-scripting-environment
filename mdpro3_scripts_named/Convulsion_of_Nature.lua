--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 天变地异  (ID: 62966332)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 只要这张卡在场上存在，双方玩家把卡组上下翻转过来进行决斗。
--[[ __CARD_HEADER_END__ ]]

--天変地異
function c62966332.initial_effect(c)
	Duel.EnableGlobalFlag(GLOBALFLAG_DECK_REVERSE_CHECK)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_REVERSE_DECK)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(1,1)
	c:RegisterEffect(e2)
end
