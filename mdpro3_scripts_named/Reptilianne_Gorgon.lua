--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 爬虫妖女·戈耳工  (ID: 43426903)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Reptile
-- Level 3
-- ATK 1400 | DEF 1400
-- Setcode: 60
--
-- Effect Text:
-- 这张卡进行攻击的伤害计算后，和这张卡进行战斗的怪兽攻击力变成0，变成不能把表示形式改变。
--[[ __CARD_HEADER_END__ ]]

--レプティレス・ゴルゴーン
function c43426903.initial_effect(c)
	--atk change
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(43426903,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLED)
	e1:SetCondition(c43426903.condition)
	e1:SetOperation(c43426903.operation)
	c:RegisterEffect(e1)
end
function c43426903.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler()==Duel.GetAttacker() and Duel.GetAttackTarget()
end
function c43426903.operation(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	if not d:IsRelateToBattle() then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetValue(0)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	d:RegisterEffect(e1)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	e2:SetReset(RESET_EVENT+RESETS_STANDARD)
	d:RegisterEffect(e2)
end
