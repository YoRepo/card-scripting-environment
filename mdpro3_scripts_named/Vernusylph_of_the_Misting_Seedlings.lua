--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 苗与霞的春化精  (ID: 81519836)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Fairy
-- Level 3
-- ATK 400 | DEF 800
-- Setcode: 386
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：把这张卡和1只怪兽或和1张「春化精」卡从手卡丢弃才能发动。从卡组把「苗与霞的春化精」以外的1只天使族·地属性怪兽加入手卡。那之后，可以从自己墓地把1只地属性怪兽特殊召唤。这个回合，自己不能把地属性
-- 以外的怪兽的效果发动。
-- ②：只要这张卡在怪兽区域存在，「春化精」怪兽以外的场上的怪兽的攻击力下降600。
--[[ __CARD_HEADER_END__ ]]

--苗と霞の春化精
function c81519836.initial_effect(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_SPECIAL_SUMMON+CATEGORY_GRAVE_SPSUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,81519836)
	e1:SetCost(c81519836.thcost)
	e1:SetTarget(c81519836.thtg)
	e1:SetOperation(c81519836.thop)
	c:RegisterEffect(e1)
	--atk down
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c81519836.atktg)
	e2:SetValue(-600)
	c:RegisterEffect(e2)
end
function c81519836.costfilter(c)
	return (c:IsType(TYPE_MONSTER) or c:IsSetCard(0x182)) and c:IsDiscardable()
end
function c81519836.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local fe=Duel.IsPlayerAffectedByEffect(tp,14108995)
	local b2=Duel.IsExistingMatchingCard(c81519836.costfilter,tp,LOCATION_HAND,0,1,c)
	if chk==0 then return c:IsDiscardable() and (fe or b2) end
	if fe and (not b2 or Duel.SelectYesNo(tp,aux.Stringid(14108995,0))) then
		Duel.Hint(HINT_CARD,0,14108995)
		fe:UseCountLimit(tp)
		Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
		local g=Duel.SelectMatchingCard(tp,c81519836.costfilter,tp,LOCATION_HAND,0,1,1,c)
		g:AddCard(c)
		Duel.SendtoGrave(g,REASON_COST+REASON_DISCARD)
	end
end
function c81519836.thfilter(c)
	return c:IsRace(RACE_FAIRY) and c:IsAttribute(ATTRIBUTE_EARTH) and c:IsAbleToHand() and not c:IsCode(81519836)
end
function c81519836.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c81519836.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c81519836.spfilter(c,e,tp)
	return c:IsAttribute(ATTRIBUTE_EARTH) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c81519836.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c81519836.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 and Duel.SendtoHand(g,nil,REASON_EFFECT)>0 and g:GetFirst():IsLocation(LOCATION_HAND) then
		Duel.ConfirmCards(1-tp,g)
		local sg=Duel.GetMatchingGroup(aux.NecroValleyFilter(c81519836.spfilter),tp,LOCATION_GRAVE,0,nil,e,tp)
		if sg:GetCount()>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
			and Duel.SelectYesNo(tp,aux.Stringid(81519836,0)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local sc=sg:Select(tp,1,1,nil)
			Duel.SpecialSummon(sc,0,tp,tp,false,false,POS_FACEUP)
		end
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(1,0)
	e1:SetValue(c81519836.aclimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c81519836.aclimit(e,re,tp)
	return re:IsActiveType(TYPE_MONSTER) and re:GetHandler():IsNonAttribute(ATTRIBUTE_EARTH)
end
function c81519836.atktg(e,c)
	return not c:IsSetCard(0x182)
end
