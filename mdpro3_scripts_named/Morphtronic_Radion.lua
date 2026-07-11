--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Morphtronic Radion  (ID: 55119278)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Thunder
-- Level: 4
-- ATK 1000 | DEF 900
-- Setcode: 0x26
-- Scope: OCG / TCG
--
-- Effect Text:
-- ● While in Attack Position: "Morphtronic" monsters you control gain 800 ATK.
-- ● While in Defense Position: "Morphtronic" monsters you control gain 1000 DEF.
--[[ __CARD_HEADER_END__ ]]

--D・ラジオン
function c55119278.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetCondition(c55119278.cona)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x26))
	e1:SetValue(800)
	c:RegisterEffect(e1)
	--def
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	e2:SetCondition(c55119278.cond)
	e2:SetValue(1000)
	c:RegisterEffect(e2)
end
function c55119278.cona(e)
	return e:GetHandler():IsAttackPos()
end
function c55119278.cond(e)
	return e:GetHandler():IsDefensePos()
end
