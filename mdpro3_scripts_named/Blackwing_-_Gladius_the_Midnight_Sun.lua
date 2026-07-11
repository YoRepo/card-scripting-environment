--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Blackwing - Gladius the Midnight Sun  (ID: 28190303)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Winged Beast
-- Level: 3
-- ATK 800 | DEF 1500
-- Setcode: 0x33
-- Scope: OCG / TCG
--
-- Effect Text:
-- If the only face-up monster you control is 1 "Blackwing" monster other than "Blackwing - Gladius the
-- Midnight Sun", you can Special Summon this card (from your hand).
-- Once per turn, this card cannot be destroyed by battle.
--[[ __CARD_HEADER_END__ ]]

--BF－白夜のグラディウス
function c28190303.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c28190303.spcon)
	c:RegisterEffect(e1)
	--battle indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e2:SetCountLimit(1)
	e2:SetValue(c28190303.valcon)
	c:RegisterEffect(e2)
end
function c28190303.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return false end
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	return g:GetCount()==1 and tc:IsSetCard(0x33) and not tc:IsCode(28190303)
end
function c28190303.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end
