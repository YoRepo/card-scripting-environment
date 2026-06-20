--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 破限疾驰  (ID: 35014241)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 「破限疾驰」在1回合只能发动1张。
-- ①：让自己场上1只同调怪兽调整和1只调整以外的同调怪兽回到额外卡组才能发动。和那2只怪兽的等级合计相同等级的1只同调怪兽无视召唤条件从额外卡组特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--リミットオーバー・ドライブ
function c35014241.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,35014241+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c35014241.cost)
	e1:SetTarget(c35014241.target)
	e1:SetOperation(c35014241.activate)
	c:RegisterEffect(e1)
end
function c35014241.cfilter1(c,e,tp)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO) and c:IsType(TYPE_TUNER) and c:IsAbleToExtraAsCost()
		and Duel.IsExistingMatchingCard(c35014241.cfilter2,tp,LOCATION_MZONE,0,1,nil,e,tp,c)
end
function c35014241.cfilter2(c,e,tp,tc)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO) and not c:IsType(TYPE_TUNER) and c:IsAbleToExtraAsCost()
		and Duel.IsExistingMatchingCard(c35014241.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,c:GetLevel()+tc:GetLevel(),Group.FromCards(c,tc))
end
function c35014241.spfilter(c,e,tp,lv,mg)
	return c:IsType(TYPE_SYNCHRO) and c:IsLevel(lv) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
		and Duel.GetLocationCountFromEx(tp,tp,mg,c)>0
end
function c35014241.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return Duel.IsExistingMatchingCard(c35014241.cfilter1,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g1=Duel.SelectMatchingCard(tp,c35014241.cfilter1,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g2=Duel.SelectMatchingCard(tp,c35014241.cfilter2,tp,LOCATION_MZONE,0,1,1,nil,e,tp,g1:GetFirst())
	e:SetLabel(g1:GetFirst():GetLevel()+g2:GetFirst():GetLevel())
	g1:Merge(g2)
	Duel.SendtoDeck(g1,nil,SEQ_DECKTOP,REASON_COST)
end
function c35014241.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return true
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c35014241.activate(e,tp,eg,ep,ev,re,r,rp)
	local lv=e:GetLabel()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c35014241.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,lv,nil)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
	end
end
