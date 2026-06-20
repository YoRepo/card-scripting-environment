--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 黏土冲撞  (ID: 22479888)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上的「元素英雄 黏土侠」被选择为攻击对象时才能发动（若选择的卡是里侧守备表示的场合，那张卡需要确认）。攻击怪兽和选择的「元素英雄 黏土侠」破坏，给与对方基本分800分的伤害。
--[[ __CARD_HEADER_END__ ]]

--クレイ・チャージ
function c22479888.initial_effect(c)
	aux.AddSetNameMonsterList(c,0x3008)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCondition(c22479888.condition)
	e1:SetTarget(c22479888.target)
	e1:SetOperation(c22479888.activate)
	c:RegisterEffect(e1)
end
function c22479888.condition(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	return at:IsControler(tp) and at:IsCode(84327329)
end
function c22479888.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local a=Duel.GetAttacker()
	local at=Duel.GetAttackTarget()
	if chkc then return false end
	if chk==0 then return a:IsOnField() and a:IsCanBeEffectTarget(e)
		and at:IsOnField() and at:IsCanBeEffectTarget(e) end
	if at:IsFacedown() then
		Duel.ConfirmCards(1-tp,at)
	end
	local g=Group.FromCards(a,at)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,800)
end
function c22479888.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()==2 then
		Duel.Destroy(g,REASON_EFFECT)
		Duel.Damage(1-tp,800,REASON_EFFECT)
	end
end
