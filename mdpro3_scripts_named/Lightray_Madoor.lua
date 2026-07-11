--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Lightray Madoor  (ID: 82579942)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level: 6
-- ATK 1200 | DEF 3000
-- Scope: OCG / TCG
--
-- Effect Text:
-- If 3 or more of your LIGHT monsters are banished, you can Special Summon this card (from your hand).
-- Once per turn, this card cannot be destroyed by battle.
--[[ __CARD_HEADER_END__ ]]

--ライトレイ マドール
function c82579942.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c82579942.spcon)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e2:SetCountLimit(1)
	e2:SetValue(c82579942.valcon)
	c:RegisterEffect(e2)
end
function c82579942.spfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_LIGHT)
end
function c82579942.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c82579942.spfilter,tp,LOCATION_REMOVED,0,3,nil)
end
function c82579942.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end
