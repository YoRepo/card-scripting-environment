--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Predaplant Dragostapelia  (ID: 69946549)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Plant
-- Level: 8
-- ATK 2700 | DEF 1900
-- Setcode: 0x10f3
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 Fusion Monster + 1 DARK monster
-- Once per turn (Quick Effect): You can target 1 face-up monster your opponent controls; place 1
-- Predator Counter on it, and if it is Level 2 or higher, it becomes Level 1 as long as it has a
-- Predator Counter.
-- Negate the activated effects of your opponent's monsters that have Predator Counters.
--[[ __CARD_HEADER_END__ ]]

--捕食植物ドラゴスタペリア
function c69946549.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsFusionType,TYPE_FUSION),aux.FilterBoolFunction(Card.IsFusionAttribute,ATTRIBUTE_DARK),true)
	--add counter
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(69946549,0))
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetTarget(c69946549.cttg)
	e1:SetOperation(c69946549.ctop)
	c:RegisterEffect(e1)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAIN_SOLVING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c69946549.discon)
	e2:SetOperation(c69946549.disop)
	c:RegisterEffect(e2)
end
function c69946549.cttg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and chkc:IsCanAddCounter(0x1041,1) end
	if chk==0 then return Duel.IsExistingTarget(Card.IsCanAddCounter,tp,0,LOCATION_MZONE,1,nil,0x1041,1) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsCanAddCounter,tp,0,LOCATION_MZONE,1,1,nil,0x1041,1)
end
function c69946549.ctop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:AddCounter(0x1041,1) and tc:IsLevelAbove(2) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetCondition(c69946549.lvcon)
		e1:SetValue(1)
		tc:RegisterEffect(e1)
	end
end
function c69946549.lvcon(e)
	return e:GetHandler():GetCounter(0x1041)>0
end
function c69946549.discon(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) then return false end
	return rp==1-tp and re:IsActiveType(TYPE_MONSTER) and re:GetHandler():GetCounter(0x1041)>0
end
function c69946549.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
end
