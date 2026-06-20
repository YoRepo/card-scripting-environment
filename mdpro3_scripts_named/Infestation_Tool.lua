--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 侵略的手段  (ID: 27207573)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 101
--
-- Effect Text:
-- 从自己卡组把1只名字带有「侵入魔鬼」的怪兽送去墓地，选择自己场上表侧表示存在的1只名字带有「侵入魔鬼」的怪兽发动。选择的怪兽的攻击力直到结束阶段时上升800。
--[[ __CARD_HEADER_END__ ]]

--侵略の手段
function c27207573.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(aux.dscon)
	e1:SetCost(c27207573.cost)
	e1:SetTarget(c27207573.target)
	e1:SetOperation(c27207573.activate)
	c:RegisterEffect(e1)
end
function c27207573.cfilter(c)
	return c:IsSetCard(0x100a) and c:IsType(TYPE_MONSTER) and c:IsAbleToGraveAsCost()
end
function c27207573.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c27207573.cfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c27207573.cfilter,tp,LOCATION_DECK,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c27207573.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x100a)
end
function c27207573.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c27207573.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c27207573.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c27207573.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c27207573.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(800)
		tc:RegisterEffect(e1)
	end
end
