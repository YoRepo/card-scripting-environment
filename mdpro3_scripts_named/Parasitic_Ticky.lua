--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 寄生体 壁虱  (ID: 87978805)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Insect
-- Level 1
-- ATK ? | DEF ?
--
-- Effect Text:
-- 这张卡的攻击力·守备力是场上的衍生物的数量×500的数值。
--[[ __CARD_HEADER_END__ ]]

--寄生体ダニー
function c87978805.initial_effect(c)
	--atk/def
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_SET_ATTACK)
	e1:SetValue(c87978805.val)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_DEFENSE)
	c:RegisterEffect(e2)
end
function c87978805.val(e,c)
	return Duel.GetMatchingGroupCount(Card.IsType,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,nil,TYPE_TOKEN)*500
end
