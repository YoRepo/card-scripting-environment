--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 超龙灾祸  (ID: 4575541)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的①②的效果1回合只能有1次使用其中任意1个。
-- ①：自己的手卡·墓地·除外状态的1只「征龙」怪兽特殊召唤。那之后，可以只用自己场上的「征龙」怪兽为素材进行1只「征龙」超量怪兽的超量召唤。
-- ②：自己主要阶段把墓地的这张卡除外，以自己的除外状态的「征龙」怪兽任意数量为对象才能发动（相同属性最多1只）。那些怪兽回到墓地。
--[[ __CARD_HEADER_END__ ]]

--超竜災禍
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER|TIMING_END_PHASE)
	e1:SetCountLimit(1,id)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
	--to grave
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,id)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(s.tgtg)
	e2:SetOperation(s.tgop)
	c:RegisterEffect(e2)
end
function s.spfilter(c,e,tp)
	return c:IsFaceupEx() and c:IsSetCard(0x1c4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_HAND+LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE+LOCATION_REMOVED)
end
function s.mfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x1c4) and not c:IsType(TYPE_TOKEN)
end
function s.xyzfilter(c,mg)
	return c:IsSetCard(0x1c4) and c:IsXyzSummonable(mg)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(s.spfilter),tp,LOCATION_HAND+LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil,e,tp)
	if g:GetCount()>0 and Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)~=0 then
		Duel.AdjustAll()
		local mg=Duel.GetMatchingGroup(s.mfilter,tp,LOCATION_MZONE,0,nil)
		if Duel.IsExistingMatchingCard(s.xyzfilter,tp,LOCATION_EXTRA,0,1,nil,mg)
			and Duel.SelectYesNo(tp,aux.Stringid(id,2)) then
			local xyzg=Duel.GetMatchingGroup(s.xyzfilter,tp,LOCATION_EXTRA,0,nil,mg)
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local xyz=xyzg:Select(tp,1,1,nil):GetFirst()
			Duel.BreakEffect()
			Duel.XyzSummon(tp,xyz,mg,1,6)
		end
	end
end
function s.tgfilter(c,e)
	return c:IsSetCard(0x1c4) and c:IsType(TYPE_MONSTER) and c:IsCanBeEffectTarget(e) and c:IsFaceup()
end
function s.tgtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local tg=Duel.GetMatchingGroup(s.tgfilter,tp,LOCATION_REMOVED,0,nil,e)
	if chk==0 then return #tg>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_OPERATECARD)
	aux.GCheckAdditional=aux.dabcheck
	local g=tg:SelectSubGroup(tp,aux.TRUE,false,1,7)
	aux.GCheckAdditional=nil
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,g:GetCount(),0,0)
end
function s.tgop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if tg:GetCount()>0 then
		Duel.SendtoGrave(tg,REASON_EFFECT+REASON_RETURN)
	end
end
