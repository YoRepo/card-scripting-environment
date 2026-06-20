--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 元素英雄 炽热侠  (ID: 98266377)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Pyro
-- Level 4
-- ATK 1600 | DEF 1200
-- Setcode: 12296
--
-- Effect Text:
-- ①：这张卡的攻击力上升自己场上的「元素英雄」怪兽数量×200。
--[[ __CARD_HEADER_END__ ]]

--E・HERO ザ・ヒート
function c98266377.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c98266377.val)
	c:RegisterEffect(e1)
end
function c98266377.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x3008)
end
function c98266377.val(e,c)
	return Duel.GetMatchingGroupCount(c98266377.filter,c:GetControler(),LOCATION_MZONE,0,nil)*200
end
