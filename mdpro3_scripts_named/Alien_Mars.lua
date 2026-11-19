--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-11-19T23:32:31
-- Source DB: cards.cdb
-- Card: Alien Mars  (ID: 99532708)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Reptile
-- Level: 3
-- ATK 1000 | DEF 1000
-- Setcode: 0xc
-- Scope: OCG / TCG
--
-- Effect Text:
-- The effects of Effect Monsters with A-Counters are negated, except for "Alien Mars".
--[[ __CARD_HEADER_END__ ]]

--エーリアン・マーズ
function c99532708.initial_effect(c)
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetTarget(c99532708.distg)
	c:RegisterEffect(e1)
end
c99532708.mentioned_counter={
	[0x100e]=true,
}
function c99532708.distg(e,c)
	return c:GetCounter(0x100e)>0 and not c:IsCode(99532708)
end
