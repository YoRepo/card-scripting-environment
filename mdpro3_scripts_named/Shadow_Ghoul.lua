--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 影之食尸鬼  (ID: 30778711)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Zombie
-- Level 5
-- ATK 1600 | DEF 1300
--
-- Effect Text:
-- 自己的墓地每存在1只怪兽，这张卡的攻击力上升100。
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
