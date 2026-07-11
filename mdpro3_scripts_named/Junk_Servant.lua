--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Junk Servant  (ID: 78922939)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level: 4
-- ATK 1500 | DEF 1000
-- Setcode: 0x43
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control a "Junk" monster, you can Special Summon this card (from your hand).
--[[ __CARD_HEADER_END__ ]]

--ジャンク・サーバント
function c78922939.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c78922939.spcon)
	c:RegisterEffect(e1)
end
function c78922939.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x43)
end
function c78922939.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and
		Duel.IsExistingMatchingCard(c78922939.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
