--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 暗黑调整 灾祸盗贼  (ID: 15141103)
-- Type: Monster / Effect / Tuner
-- Attribute: DARK
-- Race: Fiend
-- Level 8
-- ATK 0 | DEF 0
-- Setcode: 478
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：把手卡的这张卡给对方观看才能发动。进行1只「暗黑调整」怪兽的召唤。
-- ②：1回合1次，这张卡是已通常召唤的场合才能发动。自己场上的同是表侧表示的持有比这张卡低的等级的除调整以外的怪兽1只和这张卡解放，和那个等级差相同等级的1只同调怪兽当作同调召唤从额外卡组特殊召唤。那之
-- 后，可以把对方场上1张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--DTカタストローグ
local s,id,o=GetID()
function s.initial_effect(c)
	--summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,id)
	e1:SetCost(s.sumcost)
	e1:SetTarget(s.sumtg)
	e1:SetOperation(s.sumop)
	c:RegisterEffect(e1)
	--summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_RELEASE+CATEGORY_SPECIAL_SUMMON+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(s.spcon)
	e2:SetTarget(s.sptg)
	e2:SetOperation(s.spop)
	c:RegisterEffect(e2)
end
function s.sumcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsPublic() end
end
function s.sumfilter(c)
	return c:IsSetCard(0x1de) and c:IsSummonable(true,nil)
end
function s.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.sumfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,0,0)
end
function s.sumop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
	local tc=Duel.SelectMatchingCard(tp,s.sumfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil):GetFirst()
	if tc then
		Duel.Summon(tp,tc,true,nil)
	end
end
function s.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_NORMAL)
end
function s.rlfilter(c,e,tp,ec)
	return c:IsLevelAbove(1) and ec:GetLevel()>c:GetLevel() and c:IsReleasable(REASON_EFFECT)
		and not c:IsType(TYPE_TUNER) and c:IsFaceup()
		and Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,ec:GetLevel()-c:GetLevel(),Group.FromCards(c,ec))
end
function s.spfilter(c,e,tp,lv,sg)
	return c:IsLevel(lv) and c:IsType(TYPE_SYNCHRO) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SYNCHRO,tp,false,false)
		and Duel.GetLocationCountFromEx(tp,tp,sg,c)>0
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(s.rlfilter,tp,LOCATION_MZONE,0,1,c,e,tp,c)
		and aux.MustMaterialCheck(nil,tp,EFFECT_MUST_BE_SMATERIAL)
		and c:IsReleasable(REASON_EFFECT) end
	Duel.SetOperationInfo(0,CATEGORY_RELEASE,nil,2,tp,LOCATION_MZONE)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToChain() or not c:IsFaceup() or not c:IsReleasable(REASON_EFFECT) then return end
	if not aux.MustMaterialCheck(nil,tp,EFFECT_MUST_BE_SMATERIAL) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local tc=Duel.SelectMatchingCard(tp,s.rlfilter,tp,LOCATION_MZONE,0,1,1,c,e,tp,c):GetFirst()
	if tc then
		local lv=c:GetLevel()-tc:GetLevel()
		if Duel.Release(Group.FromCards(c,tc),REASON_EFFECT)>0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local g=Duel.SelectMatchingCard(tp,s.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,lv,nil)
			local sc=g:GetFirst()
			if sc then
				sc:SetMaterial(nil)
				if Duel.SpecialSummon(sc,SUMMON_TYPE_SYNCHRO,tp,tp,false,false,POS_FACEUP)~=0 then
					sc:CompleteProcedure()
					if Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_ONFIELD,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(id,2)) then
						Duel.BreakEffect()
						Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
						local sg=Duel.SelectMatchingCard(tp,aux.TRUE,tp,0,LOCATION_ONFIELD,1,1,nil)
						Duel.HintSelection(sg)
						Duel.Destroy(sg,REASON_EFFECT)
					end
				end
			end
		end
	end
end
