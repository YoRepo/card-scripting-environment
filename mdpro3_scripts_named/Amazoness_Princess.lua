--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 亚马逊王女  (ID: 84539520)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 3
-- ATK 1200 | DEF 900
-- Setcode: 4
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：这张卡的卡名只要在场上·墓地存在当作「亚马逊女王」使用。
-- ②：这张卡召唤·特殊召唤成功的场合才能发动。从卡组把1张「亚马逊」魔法·陷阱卡加入手卡。
-- ③：这张卡的攻击宣言时，把这张卡以外的自己的手卡·场上1张卡送去墓地才能发动。从卡组把「亚马逊王女」以外的1只「亚马逊」怪兽守备表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--アマゾネス王女
function c84539520.initial_effect(c)
	--code
	aux.EnableChangeCode(c,15951532,LOCATION_MZONE+LOCATION_GRAVE)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(84539520,0))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,84539520)
	e2:SetTarget(c84539520.thtg)
	e2:SetOperation(c84539520.thop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--special summon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(84539520,1))
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetCode(EVENT_ATTACK_ANNOUNCE)
	e4:SetCost(c84539520.spcost)
	e4:SetTarget(c84539520.sptg)
	e4:SetOperation(c84539520.spop)
	c:RegisterEffect(e4)
end
function c84539520.filter(c)
	return c:IsSetCard(0x4) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function c84539520.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c84539520.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c84539520.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c84539520.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c84539520.costfilter(c,ft)
	return c:IsAbleToGraveAsCost() and (ft>0 or (c:IsLocation(LOCATION_MZONE) and c:GetSequence()<5))
end
function c84539520.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if chk==0 then return Duel.IsExistingMatchingCard(c84539520.costfilter,tp,LOCATION_ONFIELD+LOCATION_HAND,0,1,c,ft) end
	local g=nil
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	if ft<=0 then
		g=Duel.SelectMatchingCard(tp,c84539520.costfilter,tp,LOCATION_MZONE,0,1,1,c,ft)
	else
		g=Duel.SelectMatchingCard(tp,c84539520.costfilter,tp,LOCATION_ONFIELD+LOCATION_HAND,0,1,1,c,ft)
	end
	Duel.SendtoGrave(g,REASON_COST)
end
function c84539520.spfilter(c,e,tp)
	return c:IsSetCard(0x4) and not c:IsCode(84539520) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c84539520.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c84539520.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c84539520.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c84539520.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
