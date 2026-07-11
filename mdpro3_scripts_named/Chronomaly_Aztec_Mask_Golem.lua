--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Chronomaly Aztec Mask Golem  (ID: 94766498)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Rock
-- Level: 4
-- ATK 1500 | DEF 1000
-- Setcode: 0x70
-- Scope: OCG / TCG
--
-- Effect Text:
-- During your turn, if you have activated a "Chronomaly" Spell Card previously this turn, you can
-- Special Summon this card (from your hand).
-- You can only control 1 "Chronomaly Aztec Mask Golem".
--[[ __CARD_HEADER_END__ ]]

--先史遺産アステカ・マスク・ゴーレム
function c94766498.initial_effect(c)
	c:SetUniqueOnField(1,0,94766498)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c94766498.hspcon)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(94766498,ACTIVITY_CHAIN,c94766498.chainfilter)
end
function c94766498.chainfilter(re,tp,cid)
	return not (re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_SPELL) and re:GetHandler():IsSetCard(0x70))
end
function c94766498.hspcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetCustomActivityCount(94766498,tp,ACTIVITY_CHAIN)>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
end
