--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Ghost Lancer, the Underworld Spearman  (ID: 64104037)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Zombie
-- Level: 5
-- ATK 2000 | DEF 0
-- Scope: OCG / TCG
--
-- Effect Text:
-- If only your opponent controls a monster, you can Special Summon this card (from your hand).
-- Cannot be destroyed by battle, except with monsters Special Summoned from the Extra Deck.
-- If this card attacks a Defense Position monster, inflict piercing battle damage.
--[[ __CARD_HEADER_END__ ]]

--劫火の槍術士 ゴースト・ランサー
function c64104037.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c64104037.spcon)
	c:RegisterEffect(e1)
	--battle indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c64104037.indes)
	c:RegisterEffect(e2)
	--pierce
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e3)
end
function c64104037.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
		and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
end
function c64104037.indes(e,c)
	return not c:IsSummonLocation(LOCATION_EXTRA)
end
