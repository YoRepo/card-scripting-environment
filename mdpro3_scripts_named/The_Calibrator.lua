--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 测量器人  (ID: 54706054)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Thunder
-- Level 4
-- ATK 1500 | DEF 1500
--
-- Effect Text:
-- 这张卡的攻击力上升对方场上的超量怪兽的阶级合计×300的数值。
--[[ __CARD_HEADER_END__ ]]

--ザ・キャリブレーター
function c54706054.initial_effect(c)
	--attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c54706054.atkval)
	c:RegisterEffect(e1)
end
function c54706054.atkval(e,c)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,c:GetControler(),0,LOCATION_MZONE,nil)
	return g:GetSum(Card.GetRank)*300
end
