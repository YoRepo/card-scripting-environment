--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 雷骑手  (ID: 31173519)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Thunder
-- Level 3
-- ATK 1200 | DEF 1400
--
-- Effect Text:
-- 这张卡和对方怪兽进行过战斗的场合，那只怪兽只要在场上表侧表示存在不能攻击。
--[[ __CARD_HEADER_END__ ]]

--ライライダー
function c31173519.initial_effect(c)
	--atk limit
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(31173519,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLED)
	e1:SetCondition(c31173519.condition)
	e1:SetOperation(c31173519.operation)
	c:RegisterEffect(e1)
end
function c31173519.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetBattleTarget()
	return tc and not tc:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c31173519.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetBattleTarget()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	tc:RegisterEffect(e1)
end
