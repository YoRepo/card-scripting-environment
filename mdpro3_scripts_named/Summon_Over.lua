--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 召唤过度  (ID: 48015771)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：每次怪兽特殊召唤给这张卡放置1个召唤指示物（最多6个）。
-- ②：有6个召唤指示物放置的这张卡不会被效果破坏。
-- ③：这张卡有6个召唤指示物放置的场合，双方玩家在自己主要阶段1开始时才能发动。这张卡送去墓地，对方场上的特殊召唤的怪兽全部送去墓地。
--[[ __CARD_HEADER_END__ ]]

--サモンオーバー
function c48015771.initial_effect(c)
	c:EnableCounterPermit(0x4c)
	c:SetCounterLimit(0x4c,6)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--counter
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_FZONE)
	e2:SetOperation(c48015771.ctop)
	c:RegisterEffect(e2)
	--indes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCondition(c48015771.indcon)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--tograve
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(48015771,0))
	e4:SetCategory(CATEGORY_TOGRAVE)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetProperty(EFFECT_FLAG_BOTH_SIDE)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCondition(c48015771.tgcon)
	e4:SetTarget(c48015771.tgtg)
	e4:SetOperation(c48015771.tgop)
	c:RegisterEffect(e4)
end
function c48015771.ctop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():AddCounter(0x4c,1)
end
function c48015771.indcon(e)
	return e:GetHandler():GetCounter(0x4c)==6
end
function c48015771.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1 and not Duel.CheckPhaseActivity() and e:GetHandler():GetCounter(0x4c)==6
end
function c48015771.tgfilter(c)
	return c:IsFaceup() and c:IsSummonType(SUMMON_TYPE_SPECIAL) and c:IsAbleToGrave()
end
function c48015771.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c48015771.tgfilter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c48015771.tgfilter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,g:GetCount(),0,0)
end
function c48015771.tgop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SendtoGrave(c,REASON_EFFECT)~=0 and c:IsLocation(LOCATION_GRAVE) then
		local g=Duel.GetMatchingGroup(c48015771.tgfilter,tp,0,LOCATION_MZONE,nil)
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
