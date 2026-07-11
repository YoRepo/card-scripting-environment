--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Goblin King  (ID: 18590133)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level: 1
-- ATK 0 | DEF 0
-- Setcode: 0xac
-- Scope: OCG / TCG
--
-- Effect Text:
-- While you control another Fiend monster, monsters cannot attack this card.
-- This card's ATK/DEF become the number of other Fiend monsters on the field x 1000.
--[[ __CARD_HEADER_END__ ]]

--キングゴブリン
function c18590133.initial_effect(c)
	--cannot be battle target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e1:SetCondition(c18590133.ccon)
	e1:SetValue(aux.imval1)
	c:RegisterEffect(e1)
	--atk,def
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_SET_ATTACK)
	e2:SetValue(c18590133.val)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_SET_DEFENSE)
	c:RegisterEffect(e3)
end
function c18590133.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_FIEND)
end
function c18590133.ccon(e)
	return Duel.IsExistingMatchingCard(c18590133.filter,e:GetHandler():GetControler(),LOCATION_MZONE,0,1,e:GetHandler())
end
function c18590133.val(e,c)
	return Duel.GetMatchingGroupCount(c18590133.filter,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,c)*1000
end
