--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 世坏同心  (ID: 36920182)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：可以从以下效果选择1个发动。
-- ●从自己墓地把1只攻击力1500/守备力2100的怪兽特殊召唤。
-- ●自己的场上（表侧表示）·墓地·除外状态的1只「维萨斯-斯塔弗罗斯特」和4只攻击力1500/守备力2100的怪兽回到卡组，把1只「维萨斯」同调怪兽当作同调召唤从额外卡组特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--世壊同心
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,56099748)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.spfilter(c,e,tp)
	return c:IsAttack(1500) and c:IsDefense(2100) and c:IsType(TYPE_MONSTER)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function s.tdfilter1(c)
	return c:IsCode(56099748)
end
function s.tdfilter2(c)
	return c:IsAttack(1500) and c:IsDefense(2100)
end
function s.tdcheck(g,e,tp)
	if not Duel.IsExistingMatchingCard(s.synfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,g) then return false end
	local g1=g:Filter(s.tdfilter1,nil)
	if #g1==1 and g:FilterCount(s.tdfilter2,g1)==4 then return true end
	return g:CheckSubGroupEach({s.tdfilter1,s.tdfilter2,s.tdfilter2,s.tdfilter2,s.tdfilter2})
end
function s.gcheck(g)
	return #g==1 or g:IsExists(s.tdfilter1,1,nil)
end
function s.synfilter(c,e,tp,g)
	return c:IsSetCard(0x198) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SYNCHRO,tp,false,false)
		and (g==nil or Duel.GetLocationCountFromEx(tp,tp,g,c)>0)
end
function s.tdfilter(c)
	return (s.tdfilter1(c) or s.tdfilter2(c)) and c:IsFaceupEx() and c:IsAbleToDeck()
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local b1=Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp)
	if chk==0 and b1 then return true end
	local g=Duel.GetMatchingGroup(s.tdfilter,tp,LOCATION_MZONE+LOCATION_GRAVE+LOCATION_REMOVED,0,nil)
	aux.GCheckAdditional=s.gcheck
	local b2=Duel.IsExistingMatchingCard(s.synfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,nil)
		and g:CheckSubGroup(s.tdcheck,5,5,e,tp)
	aux.GCheckAdditional=nil
	if chk==0 then return b1 or b2 end
	local op=0
	if b1 and b2 then
		op=Duel.SelectOption(tp,aux.Stringid(id,0),aux.Stringid(id,1))
	elseif b1 then
		op=Duel.SelectOption(tp,aux.Stringid(id,0))
	else
		op=Duel.SelectOption(tp,aux.Stringid(id,1))+1
	end
	e:SetLabel(op)
	if op==0 then
		e:SetCategory(CATEGORY_SPECIAL_SUMMON)
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
	else
		e:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TODECK)
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
		Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,5,tp,LOCATION_MZONE+LOCATION_GRAVE+LOCATION_REMOVED)
	end
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()==0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(s.spfilter),tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	else
		local g=Duel.GetMatchingGroup(aux.NecroValleyFilter(s.tdfilter),tp,LOCATION_MZONE+LOCATION_GRAVE+LOCATION_REMOVED,0,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local sg=g:SelectSubGroup(tp,s.tdcheck,false,5,5,e,tp)
		if sg then
			Duel.HintSelection(sg)
			if Duel.SendtoDeck(sg,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)~=0 then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
				local tg=Duel.SelectMatchingCard(tp,s.synfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,nil)
				local tc=tg:GetFirst()
				if tc then
					Duel.SpecialSummon(tc,SUMMON_TYPE_SYNCHRO,tp,tp,false,false,POS_FACEUP)
					tc:CompleteProcedure()
				end
			end
		end
	end
end
