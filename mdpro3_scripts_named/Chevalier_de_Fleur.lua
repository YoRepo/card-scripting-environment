--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 鲜花骑士  (ID: 45037489)
-- Type: Monster / Effect / Synchro
-- Attribute: WIND
-- Race: Warrior
-- Level 8
-- ATK 2700 | DEF 2300
--
-- Effect Text:
-- 「鲜花同调士」＋调整以外的怪兽1只以上
-- ①：1回合1次，自己回合对方把魔法·陷阱卡发动时才能发动。那个发动无效并破坏。
--[[ __CARD_HEADER_END__ ]]

--フルール・ド・シュヴァリエ
function c45037489.initial_effect(c)
	aux.AddMaterialCodeList(c,19642774)
	--synchro summon
	aux.AddSynchroProcedure(c,c45037489.tfilter,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(45037489,0))
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c45037489.discon)
	e1:SetTarget(c45037489.distg)
	e1:SetOperation(c45037489.disop)
	c:RegisterEffect(e1)
end
c45037489.material_setcode=0x1017
function c45037489.tfilter(c)
	return c:IsCode(19642774) or c:IsHasEffect(20932152)
end
function c45037489.discon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and rp==1-tp and tp==Duel.GetTurnPlayer()
		and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
end
function c45037489.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c45037489.disop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
