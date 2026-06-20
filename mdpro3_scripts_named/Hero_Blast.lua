--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 英雄爆破  (ID: 37412656)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：以自己墓地1只「元素英雄」通常怪兽为对象才能发动。那只怪兽加入手卡。那之后，选持有加入手卡的怪兽的攻击力以下的攻击力的对方场上1只怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--ヒーロー・ブラスト
function c37412656.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetTarget(c37412656.target)
	e1:SetOperation(c37412656.activate)
	c:RegisterEffect(e1)
end
function c37412656.filter(c)
	return c:IsSetCard(0x3008) and c:IsType(TYPE_NORMAL) and c:IsAbleToHand()
end
function c37412656.dfilter(c,atk)
	return c:IsFaceup() and c:IsAttackBelow(atk)
end
function c37412656.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c37412656.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c37412656.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c37412656.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
	local tc=g:GetFirst()
	local dg=Duel.GetMatchingGroup(c37412656.dfilter,tp,0,LOCATION_MZONE,nil,tc:GetAttack())
	if dg:GetCount()>0 then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg,1,0,0)
	end
end
function c37412656.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SendtoHand(tc,nil,REASON_EFFECT)~=0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local dg=Duel.SelectMatchingCard(tp,c37412656.dfilter,tp,0,LOCATION_MZONE,1,1,nil,tc:GetAttack())
		if dg:GetCount()>0 then
			Duel.BreakEffect()
			Duel.Destroy(dg,REASON_EFFECT)
		end
	end
end
