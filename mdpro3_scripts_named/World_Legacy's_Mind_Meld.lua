--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 星遗物的交心  (ID: 27705190)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 254
--
-- Effect Text:
-- 这个卡名的①②的效果1回合只能有1次使用其中任意1个。
-- ①：自己场上有「机怪虫」怪兽存在，对方怪兽的效果发动时才能发动。那个效果变成「选对方场上1只表侧表示怪兽回到持有者手卡」。
-- ②：把墓地的这张卡除外，以场上1只连接怪兽为对象才能发动。从自己的手卡·卡组·墓地选1只「机怪虫」怪兽在作为成为对象的怪兽所连接区的自己场上里侧守备表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--星遺物の交心
function c27705190.initial_effect(c)
	--change effect
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(27705190,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCountLimit(1,27705190)
	e1:SetCondition(c27705190.cecondition)
	e1:SetTarget(c27705190.cetarget)
	e1:SetOperation(c27705190.ceoperation)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(27705190,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_MSET)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,27705190)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c27705190.sptarget)
	e2:SetOperation(c27705190.spoperation)
	c:RegisterEffect(e2)
end
function c27705190.repop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.SelectMatchingCard(tp,c27705190.thfilter,tp,0,LOCATION_MZONE,1,1,nil)
	if sg:GetCount()>0 then
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
	end
end
function c27705190.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x104)
end
function c27705190.cecondition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and re:IsActiveType(TYPE_MONSTER) and Duel.IsExistingMatchingCard(c27705190.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c27705190.thfilter(c)
	return c:IsFaceup() and c:IsAbleToHand()
end
function c27705190.cetarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c27705190.thfilter,rp,0,LOCATION_MZONE,1,nil) end
end
function c27705190.ceoperation(e,tp,eg,ep,ev,re,r,rp)
	local g=Group.CreateGroup()
	Duel.ChangeTargetCard(ev,g)
	Duel.ChangeChainOperation(ev,c27705190.repop)
end
function c27705190.spfilter1(c,e,tp)
	local zone=bit.band(c:GetLinkedZone(tp),0x1f)
	return c:IsFaceup() and c:IsType(TYPE_LINK) and zone>0 and Duel.IsExistingMatchingCard(c27705190.spfilter2,tp,0x13,0,1,c,e,tp,zone)
end
function c27705190.spfilter2(c,e,tp,zone)
	return c:IsSetCard(0x104) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEDOWN_DEFENSE,tp,zone)
end
function c27705190.sptarget(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return c27705190.spfilter1(chkc,e,tp) and chkc:IsLocation(LOCATION_MZONE) end
	if chk==0 then return Duel.IsExistingTarget(c27705190.spfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c27705190.spfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0x13)
end
function c27705190.spoperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		local zone=bit.band(tc:GetLinkedZone(tp),0x1f)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c27705190.spfilter2),tp,0x13,0,1,1,c,e,tp,zone)
		if sg:GetCount()>0 then
			Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEDOWN_DEFENSE,zone)
			Duel.ConfirmCards(1-tp,sg)
		end
	end
end
