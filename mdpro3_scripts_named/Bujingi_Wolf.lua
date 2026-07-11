--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Bujingi Wolf  (ID: 32202803)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Beast
-- Level: 4
-- ATK 1100 | DEF 2000
-- Setcode: 0x88
-- Scope: OCG / TCG
--
-- Effect Text:
-- Other Beast, Beast-Warrior, and Winged Beast-Type monsters you control cannot be destroyed by
-- battle.
--[[ __CARD_HEADER_END__ ]]

--武神器－タルタ
function c32202803.initial_effect(c)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c32202803.targt)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
function c32202803.targt(e,c)
	return c~=e:GetHandler() and c:IsRace(RACE_BEAST+RACE_BEASTWARRIOR+RACE_WINDBEAST)
end
