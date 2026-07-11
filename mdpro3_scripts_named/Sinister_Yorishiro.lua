--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Sinister Yorishiro  (ID: 72497366)
-- Type: Trap / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- Each turn, 1 Level 5 or higher Fiend monster you Normal Summon can be Summoned without Tributing.
-- If exactly 1 Normal Summoned/Set Level 5 or higher Fiend monster (and no other cards) would be
-- destroyed, you can send this card to the GY instead.
--[[ __CARD_HEADER_END__ ]]

--悪魔の憑代
function c72497366.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--decrease tribute
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(72497366,0))
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SUMMON_PROC)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_HAND,0)
	e2:SetCountLimit(1)
	e2:SetCondition(c72497366.ntcon)
	e2:SetTarget(c72497366.nttg)
	c:RegisterEffect(e2)
	--destroy replace
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_DESTROY_REPLACE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTarget(c72497366.reptg)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
function c72497366.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c72497366.nttg(e,c)
	return c:IsLevelAbove(5) and c:IsRace(RACE_FIEND)
end
function c72497366.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return eg:GetCount()==1 and tc:IsFaceup() and tc:IsLocation(LOCATION_MZONE)
		and tc:IsRace(RACE_FIEND) and tc:IsLevelAbove(5) and tc:IsSummonType(SUMMON_TYPE_NORMAL)
		and tc:IsReason(REASON_EFFECT+REASON_BATTLE) and not tc:IsReason(REASON_REPLACE) end
	if Duel.SelectEffectYesNo(tp,e:GetHandler(),96) then
		Duel.SendtoGrave(e:GetHandler(),REASON_EFFECT)
		return true
	else return false end
end
