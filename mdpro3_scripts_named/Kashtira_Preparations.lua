--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 俱舍怒威族的准备  (ID: 21639276)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
-- Setcode: 393
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己·对方回合可以发动。从手卡的怪兽以及除外的自己怪兽之中选1只「俱舍怒威族」怪兽特殊召唤。
-- ②：这张卡已在魔法与陷阱区域存在的状态，对方把陷阱卡的效果发动的场合，若自己场上有「俱舍怒威族」怪兽存在则能发动。把对方手卡确认，选那之内的1张里侧表示除外。
--[[ __CARD_HEADER_END__ ]]

--クシャトリラ・プリペア
function c21639276.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(21639276,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,21639276)
	e2:SetHintTiming(0,TIMING_END_PHASE)
	e2:SetTarget(c21639276.sptg)
	e2:SetOperation(c21639276.spop)
	c:RegisterEffect(e2)
	--remove when chaining
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(21639276,1))
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_ACTIVATE_CONDITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1,21639277)
	e3:SetCondition(c21639276.rmcon)
	e3:SetTarget(c21639276.rmtg)
	e3:SetOperation(c21639276.rmop)
	c:RegisterEffect(e3)
	--activate
end
function c21639276.spfilter(c,e,tp)
	return c:IsSetCard(0x189) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and (c:IsLocation(LOCATION_HAND) or c:IsFaceup())
end
function c21639276.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c21639276.spfilter,tp,LOCATION_HAND+LOCATION_REMOVED,0,1,nil,e,tp) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_REMOVED)
end
function c21639276.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c21639276.spfilter,tp,LOCATION_HAND+LOCATION_REMOVED,0,1,1,nil,e,tp)
	if #g>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c21639276.rmcfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x189)
end
function c21639276.rmcon(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and re:IsActiveType(TYPE_TRAP) and e:GetHandler():IsStatus(STATUS_EFFECT_ENABLED)
		and Duel.IsExistingMatchingCard(c21639276.rmcfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c21639276.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,LOCATION_HAND,1,nil,tp,POS_FACEDOWN) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,1-tp,LOCATION_HAND)
end
function c21639276.rmop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	Duel.ConfirmCards(tp,g)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local sg=g:FilterSelect(tp,Card.IsAbleToRemove,1,1,nil,tp,POS_FACEDOWN)
	if #sg>0 then
		Duel.Remove(sg,POS_FACEDOWN,REASON_EFFECT)
	end
	Duel.ShuffleHand(1-tp)
end
