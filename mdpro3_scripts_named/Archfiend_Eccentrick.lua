--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 古怪恶魔  (ID: 57624336)
-- Type: Monster / Effect / Pendulum
-- Attribute: LIGHT
-- Race: Fiend
-- Level 3
-- Pendulum Scales: L7 / R7
-- ATK 800 | DEF 1000
-- Setcode: 69
--
-- Effect Text:
-- ←7 【灵摆】 7→
-- 这个卡名的灵摆效果1回合只能使用1次。
-- ①：以场上1张其他的魔法·陷阱卡为对象才能发动。那张卡和这张卡破坏。
-- 【怪兽效果】
-- 这个卡名的怪兽效果1回合只能使用1次。
-- ①：把这张卡解放，以场上1只怪兽为对象才能发动。那只怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--エキセントリック・デーモン
function c57624336.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--Destroy spell & trap
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,57624336)
	e2:SetTarget(c57624336.destg1)
	e2:SetOperation(c57624336.desop1)
	c:RegisterEffect(e2)
	--Destroy monster
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1,57624337)
	e3:SetCost(c57624336.descost2)
	e3:SetTarget(c57624336.destg2)
	e3:SetOperation(c57624336.desop2)
	c:RegisterEffect(e3)
end
function c57624336.filter1(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c57624336.destg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c57624336.filter1(chkc) and chkc~=e:GetHandler() end
	if chk==0 then return e:GetHandler():IsDestructable()
		and Duel.IsExistingTarget(c57624336.filter1,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c57624336.filter1,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler())
	g:AddCard(e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,2,0,0)
end
function c57624336.desop1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(Group.FromCards(tc,e:GetHandler()),REASON_EFFECT)
	end
end
function c57624336.descost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c57624336.destg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c57624336.desop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsType(TYPE_MONSTER) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
