--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Dragunity Angusticlavii  (ID: 88361177)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Winged Beast
-- Level: 5
-- ATK 2100 | DEF 1000
-- Setcode: 0x29
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card attacks a Defense Position monster while equipped with a Dragon "Dragunity" monster,
-- inflict piercing battle damage.
--[[ __CARD_HEADER_END__ ]]

--ドラグニティ－アングス
function c88361177.initial_effect(c)
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PIERCE)
	e1:SetCondition(c88361177.pcon)
	c:RegisterEffect(e1)
end
function c88361177.pfilter(c)
	return c:IsSetCard(0x29) and c:IsRace(RACE_DRAGON) and c:IsFaceup()
end
function c88361177.pcon(e)
	return e:GetHandler():GetEquipGroup():IsExists(c88361177.pfilter,1,nil)
end
