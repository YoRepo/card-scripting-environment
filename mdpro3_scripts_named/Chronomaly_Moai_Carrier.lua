--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Chronomaly Moai Carrier  (ID: 38007744)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Rock
-- Level: 5
-- ATK 900 | DEF 1800
-- Setcode: 0x70
-- Scope: OCG / TCG
--
-- Effect Text:
-- If your opponent controls a card and you control no cards, you can Special Summon this card (from
-- your hand).
--[[ __CARD_HEADER_END__ ]]

--先史遺産モアイキャリア
function c38007744.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c38007744.spcon)
	c:RegisterEffect(e1)
end
function c38007744.spcon(e,c)
	if c==nil then return true end
	return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_ONFIELD,0)==0
		and Duel.GetFieldGroupCount(c:GetControler(),0,LOCATION_ONFIELD)>0
		and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
