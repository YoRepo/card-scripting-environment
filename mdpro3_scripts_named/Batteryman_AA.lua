--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Batteryman AA  (ID: 63142001)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Thunder
-- Level: 3
-- ATK 0 | DEF 0
-- Setcode: 0x28
-- Scope: OCG / TCG
--
-- Effect Text:
-- If all "Batteryman AA"(s) on your side of the field are in Attack Position, this card gains 1000 ATK
-- for each "Batteryman AA" on your side of the field.
-- If all "Batteryman AA"(s) on your side of the field are in Defense Position, this card gains 1000
-- DEF for each "Batteryman AA" on your side of the field.
--[[ __CARD_HEADER_END__ ]]

--電池メン－単三型
function c63142001.initial_effect(c)
	--atk,def
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c63142001.atkval)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	e2:SetValue(c63142001.defval)
	c:RegisterEffect(e2)
end
function c63142001.filter(c)
	return c:IsFaceup() and c:IsCode(63142001)
end
function c63142001.atkval(e,c)
	local g=Duel.GetMatchingGroup(c63142001.filter,c:GetControler(),LOCATION_MZONE,0,nil)
	if g:IsExists(Card.IsDefensePos,1,nil) then return 0 end
	return g:GetCount()*1000
end
function c63142001.defval(e,c)
	local g=Duel.GetMatchingGroup(c63142001.filter,c:GetControler(),LOCATION_MZONE,0,nil)
	if g:IsExists(Card.IsAttackPos,1,nil) then return 0 end
	return g:GetCount()*1000
end
