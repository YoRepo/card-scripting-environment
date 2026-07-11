--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Splendid Venus  (ID: 5645210)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level: 8
-- ATK 2800 | DEF 2400
-- Scope: OCG / TCG
--
-- Effect Text:
-- All non-Fairy monsters lose 500 ATK/DEF.
-- The activation and effects of Spell/Trap Cards activated on your field cannot be negated.
--[[ __CARD_HEADER_END__ ]]

--The splendid VENUS
function c5645210.initial_effect(c)
	--atk,def
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(c5645210.target)
	e1:SetValue(-500)
	c:RegisterEffect(e1)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_DEFENSE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(c5645210.target)
	e1:SetValue(-500)
	c:RegisterEffect(e1)
	--inactivatable
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CANNOT_INACTIVATE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetValue(c5645210.effectfilter)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_CANNOT_DISEFFECT)
	e5:SetRange(LOCATION_MZONE)
	e5:SetValue(c5645210.effectfilter)
	c:RegisterEffect(e5)
end
function c5645210.target(e,c)
	return c:IsFaceup() and not c:IsRace(RACE_FAIRY)
end
function c5645210.effectfilter(e,ct)
	local p=e:GetHandler():GetControler()
	local te,tp,loc=Duel.GetChainInfo(ct,CHAININFO_TRIGGERING_EFFECT,CHAININFO_TRIGGERING_PLAYER,CHAININFO_TRIGGERING_LOCATION)
	return p==tp and te:IsActiveType(TYPE_SPELL+TYPE_TRAP) and bit.band(loc,LOCATION_ONFIELD)~=0
end
