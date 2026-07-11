--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Silent Magician LV8  (ID: 72443568)
-- Type: Monster / Effect / Special Summon
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level: 8
-- ATK 3500 | DEF 1000
-- Setcode: 0xe8, 0x41
-- Scope: OCG / TCG
--
-- Effect Text:
-- Cannot be Normal Summoned/Set.
-- Must be Special Summoned by "Silent Magician LV4".
-- Unaffected by your opponent's Spell effects.
--[[ __CARD_HEADER_END__ ]]

--サイレント・マジシャン LV8
function c72443568.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--immune spell
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c72443568.efilter)
	c:RegisterEffect(e2)
end
c72443568.lvup={73665146}
c72443568.lvdn={73665146}
function c72443568.efilter(e,te)
	return te:IsActiveType(TYPE_SPELL) and te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
