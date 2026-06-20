--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 姆卡姆卡  (ID: 46657337)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Rock
-- Level 2
-- ATK 600 | DEF 300
--
-- Effect Text:
-- 只要这张卡表侧表示在场上存在，控制者手上每有1张卡，这张卡的攻击力·守备力上升300。
--[[ __CARD_HEADER_END__ ]]

--ムカムカ
function c46657337.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c46657337.val)
	c:RegisterEffect(e1)
	--defup
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e2)
end
function c46657337.val(e,c)
	return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_HAND,0)*300
end
