--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 傅科魔炮石  (ID: 43785278)
-- Type: Monster / Normal / Pendulum
-- Attribute: DARK
-- Race: Spellcaster
-- Level 5
-- Pendulum Scales: L2 / R2
-- ATK 2200 | DEF 1200
--
-- Effect Text:
-- ←2 【灵摆】 2→
-- ①：这张卡发动的回合的结束阶段，以场上1张表侧表示的魔法·陷阱卡为对象才能发动。那张卡破坏。
-- 【怪兽描述】
-- 是彷徨于梦幻空间的机关生命体，本应是如此。
-- 最大的谜团是，过去的记录却几乎··留下来。
-- 那理由···呢，·····干涉···它在···拒··？
-- ···消去···
--[[ __CARD_HEADER_END__ ]]

--フーコーの魔砲石
function c43785278.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c,false)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(1160)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(c43785278.reg)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(43785278,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCondition(c43785278.descon)
	e2:SetTarget(c43785278.destg)
	e2:SetOperation(c43785278.desop)
	c:RegisterEffect(e2)
end
function c43785278.reg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	e:GetHandler():RegisterFlagEffect(43785278,RESET_PHASE+PHASE_END,EFFECT_FLAG_OATH,1)
end
function c43785278.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(43785278)~=0
end
function c43785278.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c43785278.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c43785278.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c43785278.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c43785278.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c43785278.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
