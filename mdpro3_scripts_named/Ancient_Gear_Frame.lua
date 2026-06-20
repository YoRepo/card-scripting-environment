--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 古代的机械素体  (ID: 1278431)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level 4
-- ATK 1600 | DEF 500
-- Setcode: 7
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：丢弃1张手卡才能发动。把1只「古代的机械巨人」或者1张有那个卡名记述的魔法·陷阱卡从卡组加入手卡。
-- ②：这张卡攻击的场合，对方直到伤害步骤结束时魔法·陷阱卡不能发动。
-- ③：表侧表示的这张卡因对方的效果从场上离开的场合才能发动。从手卡把「古代的机械巨人」「古代的机械巨人-究极重击」合计最多3只无视召唤条件特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--古代の機械素体
function c1278431.initial_effect(c)
	aux.AddCodeList(c,83104731)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1278431,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,1278431)
	e1:SetCost(c1278431.thcost)
	e1:SetTarget(c1278431.thtg)
	e1:SetOperation(c1278431.thop)
	c:RegisterEffect(e1)
	--actlimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,1)
	e2:SetValue(c1278431.aclimit)
	e2:SetCondition(c1278431.actcon)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(1278431,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetCondition(c1278431.spcon)
	e3:SetTarget(c1278431.sptg)
	e3:SetOperation(c1278431.spop)
	c:RegisterEffect(e3)
end
function c1278431.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c1278431.thfilter(c)
	return (c:IsCode(83104731) or (c:IsType(TYPE_SPELL+TYPE_TRAP) and aux.IsCodeListed(c,83104731))) and c:IsAbleToHand()
end
function c1278431.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c1278431.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c1278431.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c1278431.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c1278431.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c1278431.actcon(e)
	return Duel.GetAttacker()==e:GetHandler()
end
function c1278431.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousPosition(POS_FACEUP)
		and c:IsReason(REASON_EFFECT) and c:GetReasonPlayer()==1-tp
end
function c1278431.spfilter(c,e,tp)
	return c:IsCode(83104731,95735217) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c1278431.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c1278431.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c1278431.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft=math.min((Duel.GetLocationCount(tp,LOCATION_MZONE)),3)
	if ft<1 then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c1278431.spfilter,tp,LOCATION_HAND,0,1,ft,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
	end
end
