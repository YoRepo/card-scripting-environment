--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 被选中者  (ID: 21888494)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 选1张自己的手卡的怪兽卡和怪兽以外的种类2张卡。对方在这之中随机选1张，如果选中怪兽卡的场合场上特殊召唤，其他的2张卡送去墓地。选不中的话，全部送去墓地。
--[[ __CARD_HEADER_END__ ]]

--選ばれし者
function c21888494.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c21888494.target)
	e1:SetOperation(c21888494.activate)
	c:RegisterEffect(e1)
end
function c21888494.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c21888494.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_HAND,0,2,e:GetHandler(),TYPE_SPELL+TYPE_TRAP)
		and Duel.IsExistingMatchingCard(c21888494.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
end
function c21888494.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local g1=Duel.GetMatchingGroup(c21888494.spfilter,tp,LOCATION_HAND,0,nil,e,tp)
	local g2=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_HAND,0,nil,TYPE_SPELL+TYPE_TRAP)
	if g1:GetCount()==0 or g2:GetCount()<2 then return end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(21888494,0))
	local sg1=g1:Select(tp,1,1,nil)
	local sc=sg1:GetFirst()
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(21888494,1))
	local sg2=g2:Select(tp,2,2,nil)
	sg1:Merge(sg2)
	Duel.ConfirmCards(1-tp,sg1)
	Duel.ShuffleHand(tp)
	local rg=sg1:Select(1-tp,1,1,nil)
	local tc=rg:GetFirst()
	if tc:IsCanBeSpecialSummoned(e,0,tp,false,false) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		Duel.SendtoGrave(sg2,REASON_EFFECT)
	else
		Duel.SendtoGrave(sg1,REASON_EFFECT)
	end
end
