--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Amano-Iwato  (ID: 32181268)
-- Type: Monster / Effect / Spirit
-- Attribute: EARTH
-- Race: Rock
-- Level: 4
-- ATK 1900 | DEF 1200
-- Scope: OCG / TCG
--
-- Effect Text:
-- Cannot be Special Summoned.
-- Monsters cannot activate their effects, except Spirit monsters.
-- Once per turn, during the End Phase, if this card was Normal Summoned or flipped face-up this turn:
-- Return this card to the hand.
--[[ __CARD_HEADER_END__ ]]

--天岩戸
function c32181268.initial_effect(c)
	--spirit return
	aux.EnableSpiritReturn(c,EVENT_SUMMON_SUCCESS,EVENT_FLIP)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--cannot act
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(1,1)
	e2:SetValue(c32181268.aclimit)
	c:RegisterEffect(e2)
end
function c32181268.aclimit(e,re,tp)
	return not re:GetHandler():IsType(TYPE_SPIRIT) and re:IsActiveType(TYPE_MONSTER)
end
