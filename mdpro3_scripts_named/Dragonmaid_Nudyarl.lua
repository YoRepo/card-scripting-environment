--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 半龙女仆·苍河龙女  (ID: 49575521)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Dragon
-- Level 7
-- ATK 2600 | DEF 1600
-- Setcode: 307
--
-- Effect Text:
-- 这个卡名的①③的效果1回合各能使用1次。
-- ①：把这张卡从手卡丢弃，以自己或对方的墓地1只怪兽为对象才能发动。那只怪兽回到卡组。
-- ②：只要自己场上有融合怪兽存在，这张卡不会被效果破坏。
-- ③：自己·对方的战斗阶段结束时才能发动。这张卡回到手卡，从手卡把1只2星「半龙女仆」怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ドラゴンメイド・フルス
function c49575521.initial_effect(c)
	--to deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(49575521,0))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,49575521)
	e1:SetCost(c49575521.tdcost)
	e1:SetTarget(c49575521.tdtg)
	e1:SetOperation(c49575521.tdop)
	c:RegisterEffect(e1)
	--indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c49575521.indcon)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(49575521,1))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,49575522)
	e3:SetTarget(c49575521.sptg)
	e3:SetOperation(c49575521.spop)
	c:RegisterEffect(e3)
end
function c49575521.tdcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c49575521.tdfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToDeck()
end
function c49575521.tdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c49575521.tdfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c49575521.tdfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c49575521.tdfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c49575521.tdop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoDeck(tc,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end
function c49575521.indfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_FUSION)
end
function c49575521.indcon(e)
	return Duel.IsExistingMatchingCard(c49575521.indfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c49575521.spfilter(c,e,tp)
	return c:IsSetCard(0x133) and c:IsLevel(2) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c49575521.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToHand()
		and Duel.GetMZoneCount(tp,c)>0
		and Duel.IsExistingMatchingCard(c49575521.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,c,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c49575521.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SendtoHand(c,nil,REASON_EFFECT)~=0
		and c:IsLocation(LOCATION_HAND) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c49575521.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
