--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Fortress Warrior  (ID: 66288028)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level: 2
-- ATK 600 | DEF 1200
-- Setcode: 0x66
-- Scope: OCG / TCG
--
-- Effect Text:
-- You take no battle damage from attacks involving this card.
-- Once per turn, this card cannot be destroyed by battle.
--[[ __CARD_HEADER_END__ ]]

--マッシブ・ウォリアー
function c66288028.initial_effect(c)
	--battle indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e1:SetCountLimit(1)
	e1:SetValue(c66288028.valcon)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
function c66288028.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end
