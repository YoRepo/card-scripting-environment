--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 米乐与磷寸之仔  (ID: 44201739)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Spellcaster
-- Level 1
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：这张卡在手卡存在的场合才能发动。同名卡在对方墓地存在的3张卡从手卡·卡组给对方观看（同名卡最多1张），这张卡特殊召唤。
-- ②：对方把魔法·陷阱·怪兽的效果发动时，把这张卡的①的效果特殊召唤的这张卡送去墓地才能发动。把1张对方发动的那张卡的同名卡从卡组·额外卡组送去墓地，那个发动无效。
--[[ __CARD_HEADER_END__ ]]

--ミラァと燐寸之仔
function c44201739.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44201739,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,44201739)
	e1:SetTarget(c44201739.sptg)
	e1:SetOperation(c44201739.spop)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44201739,1))
	e2:SetCategory(CATEGORY_NEGATE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,44201739+1)
	e2:SetCondition(c44201739.negcon)
	e2:SetCost(c44201739.negcost)
	e2:SetTarget(c44201739.negtg)
	e2:SetOperation(c44201739.negop)
	c:RegisterEffect(e2)
end
function c44201739.cfilter(c,tp)
	return Duel.IsExistingMatchingCard(Card.IsCode,tp,0,LOCATION_GRAVE,1,nil,c:GetCode()) and not c:IsPublic()
end
function c44201739.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c44201739.cfilter,tp,LOCATION_DECK+LOCATION_HAND,0,nil,tp)
	if chk==0 then return g:CheckSubGroup(aux.dncheck,3,3) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c44201739.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c44201739.cfilter,tp,LOCATION_DECK+LOCATION_HAND,0,nil,tp)
	if g:CheckSubGroup(aux.dncheck,3,3) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
		local sg=g:SelectSubGroup(tp,aux.dncheck,false,3,3,nil)
		Duel.ConfirmCards(1-tp,sg)
		Duel.ShuffleHand(tp)
		Duel.ShuffleDeck(tp)
		if not c:IsRelateToEffect(e) then return end
		Duel.SpecialSummon(c,SUMMON_VALUE_SELF,tp,tp,false,false,POS_FACEUP)
	end
end
function c44201739.negcon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and ep~=tp and Duel.IsChainNegatable(ev)
end
function c44201739.negcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL+SUMMON_VALUE_SELF and e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c44201739.filter(c,re)
	return c:IsCode(re:GetHandler():GetCode()) and c:IsAbleToGrave()
end
function c44201739.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44201739.filter,tp,LOCATION_DECK+LOCATION_EXTRA,0,1,nil,re) end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK+LOCATION_EXTRA)
end
function c44201739.negop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44201739.filter,tp,LOCATION_DECK+LOCATION_EXTRA,0,1,1,nil,re)
	if g:GetCount()>0 and Duel.SendtoGrave(g,REASON_EFFECT)~=0 and g:GetFirst():IsLocation(LOCATION_GRAVE) then
		Duel.NegateActivation(ev)
	end
end
