--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Guldfaxe of the Nordic Beasts  (ID: 41788781)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Beast
-- Level: 4
-- ATK 1600 | DEF 1000
-- Setcode: 0x6042
-- Scope: OCG / TCG
--
-- Effect Text:
-- If your opponent controls a Synchro Monster and you control no monsters, you can Special Summon this
-- card (from your hand).
--[[ __CARD_HEADER_END__ ]]

--極星獣グルファクシ
function c41788781.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c41788781.spcon)
	c:RegisterEffect(e1)
end
function c41788781.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO)
end
function c41788781.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.GetFieldGroupCount(c:GetControler(),LOCATION_MZONE,0)==0
		and	Duel.IsExistingMatchingCard(c41788781.filter,c:GetControler(),0,LOCATION_MZONE,1,nil)
end
