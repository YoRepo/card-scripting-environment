--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 魔术师的配合  (ID: 86509711)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：1回合1次，魔法·陷阱·怪兽的效果发动时，把自己场上1只「黑魔术师」或者「黑魔术少女」解放才能发动。从自己的手卡·墓地选和解放的怪兽卡名不同的1只「黑魔术师」或者「黑魔术少女」特殊召唤，那个发动的
-- 效果无效。
-- ②：魔法与陷阱区域的表侧表示的这张卡被送去墓地的场合才能发动。选场上1张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--マジシャンズ・コンビネーション
function c86509711.initial_effect(c)
	aux.AddCodeList(c,46986414,38033121)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(86509711,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(86509711,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DISABLE)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_CHAINING)
	e2:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e2:SetCondition(c86509711.spcon)
	e2:SetCost(c86509711.spcost)
	e2:SetTarget(c86509711.sptg)
	e2:SetOperation(c86509711.spop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_SZONE)
	c:RegisterEffect(e3)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_TO_GRAVE)
	e4:SetProperty(EFFECT_FLAG_DELAY)
	e4:SetCondition(c86509711.descon)
	e4:SetTarget(c86509711.destg)
	e4:SetOperation(c86509711.desop)
	c:RegisterEffect(e4)
end
function c86509711.cfilter(c,e,tp)
	return c:IsCode(46986414,38033121) and c:IsReleasable() and Duel.GetMZoneCount(tp,c)>0
		and Duel.IsExistingMatchingCard(c86509711.spfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp,c:GetCode())
end
function c86509711.spfilter(c,e,tp,code)
	return not c:IsCode(code) and c:IsCode(46986414,38033121) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c86509711.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsChainDisablable(ev)
end
function c86509711.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(100)
	return true
end
function c86509711.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then
		if e:GetLabel()~=100 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c86509711.cfilter,tp,LOCATION_MZONE,0,1,nil,e,tp) and c:GetFlagEffect(86509711)==0
	end
	c:RegisterFlagEffect(86509711,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectMatchingCard(tp,c86509711.cfilter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	e:SetLabel(g:GetFirst():GetCode())
	Duel.Release(g,REASON_COST)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function c86509711.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c86509711.spfilter),tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp,e:GetLabel())
	if g:GetCount()>0 and Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)~=0 then
		Duel.NegateEffect(ev)
	end
end
function c86509711.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousPosition(POS_FACEUP) and c:IsPreviousLocation(LOCATION_SZONE)
end
function c86509711.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c86509711.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
