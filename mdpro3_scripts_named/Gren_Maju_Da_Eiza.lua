--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 红莲魔兽 塔·伊沙  (ID: 36584821)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Fiend
-- Level 3
-- ATK ? | DEF ?
--
-- Effect Text:
-- ①：这张卡的攻击力·守备力变成自己的除外状态的卡数量×400。
--[[ __CARD_HEADER_END__ ]]

--紅蓮魔獣 ダ・イーザ
function c36584821.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_SET_ATTACK)
	e1:SetValue(c36584821.value)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_SET_DEFENSE)
	e2:SetValue(c36584821.value)
	c:RegisterEffect(e2)
end
function c36584821.value(e,c)
	return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_REMOVED,0)*400
end
