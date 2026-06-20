--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 薰风的旋风  (ID: 91822647)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 16
--
-- Effect Text:
-- 自己场上没有怪兽存在的场合才能发动。选择自己墓地存在的2只名字带有「薰风」的怪兽回到卡组。那之后，从自己卡组把1只守备力1000以下的名字带有「薰风」的怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ガスタのつむじ風
function c91822647.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c91822647.condition)
	e1:SetTarget(c91822647.target)
	e1:SetOperation(c91822647.activate)
	c:RegisterEffect(e1)
end
function c91822647.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function c91822647.filter1(c)
	return c:IsSetCard(0x10) and c:IsType(TYPE_MONSTER) and c:IsAbleToDeck()
end
function c91822647.filter2(c,e,tp)
	return c:IsSetCard(0x10) and c:IsDefenseBelow(1000) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c91822647.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c91822647.filter1,tp,LOCATION_GRAVE,0,2,nil)
		and Duel.IsExistingMatchingCard(c91822647.filter2,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c91822647.filter1,tp,LOCATION_GRAVE,0,2,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c91822647.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tg=g:Filter(Card.IsRelateToEffect,nil,e)
	if tg:GetCount()==2 then
		Duel.SendtoDeck(tg,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=Duel.SelectMatchingCard(tp,c91822647.filter2,tp,LOCATION_DECK,0,1,1,nil,e,tp)
		if sg:GetCount()>0 then
			Duel.BreakEffect()
			Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
