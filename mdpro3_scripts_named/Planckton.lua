--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Planckton  (ID: 10282757)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- Apply these effects until the end of this turn.
-- ● Rank 3 or lower Xyz Monsters gain 500 ATK and DEF.
-- ● Rank 4 or higher Xyz Monsters cannot attack.
--[[ __CARD_HEADER_END__ ]]

--プランクスケール
function c10282757.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c10282757.activate)
	c:RegisterEffect(e1)
end
function c10282757.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetValue(500)
	e1:SetTarget(c10282757.filter1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	Duel.RegisterEffect(e2,tp)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_ATTACK)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetReset(RESET_PHASE+PHASE_END)
	e3:SetTarget(c10282757.filter2)
	Duel.RegisterEffect(e3,tp)
end
function c10282757.filter1(e,c)
	return c:IsType(TYPE_XYZ) and c:IsRankBelow(3)
end
function c10282757.filter2(e,c)
	return c:IsType(TYPE_XYZ) and c:IsRankAbove(4)
end
