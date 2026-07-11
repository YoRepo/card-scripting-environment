--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Backup Secretary  (ID: 63528891)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Cyberse
-- Level: 3
-- ATK 1200 | DEF 800
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control a Cyberse monster, you can Special Summon this card (from your hand).
-- You can only Special Summon "Backup Secretary" once per turn this way.
--[[ __CARD_HEADER_END__ ]]

--バックアップ・セクレタリー
function c63528891.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(63528891,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,63528891+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c63528891.spcon)
	c:RegisterEffect(e1)
end
function c63528891.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_CYBERSE)
end
function c63528891.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c63528891.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
