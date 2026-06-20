--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: DDD 咒血王 赛弗里德  (ID: 44852429)
-- Type: Monster / Effect / Synchro
-- Attribute: DARK
-- Race: Fiend
-- Level 8
-- ATK 2800 | DEF 2200
-- Setcode: 4271
--
-- Effect Text:
-- 调整＋调整以外的「DD」怪兽1只以上
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：自己·对方回合，以场上1张表侧表示的魔法·陷阱卡为对象才能发动。那张卡的效果直到下次的准备阶段无效。
-- ②：这张卡被战斗·效果破坏送去墓地的场合发动。自己回复自己场上的「契约书」卡数量×1000基本分。
--[[ __CARD_HEADER_END__ ]]

--DDD呪血王サイフリート
function c44852429.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsSetCard,0xaf),1)
	c:EnableReviveLimit()
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44852429,0))
	e1:SetCategory(CATEGORY_DISABLE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER)
	e1:SetCountLimit(1,44852429)
	e1:SetTarget(c44852429.negtg)
	e1:SetOperation(c44852429.negop)
	c:RegisterEffect(e1)
	--recover
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44852429,1))
	e2:SetCategory(CATEGORY_RECOVER)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c44852429.reccon)
	e2:SetTarget(c44852429.rectg)
	e2:SetOperation(c44852429.recop)
	c:RegisterEffect(e2)
end
function c44852429.negfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and aux.NegateAnyFilter(c)
end
function c44852429.negtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c44852429.negfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c44852429.negfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISABLE)
	local g=Duel.SelectTarget(tp,c44852429.negfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,1,0,0)
end
function c44852429.negop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) and tc:IsCanBeDisabledByEffect(e,false) then
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_DISABLE)
		if Duel.GetCurrentPhase()==PHASE_STANDBY then
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_STANDBY,2)
		else
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_STANDBY)
		end
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		tc:RegisterEffect(e2)
		if tc:IsType(TYPE_TRAPMONSTER) then
			local e3=e1:Clone()
			e3:SetCode(EFFECT_DISABLE_TRAPMONSTER)
			tc:RegisterEffect(e3)
		end
	end
end
function c44852429.reccon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_DESTROY) and c:IsReason(REASON_BATTLE+REASON_EFFECT)
end
function c44852429.recfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xae)
end
function c44852429.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ct=Duel.GetMatchingGroupCount(c44852429.recfilter,tp,LOCATION_ONFIELD,0,nil)
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,ct*1000)
end
function c44852429.recop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local ct=Duel.GetMatchingGroupCount(c44852429.recfilter,p,LOCATION_ONFIELD,0,nil)
	if ct>0 then
		Duel.Recover(p,ct*1000,REASON_EFFECT)
	end
end
