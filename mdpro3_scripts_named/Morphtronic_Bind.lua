--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Morphtronic Bind  (ID: 85101228)
-- Type: Trap / Continuous
-- Setcode: 0x26
-- Scope: OCG / TCG
--
-- Effect Text:
-- While you control a face-up "Morphtronic" monster, all Level 4 or higher monsters your opponent
-- controls cannot declare an attack or change their battle positions.
--[[ __CARD_HEADER_END__ ]]

--D・バインド
function c85101228.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--cannot attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetTarget(c85101228.tg)
	e2:SetCondition(c85101228.con)
	c:RegisterEffect(e2)
	--pos limit
	local e3=e2:Clone()
	e3:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	c:RegisterEffect(e3)
end
function c85101228.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x26)
end
function c85101228.con(e)
	return Duel.IsExistingMatchingCard(c85101228.filter,e:GetHandler():GetControler(),LOCATION_MZONE,0,1,nil)
end
function c85101228.tg(e,c)
	return c:IsLevelAbove(4)
end
