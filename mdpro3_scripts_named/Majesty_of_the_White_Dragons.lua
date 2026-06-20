--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 白龙的威光  (ID: 43219114)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：选自己的手卡·场上（表侧表示）·墓地最多3只「青眼白龙」，给双方确认。那之后，确认数量的对方场上的卡破坏。
-- ②：把墓地的这张卡除外才能发动。等级合计直到变成和仪式召唤的怪兽相同为止，把自己的手卡·场上的「青眼白龙」解放，从手卡把1只仪式怪兽仪式召唤。
--[[ __CARD_HEADER_END__ ]]

--白き龍の威光
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,89631139)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,id)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
	--spsummon
	local e2=aux.AddRitualProcEqual2(c,nil,nil,nil,s.mfilter,true)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCountLimit(1,id+o)
	e2:SetHintTiming(0,TIMING_END_PHASE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCost(aux.bfgcost)
	c:RegisterEffect(e2)
end
function s.chkfilter(c)
	return c:IsFaceupEx() and c:IsCode(89631139)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.chkfilter,tp,LOCATION_HAND+LOCATION_GRAVE+LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(nil,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(nil,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local dg=Duel.GetMatchingGroup(nil,tp,0,LOCATION_ONFIELD,nil)
	local g=Duel.GetMatchingGroup(s.chkfilter,tp,LOCATION_HAND+LOCATION_GRAVE+LOCATION_MZONE,0,nil)
	local ct=math.min(3,math.min(dg:GetCount(),g:GetCount()))
	if ct==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local rg=g:Select(tp,1,ct,nil)
	if rg:GetCount()>0 then
		local hg=rg:Filter(Card.IsLocation,nil,LOCATION_HAND)
		local og=rg-hg
		Duel.ConfirmCards(1-tp,hg)
		Duel.HintSelection(og)
		if hg:GetCount()>=1 then
			Duel.ShuffleHand(tp)
		end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local sg=dg:Select(tp,rg:GetCount(),rg:GetCount(),nil)
		Duel.HintSelection(sg)
		Duel.Destroy(sg,REASON_EFFECT)
	end
end
function s.mfilter(c,e,tp,chk)
	return (not chk or c~=e:GetHandler()) and c:IsCode(89631139)
end
