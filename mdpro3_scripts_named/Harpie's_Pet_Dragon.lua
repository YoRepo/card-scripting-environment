--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:48
-- Source DB: cards.cdb
-- Card: Harpie's Pet Dragon  (ID: 52040216)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Dragon
-- Level: 7
-- ATK 2000 | DEF 2500
-- Setcode: 0x64
-- Scope: OCG / TCG
--
-- Effect Text:
-- Gains 300 ATK/DEF for each "Harpie Lady" on the field.
--[[ __CARD_HEADER_END__ ]]

--ハーピィズペット竜
function c52040216.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c52040216.val)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e2)
end
function c52040216.val(e,c)
	return Duel.GetMatchingGroupCount(c52040216.filter,c:GetControler(),LOCATION_ONFIELD,LOCATION_ONFIELD,nil)*300
end
function c52040216.filter(c)
	return c:IsFaceup() and c:IsCode(76812113)
end
