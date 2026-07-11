--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Machina Sniper  (ID: 23782705)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level: 4
-- ATK 1800 | DEF 800
-- Setcode: 0x36
-- Scope: OCG / TCG
--
-- Effect Text:
-- Monsters cannot attack "Machina" monsters, except "Machina Sniper".
--[[ __CARD_HEADER_END__ ]]

--マシンナーズ・スナイパー
function c23782705.initial_effect(c)
	--atk limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(c23782705.tg)
	e1:SetValue(aux.imval1)
	c:RegisterEffect(e1)
end
function c23782705.tg(e,c)
	return c:IsSetCard(0x36) and not c:IsCode(23782705)
end
