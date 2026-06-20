--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 电气啄木鸟  (ID: 12296376)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Thunder
-- Level 3
-- ATK 1000 | DEF 100
-- Setcode: 14
--
-- Effect Text:
-- 这张卡在同1次的战斗阶段中可以作2次攻击。和这张卡进行过战斗的怪兽不能把表示形式变更。
--[[ __CARD_HEADER_END__ ]]

--エレキツツキ
function c12296376.initial_effect(c)
	--multi attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_BATTLED)
	e2:SetOperation(c12296376.operation)
	c:RegisterEffect(e2)
end
function c12296376.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if not bc then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	bc:RegisterEffect(e1)
end
