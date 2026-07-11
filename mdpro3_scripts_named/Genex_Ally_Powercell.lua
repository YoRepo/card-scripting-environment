--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Genex Ally Powercell  (ID: 94622638)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level: 4
-- ATK 1700 | DEF 0
-- Setcode: 0x2
-- Scope: OCG / TCG
--
-- Effect Text:
-- Other face-up monsters you control with the same Attribute as this card gain 500 ATK.
--[[ __CARD_HEADER_END__ ]]

--A・ジェネクス・パワーコール
function c94622638.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c94622638.atktg)
	e1:SetValue(500)
	c:RegisterEffect(e1)
end
function c94622638.atktg(e,c)
	return c~=e:GetHandler() and e:GetHandler():IsAttribute(c:GetAttribute())
end
