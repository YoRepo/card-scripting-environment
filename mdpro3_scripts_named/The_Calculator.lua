--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 计算器人  (ID: 51196174)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Thunder
-- Level 2
-- ATK ? | DEF 0
--
-- Effect Text:
-- ①：这张卡的攻击力变成自己场上的怪兽的等级合计×300。
--[[ __CARD_HEADER_END__ ]]

--ザ・カリキュレーター
function c51196174.initial_effect(c)
	--attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c51196174.atkval)
	c:RegisterEffect(e1)
end
function c51196174.atkval(e,c)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,c:GetControler(),LOCATION_MZONE,0,nil)
	return g:GetSum(Card.GetLevel)*300
end
