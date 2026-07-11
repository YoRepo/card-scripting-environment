--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Rose Papillon  (ID: 8910240)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Insect
-- Level: 3
-- ATK 1400 | DEF 800
-- Scope: OCG / TCG
--
-- Effect Text:
-- During your Main Phase, you can Tribute Summon 1 Level 7 or higher monster in Attack Position in
-- addition to your Normal Summon/Set.
-- (You can only gain this effect once per turn.)
-- While you control another Insect monster, this card can attack directly.
--[[ __CARD_HEADER_END__ ]]

--ローズ・パピヨン
function c8910240.initial_effect(c)
	--extra summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(8910240,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_HAND,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsLevelAbove,7))
	e1:SetValue(0x1)
	c:RegisterEffect(e1)
	--direct attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DIRECT_ATTACK)
	e2:SetCondition(c8910240.dircon)
	c:RegisterEffect(e2)
end
function c8910240.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_INSECT)
end
function c8910240.dircon(e)
	return Duel.IsExistingMatchingCard(c8910240.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,e:GetHandler())
end
