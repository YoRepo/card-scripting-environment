--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 狂惑的落穴  (ID: 75294187)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 76
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：对方对怪兽的特殊召唤成功的回合，以对方场上1只攻击力2000以上的怪兽为对象才能发动。那只怪兽破坏。那之后，自己墓地有「洞」通常陷阱卡或者「落穴」通常陷阱卡存在的场合，可以从对方墓地选1只怪兽除外
-- 。
--[[ __CARD_HEADER_END__ ]]

--狂惑の落とし穴
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_REMOVE+CATEGORY_GRAVE_ACTION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(s.condition)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetActivityCount(1-tp,ACTIVITY_SPSUMMON)>0
end
function s.filter(c)
	return c:IsFaceup() and c:IsAttackAbove(2000)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and s.filter(chkc) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(s.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,s.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function s.cfilter(c)
	return c:GetType()==TYPE_TRAP and c:IsSetCard(0x4c,0x89)
end
function s.rmfilter(c)
	return c:IsAbleToRemove() and c:IsType(TYPE_MONSTER)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e)
		and Duel.Destroy(tc,REASON_EFFECT)>0 then
		local g=Duel.GetMatchingGroup(s.cfilter,tp,LOCATION_GRAVE,0,nil)
		local rg=Duel.GetMatchingGroup(aux.NecroValleyFilter(s.rmfilter),tp,0,LOCATION_GRAVE,nil)
		if #g>0 and #rg>0 and Duel.SelectYesNo(tp,aux.Stringid(id,0)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
			local mg=rg:Select(tp,1,1,nil)
			Duel.Remove(mg,POS_FACEUP,REASON_EFFECT)
		end
	end
end
