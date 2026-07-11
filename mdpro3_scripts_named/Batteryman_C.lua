--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Batteryman C  (ID: 19733961)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Thunder
-- Level: 2
-- ATK 0 | DEF 0
-- Setcode: 0x28
-- Scope: OCG / TCG
--
-- Effect Text:
-- If all "Batteryman C"(s) you control are in Attack Position, all Machine-Type monsters you control
-- gain 500 ATK for each "Batteryman C" you control.
-- If all "Batteryman C"(s) you control are in Defense Position, all Machine-Type monsters you control
-- gain 500 DEF for each "Batteryman C" you control.
--[[ __CARD_HEADER_END__ ]]

--電池メン－単二型
function c19733961.initial_effect(c)
	--atk,def
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_MACHINE))
	e1:SetValue(c19733961.atkval)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	e2:SetValue(c19733961.defval)
	c:RegisterEffect(e2)
end
function c19733961.filter(c)
	return c:IsFaceup() and c:IsCode(19733961)
end
function c19733961.atkval(e,c)
	local g=Duel.GetMatchingGroup(c19733961.filter,c:GetControler(),LOCATION_MZONE,0,nil)
	if g:IsExists(Card.IsDefensePos,1,nil) then return 0 end
	return 500
end
function c19733961.defval(e,c)
	local g=Duel.GetMatchingGroup(c19733961.filter,c:GetControler(),LOCATION_MZONE,0,nil)
	if g:IsExists(Card.IsAttackPos,1,nil) then return 0 end
	return 500
end
