--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Heraldic Beast Eale  (ID: 82315772)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast
-- Level: 4
-- ATK 1000 | DEF 1800
-- Setcode: 0x76
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control 2 or more "Heraldic Beast" monsters, you can Special Summon this card (from your
-- hand).
--[[ __CARD_HEADER_END__ ]]

--紋章獣エアレー
function c82315772.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c82315772.spcon)
	c:RegisterEffect(e1)
end
function c82315772.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x76)
end
function c82315772.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and
		Duel.IsExistingMatchingCard(c82315772.filter,c:GetControler(),LOCATION_MZONE,0,2,nil)
end
