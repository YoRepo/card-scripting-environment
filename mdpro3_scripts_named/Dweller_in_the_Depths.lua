--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Dweller in the Depths  (ID: 46508640)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Dragon
-- Level: 3
-- ATK 1500 | DEF 700
-- Scope: OCG / TCG
--
-- Effect Text:
-- Gains 300 ATK for each Continuous Spell in your Spell & Trap Zone.
--[[ __CARD_HEADER_END__ ]]

--龍脈に棲む者
function c46508640.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c46508640.atkval)
	c:RegisterEffect(e1)
end
function c46508640.cfilter(c)
	return c:IsFaceup() and c:GetType()==TYPE_SPELL+TYPE_CONTINUOUS and c:GetSequence()~=5
end
function c46508640.atkval(e,c)
	return Duel.GetMatchingGroupCount(c46508640.cfilter,c:GetControler(),LOCATION_SZONE,0,nil)*300
end
