--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Talaya, Princess of Cherry Blossoms  (ID: 80190753)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Plant
-- Level: 8
-- ATK 2800 | DEF 1200
-- Scope: OCG / TCG
--
-- Effect Text:
-- Gains 100 ATK for each Plant monster you control.
-- Other Plant monsters on the field cannot be destroyed by card effects.
--[[ __CARD_HEADER_END__ ]]

--桜姫タレイア
function c80190753.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c80190753.val)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c80190753.target)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
function c80190753.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_PLANT)
end
function c80190753.val(e,c)
	return Duel.GetMatchingGroupCount(c80190753.filter,c:GetControler(),LOCATION_MZONE,0,nil)*100
end
function c80190753.target(e,c)
	return c~=e:GetHandler() and c:IsRace(RACE_PLANT)
end
