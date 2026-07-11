--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Elegy the Melodious Diva  (ID: 79514956)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level: 5
-- ATK 2000 | DEF 1200
-- Setcode: 0x9b
-- Scope: OCG / TCG
--
-- Effect Text:
-- Special Summoned "Melodious" monsters you control cannot be destroyed by card effects.
-- If this card was Special Summoned, all Fairy monsters you control gain 300 ATK.
--[[ __CARD_HEADER_END__ ]]

--幻奏の音女エレジー
function c79514956.initial_effect(c)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c79514956.indtg)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_FAIRY))
	e2:SetValue(300)
	e2:SetCondition(c79514956.tgcon)
	c:RegisterEffect(e2)
end
function c79514956.indtg(e,c)
	return c:IsSetCard(0x9b) and c:IsSummonType(SUMMON_TYPE_SPECIAL)
end
function c79514956.tgcon(e)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SPECIAL)
end
