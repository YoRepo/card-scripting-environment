--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 女武神的拥抱  (ID: 45584727)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 290
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张，这张卡发动的回合，自己不是「女武神」怪兽不能特殊召唤。
-- ①：自己场上的怪兽只有「女武神」怪兽的场合，以自己场上1只攻击表示的「女武神」怪兽和对方场上1只表侧表示怪兽为对象才能发动。那只自己怪兽变成守备表示，那只对方怪兽除外。
--[[ __CARD_HEADER_END__ ]]

--ワルキューレの抱擁
function c45584727.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,45584727+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c45584727.rmcost)
	e1:SetCondition(c45584727.rmcon)
	e1:SetTarget(c45584727.rmtg)
	e1:SetOperation(c45584727.rmop)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(45584727,ACTIVITY_SPSUMMON,c45584727.counterfilter)
end
function c45584727.counterfilter(c)
	return c:IsSetCard(0x122)
end
function c45584727.rmcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(45584727,tp,ACTIVITY_SPSUMMON)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetLabelObject(e)
	e1:SetTarget(c45584727.splimit)
	Duel.RegisterEffect(e1,tp)
end
function c45584727.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsSetCard(0x122)
end
function c45584727.cfilter(c)
	return c:IsSetCard(0x122)
end
function c45584727.cfilter2(c)
	return c:IsFacedown() or not c:IsSetCard(0x122)
end
function c45584727.rmcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c45584727.cfilter,tp,LOCATION_MZONE,0,1,nil)
		and not Duel.IsExistingMatchingCard(c45584727.cfilter2,tp,LOCATION_MZONE,0,1,nil)
end
function c45584727.tgfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x122) and c:IsPosition(POS_FACEUP_ATTACK)
end
function c45584727.rmfilter(c)
	return c:IsFaceup() and c:IsAbleToRemove()
end
function c45584727.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c45584727.tgfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingTarget(c45584727.rmfilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g1=Duel.SelectTarget(tp,c45584727.tgfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g2=Duel.SelectTarget(tp,c45584727.rmfilter,tp,0,LOCATION_MZONE,1,1,nil)
	e:SetLabelObject(g2:GetFirst())
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g1,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g2,1,0,0)
end
function c45584727.rmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local hc=e:GetLabelObject()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tc=g:GetFirst()
	if tc==hc then tc=g:GetNext() end
	if tc:IsFaceup() and tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e)
		and Duel.ChangePosition(tc,POS_FACEUP_DEFENSE)>0 and hc:IsRelateToEffect(e) then
		Duel.Remove(hc,POS_FACEUP,REASON_EFFECT)
	end
end
