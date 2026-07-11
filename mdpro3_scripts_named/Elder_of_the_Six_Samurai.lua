--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Elder of the Six Samurai  (ID: 61737116)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level: 3
-- ATK 400 | DEF 0
-- Setcode: 0x103d
-- Scope: OCG / TCG
--
-- Effect Text:
-- If your opponent controls a monster and you control no monsters, you can Special Summon this card
-- (from your hand).
--[[ __CARD_HEADER_END__ ]]

--六武衆のご隠居
function c61737116.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c61737116.spcon)
	c:RegisterEffect(e1)
end
function c61737116.spcon(e,c)
	if c==nil then return true end
	return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_MZONE,0)==0
		and	Duel.GetFieldGroupCount(c:GetControler(),0,LOCATION_MZONE)>0
		and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
