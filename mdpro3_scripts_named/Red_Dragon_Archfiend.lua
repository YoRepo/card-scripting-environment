--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 红莲魔龙  (ID: 70902743)
-- Type: Monster / Effect / Synchro
-- Attribute: DARK
-- Race: Dragon
-- Level 8
-- ATK 3000 | DEF 2000
-- Setcode: 4165
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- ①：这张卡向对方的守备表示怪兽进行攻击的伤害计算后发动。对方场上的守备表示怪兽全部破坏。
-- ②：自己结束阶段发动。这张卡在场上表侧表示存在的场合，这个回合没有攻击宣言的自己场上的其他怪兽全部破坏。
--[[ __CARD_HEADER_END__ ]]

--レッド・デーモンズ・ドラゴン
function c70902743.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--destroy1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(70902743,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLED)
	e1:SetCondition(c70902743.condition1)
	e1:SetTarget(c70902743.target1)
	e1:SetOperation(c70902743.operation1)
	c:RegisterEffect(e1)
	--destroy2
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(70902743,1))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetCondition(c70902743.condition2)
	e2:SetTarget(c70902743.target2)
	e2:SetOperation(c70902743.operation2)
	c:RegisterEffect(e2)
end
function c70902743.condition1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker()==e:GetHandler() and Duel.GetAttackTarget() and not Duel.GetAttackTarget():IsAttackPos()
end
function c70902743.filter1(c)
	return not c:IsAttackPos()
end
function c70902743.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c70902743.filter1,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c70902743.operation1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c70902743.filter1,tp,0,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
function c70902743.filter2(c)
	return c:GetAttackAnnouncedCount()==0
end
function c70902743.condition2(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c70902743.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c70902743.filter2,tp,LOCATION_MZONE,0,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c70902743.operation2(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) or e:GetHandler():IsFacedown() then return end
	local g=Duel.GetMatchingGroup(c70902743.filter2,tp,LOCATION_MZONE,0,aux.ExceptThisCard(e))
	Duel.Destroy(g,REASON_EFFECT)
end
