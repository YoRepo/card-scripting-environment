--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Jurrac Brachis  (ID: 8594079)
-- Type: Monster / Effect / Tuner
-- Attribute: FIRE
-- Race: Dinosaur
-- Level: 3
-- ATK 1000 | DEF 1000
-- Setcode: 0x22
-- Scope: OCG / TCG
--
-- Effect Text:
-- While another face-up "Jurrac" monster is on the field, this card cannot be destroyed by battle.
--[[ __CARD_HEADER_END__ ]]

--ジュラック・ブラキス
function c8594079.initial_effect(c)
	--battle indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetCondition(c8594079.indcon)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
function c8594079.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x22)
end
function c8594079.indcon(e)
	return Duel.IsExistingMatchingCard(c8594079.filter,0,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler())
end
