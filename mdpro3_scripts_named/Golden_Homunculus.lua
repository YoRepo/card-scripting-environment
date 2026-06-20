--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 黄金人工生命体  (ID: 27408609)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level 6
-- ATK 1500 | DEF 1500
--
-- Effect Text:
-- 这张卡的攻击力·守备力上升从游戏中除外的自己的卡数量×300的数值。
--[[ __CARD_HEADER_END__ ]]

--黄金のホムンクルス
function c27408609.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c27408609.value)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	e2:SetValue(c27408609.value)
	c:RegisterEffect(e2)
end
function c27408609.value(e,c)
	return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_REMOVED,0)*300
end
