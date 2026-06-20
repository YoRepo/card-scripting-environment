--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 魔偶甜点·枫糖浆绵羊  (ID: 49374988)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast
-- Level 3
-- ATK 0 | DEF 1800
-- Setcode: 113
--
-- Effect Text:
-- 这张卡被对方破坏送去墓地时，这张卡回到卡组。1回合1次，选择自己场上表侧攻击表示存在的1只名字带有「魔偶甜点」的怪兽和对方场上表侧攻击表示存在的1只怪兽才能发动。选择的2只怪兽变成表侧守备表示，直到下
-- 次的对方回合结束时，选择的怪兽不能把表示形式变更。
--[[ __CARD_HEADER_END__ ]]

--マドルチェ・メェプル
function c49374988.initial_effect(c)
	--to deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(49374988,0))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c49374988.retcon)
	e1:SetTarget(c49374988.rettg)
	e1:SetOperation(c49374988.retop)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(49374988,1))
	e2:SetCategory(CATEGORY_POSITION)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c49374988.postg)
	e2:SetOperation(c49374988.posop)
	c:RegisterEffect(e2)
end
function c49374988.retcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_DESTROY) and e:GetHandler():GetReasonPlayer()==1-tp
		and e:GetHandler():IsPreviousControler(tp)
end
function c49374988.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end
function c49374988.retop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SendtoDeck(e:GetHandler(),nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end
function c49374988.filter1(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsCanChangePosition() and c:IsSetCard(0x71)
end
function c49374988.filter2(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsCanChangePosition()
end
function c49374988.postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c49374988.filter1,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingTarget(c49374988.filter2,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g1=Duel.SelectTarget(tp,c49374988.filter1,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g2=Duel.SelectTarget(tp,c49374988.filter2,tp,0,LOCATION_MZONE,1,1,nil)
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g1,2,0,0)
end
function c49374988.pfilter(c,e)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsRelateToEffect(e)
end
function c49374988.posop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(c49374988.pfilter,nil,e)
	if g:GetCount()>0 then
		Duel.ChangePosition(g,POS_FACEUP_DEFENSE)
		local tc=g:GetFirst()
		while tc do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,2)
			tc:RegisterEffect(e1)
			tc=g:GetNext()
		end
	end
end
