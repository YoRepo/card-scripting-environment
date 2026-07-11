--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Hack Worm  (ID: 97466712)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level: 1
-- ATK 400 | DEF 0
-- Setcode: 0x3e
-- Scope: OCG / TCG
--
-- Effect Text:
-- If your opponent controls no monsters, you can Special Summon this card (from your hand).
--[[ __CARD_HEADER_END__ ]]

--ハック・ワーム
function c97466712.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c97466712.hspcon)
	c:RegisterEffect(e1)
end
function c97466712.hspcon(e,c)
	if c==nil then return true end
	return Duel.GetFieldGroupCount(c:GetControler(),0,LOCATION_MZONE)==0
		and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
