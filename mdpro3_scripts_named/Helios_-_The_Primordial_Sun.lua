--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 原始太阳 赫利俄斯  (ID: 54493213)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Pyro
-- Level 4
-- ATK ? | DEF ?
--
-- Effect Text:
-- ①：这张卡的攻击力·守备力变成除外状态的怪兽数量×100。
--[[ __CARD_HEADER_END__ ]]

--原始太陽ヘリオス
function c54493213.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_SET_ATTACK)
	e1:SetValue(c54493213.value)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_DEFENSE)
	c:RegisterEffect(e2)
end
function c54493213.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER)
end
function c54493213.value(e,c)
	return Duel.GetMatchingGroupCount(c54493213.filter,c:GetControler(),LOCATION_REMOVED,LOCATION_REMOVED,nil)*100
end
