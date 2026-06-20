--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 姆多拉  (ID: 82108372)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Fairy
-- Level 4
-- ATK 1500 | DEF 1800
--
-- Effect Text:
-- 自己墓地里每存在1只天使族怪兽，这张卡的攻击力上升200点。
--[[ __CARD_HEADER_END__ ]]

--ムドラ
function c82108372.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c82108372.val)
	c:RegisterEffect(e1)
end
function c82108372.val(e,c)
	return Duel.GetMatchingGroupCount(Card.IsRace,c:GetControler(),LOCATION_GRAVE,0,nil,RACE_FAIRY)*200
end
