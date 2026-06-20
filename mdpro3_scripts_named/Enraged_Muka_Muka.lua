--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 激昂的姆卡姆卡  (ID: 91862578)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Rock
-- Level 5
-- ATK 1200 | DEF 600
--
-- Effect Text:
-- 自己每有1张手卡，这张卡攻击力·守备力各上升400。
--[[ __CARD_HEADER_END__ ]]

--激昂のムカムカ
function c91862578.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c91862578.val)
	c:RegisterEffect(e1)
	--defup
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e2)
end
function c91862578.val(e,c)
	return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_HAND,0)*400
end
