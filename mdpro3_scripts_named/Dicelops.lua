--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 骰子独眼巨人  (ID: 62893810)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Machine
-- Level 4
-- ATK 1800 | DEF 200
--
-- Effect Text:
-- ①：1回合1次，自己主要阶段才能发动。掷1次骰子，出现的数目的效果适用。
-- ●1：把对方手卡确认，从那之中选1张卡丢弃。
-- ●2～5：选自己1张手卡丢弃。
-- ●6：自己手卡全部丢弃。
--[[ __CARD_HEADER_END__ ]]

--サイコロプス
function c62893810.initial_effect(c)
	--dice
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_HANDES+CATEGORY_DICE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c62893810.target)
	e1:SetOperation(c62893810.operation)
	c:RegisterEffect(e1)
end
function c62893810.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g1=Duel.GetFieldGroup(tp,LOCATION_HAND,LOCATION_HAND)
	if chk==0 then return g1:GetCount()~=0 end
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,1)
	Duel.SetOperationInfo(0,CATEGORY_HANDES,g1,1,0,0)
end
function c62893810.operation(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.TossDice(tp,1)
	if d==1 then
		local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
		if g:GetCount()==0 then return end
		Duel.ConfirmCards(tp,g)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoGrave(sg,REASON_EFFECT+REASON_DISCARD)
		Duel.ShuffleHand(1-tp)
	elseif d==6 then
		local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
		if g:GetCount()==0 then return end
		Duel.SendtoGrave(g,REASON_EFFECT+REASON_DISCARD)
	elseif d>=2 and d<=5 then
		local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
		if g:GetCount()==0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoGrave(sg,REASON_EFFECT+REASON_DISCARD)
		Duel.ShuffleHand(tp)
	end
end
