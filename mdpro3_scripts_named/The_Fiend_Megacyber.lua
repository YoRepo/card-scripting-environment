--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: The Fiend Megacyber  (ID: 66362965)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Warrior
-- Level: 6
-- ATK 2200 | DEF 1200
-- Setcode: 0x6e, 0x93
-- Scope: OCG / TCG
--
-- Effect Text:
-- If your opponent controls at least 2 more monsters than you do, you can Special Summon this card
-- (from your hand).
--[[ __CARD_HEADER_END__ ]]

--魔導ギガサイバー
function c66362965.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c66362965.spcon)
	c:RegisterEffect(e1)
end
function c66362965.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.GetFieldGroupCount(c:GetControler(),0,LOCATION_MZONE)-Duel.GetFieldGroupCount(c:GetControler(),LOCATION_MZONE,0)>=2
end
