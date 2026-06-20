--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 元素英雄 火焰女郎  (ID: 95362816)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Pyro
-- Level 4
-- ATK 1300 | DEF 1000
-- Setcode: 12296
--
-- Effect Text:
-- 自己回合的结束阶段时，给与对方基本分自己场上表侧表示存在的名字带有「元素英雄」的怪兽数量×200的数值的伤害。
--[[ __CARD_HEADER_END__ ]]

--E・HERO レディ・オブ・ファイア
function c95362816.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(95362816,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c95362816.condition)
	e1:SetTarget(c95362816.target)
	e1:SetOperation(c95362816.operation)
	c:RegisterEffect(e1)
end
function c95362816.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c95362816.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x3008)
end
function c95362816.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ct=Duel.GetMatchingGroupCount(c95362816.filter,tp,LOCATION_MZONE,0,nil)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,ct*200)
end
function c95362816.operation(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local ct=Duel.GetMatchingGroupCount(c95362816.filter,tp,LOCATION_MZONE,0,nil)
	Duel.Damage(p,ct*200,REASON_EFFECT)
end
