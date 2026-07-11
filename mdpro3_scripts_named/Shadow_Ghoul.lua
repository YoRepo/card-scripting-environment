--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Shadow Ghoul  (ID: 30778711)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Zombie
-- Level: 5
-- ATK 1600 | DEF 1300
-- Scope: OCG / TCG
--
-- Effect Text:
-- Gains 100 ATK for each monster in your GY.
--[[ __CARD_HEADER_END__ ]]

--シャドウ・グール
function c30778711.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c30778711.value)
	c:RegisterEffect(e1)
end
function c30778711.value(e,c)
	return Duel.GetMatchingGroupCount(Card.IsType,c:GetControler(),LOCATION_GRAVE,0,nil,TYPE_MONSTER)*100
end
