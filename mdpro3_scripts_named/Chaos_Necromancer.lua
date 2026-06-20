--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 混沌死灵师  (ID: 1434352)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 1
-- ATK 0 | DEF 0
-- Setcode: 207
--
-- Effect Text:
-- 这张卡的攻击力为自己墓地里存在的怪兽卡数量×300点的数值。
--[[ __CARD_HEADER_END__ ]]

--カオス・ネクロマンサー
function c1434352.initial_effect(c)
	--attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c1434352.atkval)
	c:RegisterEffect(e1)
end
function c1434352.atkval(e,c)
	return Duel.GetMatchingGroupCount(Card.IsType,c:GetControler(),LOCATION_GRAVE,0,nil,TYPE_MONSTER)*300
end
