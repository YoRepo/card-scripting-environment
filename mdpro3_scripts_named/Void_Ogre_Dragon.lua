--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 炼狱龙 食人魔龙鬼  (ID: 81020646)
-- Type: Monster / Effect / Synchro
-- Attribute: DARK
-- Race: Dragon
-- Level 8
-- ATK 3000 | DEF 3000
-- Setcode: 197
--
-- Effect Text:
-- 暗属性调整＋调整以外的怪兽1只以上
-- 自己手卡是0张的场合，1回合1次，对方把魔法·陷阱卡发动时才能发动。那个发动无效并破坏。
--[[ __CARD_HEADER_END__ ]]

--煉獄龍 オーガ・ドラグーン
function c81020646.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_DARK),aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(81020646,0))
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c81020646.discon)
	e1:SetTarget(c81020646.distg)
	e1:SetOperation(c81020646.disop)
	c:RegisterEffect(e1)
end
function c81020646.discon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and ep~=tp
		and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev) and Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)==0
end
function c81020646.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c81020646.disop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
