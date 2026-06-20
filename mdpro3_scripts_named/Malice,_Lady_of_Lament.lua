--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 恶魔娘 玛莉丝  (ID: 25643346)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 3
-- ATK 1000 | DEF 1000
-- Setcode: 372
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：把自己场上2只怪兽解放，从自己墓地的卡以及除外的自己的卡之中以1张通常陷阱卡为对象才能发动。那张卡在自己场上盖放。这个效果盖放的卡从场上离开的场合回到持有者卡组最下面。这个效果在对方回合也能发动。
--[[ __CARD_HEADER_END__ ]]

--悪魔嬢マリス
function c25643346.initial_effect(c)
	--set
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(25643346,0))
	e1:SetCategory(CATEGORY_SSET)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCountLimit(1,25643346)
	e1:SetCost(c25643346.stcost)
	e1:SetTarget(c25643346.sttg)
	e1:SetOperation(c25643346.stop)
	c:RegisterEffect(e1)
end
function c25643346.stcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,aux.TRUE,2,nil) end
	local g=Duel.SelectReleaseGroup(tp,aux.TRUE,2,2,nil)
	Duel.Release(g,REASON_COST)
end
function c25643346.stfilter(c)
	return (c:IsFaceup() or c:IsLocation(LOCATION_GRAVE)) and c:GetType()==TYPE_TRAP and c:IsSSetable()
end
function c25643346.sttg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE+LOCATION_REMOVED) and chkc:IsControler(tp) and c25643346.stfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c25643346.stfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectTarget(tp,c25643346.stfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,1,0,0)
end
function c25643346.stop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SSet(tp,tc)~=0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_REDIRECT)
		e1:SetValue(LOCATION_DECKBOT)
		tc:RegisterEffect(e1)
	end
end
