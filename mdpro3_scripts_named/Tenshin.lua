--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 转身天使  (ID: 59563768)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 2
-- ATK 800 | DEF 100
--
-- Effect Text:
-- 这张卡的攻击力上升自己场上表侧表示存在的2星怪兽数量×400的数值。
--[[ __CARD_HEADER_END__ ]]

--転身テンシーン
function c59563768.initial_effect(c)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(c59563768.atkval)
	c:RegisterEffect(e2)
end
function c59563768.filter(c)
	return c:IsFaceup() and c:IsLevel(2)
end
function c59563768.atkval(e,c)
	return Duel.GetMatchingGroupCount(c59563768.filter,e:GetHandlerPlayer(),LOCATION_MZONE,0,nil)*400
end
