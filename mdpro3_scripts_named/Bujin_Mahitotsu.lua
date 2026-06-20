--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 武神-目一箇  (ID: 92586237)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Beast-Warrior
-- Level 4
-- ATK 0 | DEF 1800
-- Setcode: 136
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：从手卡把1张其他的「武神」卡送去墓地才能发动。这张卡从手卡特殊召唤。
-- ②：可以从以下效果选择1个发动。
-- ●从手卡把1只「武神」怪兽送去墓地才能发动。从自己墓地选和那只怪兽卡名不同的1只「武神」怪兽加入手卡。
-- ●从自己墓地把1只「武神」怪兽除外才能发动。和那只怪兽卡名不同的1只「武神」怪兽从卡组送去墓地。
--[[ __CARD_HEADER_END__ ]]

--武神－マヒトツ
function c92586237.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(92586237,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,92586237)
	e1:SetCost(c92586237.spcost)
	e1:SetTarget(c92586237.sptg)
	e1:SetOperation(c92586237.spop)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(92586237,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,92586238)
	e2:SetCost(c92586237.thcost)
	e2:SetTarget(c92586237.thtg)
	e2:SetOperation(c92586237.thop)
	c:RegisterEffect(e2)
	--tograve
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(92586237,2))
	e3:SetCategory(CATEGORY_TOGRAVE)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,92586238)
	e3:SetCost(c92586237.tgcost)
	e3:SetTarget(c92586237.tgtg)
	e3:SetOperation(c92586237.tgop)
	c:RegisterEffect(e3)
end
function c92586237.spcfilter(c)
	return c:IsSetCard(0x88) and c:IsAbleToGraveAsCost()
end
function c92586237.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c92586237.spcfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	local g=Duel.SelectMatchingCard(tp,c92586237.spcfilter,tp,LOCATION_HAND,0,1,1,e:GetHandler())
	Duel.SendtoGrave(g,REASON_COST)
end
function c92586237.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c92586237.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c92586237.thcfilter(c,tp)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x88) and c:IsAbleToGraveAsCost()
		and Duel.IsExistingMatchingCard(c92586237.thfilter,tp,LOCATION_GRAVE,0,1,nil,c:GetCode())
end
function c92586237.thfilter(c,code)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x88) and not c:IsCode(code) and c:IsAbleToHand()
end
function c92586237.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c92586237.thcfilter,tp,LOCATION_HAND,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c92586237.thcfilter,tp,LOCATION_HAND,0,1,1,nil,tp)
	e:SetLabel(g:GetFirst():GetCode())
	Duel.SendtoGrave(g,REASON_COST)
end
function c92586237.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE)
end
function c92586237.thop(e,tp,eg,ep,ev,re,r,rp)
	local code=e:GetLabel()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectMatchingCard(tp,c92586237.thfilter,tp,LOCATION_GRAVE,0,1,1,nil,code)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.SendtoHand(g,nil,REASON_EFFECT)
	end
end
function c92586237.tgcfilter(c,tp)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x88) and c:IsAbleToRemoveAsCost()
		and Duel.IsExistingMatchingCard(c92586237.tgfilter,tp,LOCATION_DECK,0,1,nil,c:GetCode())
end
function c92586237.tgfilter(c,code)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x88) and not c:IsCode(code) and c:IsAbleToGrave()
end
function c92586237.tgcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c92586237.tgcfilter,tp,LOCATION_GRAVE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local tc=Duel.SelectMatchingCard(tp,c92586237.tgcfilter,tp,LOCATION_GRAVE,0,1,1,nil,tp):GetFirst()
	e:SetLabel(tc:GetCode())
	Duel.Remove(tc,POS_FACEUP,REASON_COST)
end
function c92586237.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c92586237.tgop(e,tp,eg,ep,ev,re,r,rp)
	local code=e:GetLabel()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c92586237.tgfilter,tp,LOCATION_DECK,0,1,1,nil,code)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
