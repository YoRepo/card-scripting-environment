--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Golem Dragon  (ID: 9666558)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Dragon
-- Level: 4
-- ATK 200 | DEF 2000
-- Scope: OCG / TCG
--
-- Effect Text:
-- Your opponent cannot target face-up Dragon-Type monsters for attacks, except this one.
--[[ __CARD_HEADER_END__ ]]

--ゴーレム・ドラゴン
function c9666558.initial_effect(c)
	--cannot be battle target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetValue(c9666558.tg)
	c:RegisterEffect(e1)
end
function c9666558.tg(e,c)
	return c~=e:GetHandler() and c:IsFaceup() and c:IsRace(RACE_DRAGON)
end
