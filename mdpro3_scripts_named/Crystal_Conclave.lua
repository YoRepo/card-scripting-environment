--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 宝玉的集结  (ID: 87259933)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
-- Setcode: 52
--
-- Effect Text:
-- 这张卡的①②的效果在同一连锁上不能发动。
-- ①：1回合1次，自己场上的表侧表示的「宝玉兽」怪兽被战斗·效果破坏的场合才能发动。从卡组把1只「宝玉兽」怪兽特殊召唤。
-- ②：把魔法与陷阱区域的表侧表示的这张卡送去墓地，以自己场上1张「宝玉兽」卡和场上1张卡为对象才能发动。那些卡回到持有者手卡。
--[[ __CARD_HEADER_END__ ]]

--宝玉の集結
function c87259933.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(87259933,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c87259933.spcon)
	e2:SetTarget(c87259933.sptg)
	e2:SetOperation(c87259933.spop)
	c:RegisterEffect(e2)
	--tohand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(87259933,2))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCost(c87259933.thcost)
	e3:SetTarget(c87259933.thtg)
	e3:SetOperation(c87259933.thop)
	c:RegisterEffect(e3)
end
function c87259933.cfilter(c,tp)
	return c:IsSetCard(0x1034) and c:IsReason(REASON_BATTLE+REASON_EFFECT)
		and c:IsPreviousPosition(POS_FACEUP) and c:IsPreviousLocation(LOCATION_MZONE) and c:IsPreviousControler(tp)
end
function c87259933.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c87259933.cfilter,1,nil,tp)
end
function c87259933.filter(c,e,tp)
	return c:IsSetCard(0x1034) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c87259933.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c87259933.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c87259933.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c87259933.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c87259933.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToGraveAsCost() and c:IsStatus(STATUS_EFFECT_ENABLED) end
	Duel.SendtoGrave(c,REASON_COST)
end
function c87259933.thfilter1(c,rc)
	return c:IsFaceup() and c:IsSetCard(0x1034) and c:IsAbleToHand()
		and Duel.IsExistingTarget(c87259933.thfilter2,0,LOCATION_ONFIELD,LOCATION_ONFIELD,1,c,rc)
end
function c87259933.thfilter2(c,rc)
	return c~=rc and c:IsAbleToHand()
end
function c87259933.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return not e:GetHandler():IsStatus(STATUS_CHAINING)
		and Duel.IsExistingTarget(c87259933.thfilter1,tp,LOCATION_ONFIELD,0,1,nil,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g1=Duel.SelectTarget(tp,c87259933.thfilter1,tp,LOCATION_ONFIELD,0,1,1,nil,e:GetHandler())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g2=Duel.SelectTarget(tp,c87259933.thfilter2,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,g1:GetFirst(),e:GetHandler())
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g1,2,0,0)
end
function c87259933.thop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
	end
end
