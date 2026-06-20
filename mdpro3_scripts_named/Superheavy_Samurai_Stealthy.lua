--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 超重武者 隐密-32  (ID: 10333641)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level 1
-- ATK 200 | DEF 700
-- Setcode: 154
--
-- Effect Text:
-- 这个卡名的①的方法的特殊召唤1回合只能有1次，②的效果1回合只能使用1次。
-- ①：自己墓地没有魔法·陷阱卡存在的场合，这张卡可以从手卡特殊召唤。
-- ②：自己墓地没有魔法·陷阱卡存在的场合，把这张卡解放，以对方墓地1张魔法·陷阱卡为对象才能发动。那张卡在自己场上盖放。这个效果盖放的卡从场上离开的场合除外。这个效果在对方回合也能发动。
--[[ __CARD_HEADER_END__ ]]

--超重武者オン－32
function c10333641.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,10333641+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c10333641.spcon)
	c:RegisterEffect(e1)
	--set
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SSET)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,10333642)
	e2:SetHintTiming(0,TIMING_END_PHASE)
	e2:SetCondition(c10333641.setcon)
	e2:SetCost(c10333641.setcost)
	e2:SetTarget(c10333641.settg)
	e2:SetOperation(c10333641.setop)
	c:RegisterEffect(e2)
end
function c10333641.setcon(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_GRAVE,0,1,nil,TYPE_SPELL+TYPE_TRAP)
end
function c10333641.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return c10333641.setcon(e,tp) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
end
function c10333641.setcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsReleasable() end
	Duel.Release(c,REASON_COST)
end
function c10333641.setfilter(c,ft)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsSSetable(true) and (c:IsType(TYPE_FIELD) or ft>0)
end
function c10333641.settg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_GRAVE) and c10333641.setfilter(chkc,ft) end
	if chk==0 then return Duel.IsExistingTarget(c10333641.setfilter,tp,0,LOCATION_GRAVE,1,nil,ft) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectTarget(tp,c10333641.setfilter,tp,0,LOCATION_GRAVE,1,1,nil,ft)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,1,0,0)
end
function c10333641.setop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SSet(tp,tc)~=0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e1:SetReset(RESET_EVENT+RESETS_REDIRECT)
		e1:SetValue(LOCATION_REMOVED)
		tc:RegisterEffect(e1,true)
	end
end
