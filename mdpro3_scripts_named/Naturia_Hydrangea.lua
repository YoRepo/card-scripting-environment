--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Naturia Hydrangea  (ID: 47795344)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Plant
-- Level: 5
-- ATK 1900 | DEF 2000
-- Setcode: 0x2a
-- Scope: OCG / TCG
--
-- Effect Text:
-- During your turn, if the effect of a "Naturia" monster was activated on your field, you can Special
-- Summon this card (from your hand).
--[[ __CARD_HEADER_END__ ]]

--ナチュル・ハイドランジー
function c47795344.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c47795344.spcon)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(47795344,ACTIVITY_CHAIN,c47795344.chainfilter)
end
function c47795344.chainfilter(re,tp,cid)
	return not (re:GetHandler():IsSetCard(0x2a) and re:IsActiveType(TYPE_MONSTER)
		and Duel.GetChainInfo(cid,CHAININFO_TRIGGERING_LOCATION)==LOCATION_MZONE)
end
function c47795344.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetCustomActivityCount(47795344,tp,ACTIVITY_CHAIN)~=0
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
end
