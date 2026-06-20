--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 霞之谷的战士  (ID: 22837504)
-- Type: Monster / Effect / Tuner
-- Attribute: WIND
-- Race: Winged Beast
-- Level 4
-- ATK 1700 | DEF 300
-- Setcode: 55
--
-- Effect Text:
-- 只要这张卡在自己场上表侧表示存在，和这张卡的战斗没被破坏的对方怪兽在伤害步骤结束时回到持有者手卡。
--[[ __CARD_HEADER_END__ ]]

--霞の谷の戦士
function c22837504.initial_effect(c)
	--return hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(22837504,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_DAMAGE_STEP_END)
	e1:SetCondition(c22837504.retcon)
	e1:SetTarget(c22837504.rettg)
	e1:SetOperation(c22837504.retop)
	c:RegisterEffect(e1)
end
function c22837504.retcon(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToBattle() then return false end
	local t=nil
	if ev==0 then t=Duel.GetAttackTarget()
	else t=Duel.GetAttacker() end
	e:SetLabelObject(t)
	return t and t:IsRelateToBattle()
end
function c22837504.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetLabelObject(),1,0,0)
end
function c22837504.retop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabelObject():IsRelateToBattle() then
		Duel.SendtoHand(e:GetLabelObject(),nil,REASON_EFFECT)
	end
end
