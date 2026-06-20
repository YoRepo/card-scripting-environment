--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 死者所生  (ID: 54564198)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：怪兽被战斗破坏的回合，从手卡·卡组把1张「死者苏生」送去墓地，以自己或者对方的墓地1只怪兽为对象才能发动。那只怪兽当作「死者苏生」的效果的特殊召唤在自己场上特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--死者所生
function c54564198.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCondition(c54564198.condition)
	e1:SetCost(c54564198.cost)
	e1:SetTarget(c54564198.target)
	e1:SetOperation(c54564198.activate)
	c:RegisterEffect(e1)
	if not c54564198.global_check then
		c54564198.globle_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_BATTLE_DESTROYED)
		ge1:SetOperation(c54564198.checkop)
		Duel.RegisterEffect(ge1,0)
	end
end
function c54564198.checkop(e,tp,eg,ep,ev,re,r,rp)
	Duel.RegisterFlagEffect(0,54564198,RESET_PHASE+PHASE_END,0,1)
end
function c54564198.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(0,54564198)~=0
end
function c54564198.cfilter(c)
	return c:IsCode(83764718) and c:IsAbleToGraveAsCost()
end
function c54564198.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c54564198.cfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c54564198.cfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c54564198.tgfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,SUMMON_VALUE_MONSTER_REBORN,tp,false,false)
end
function c54564198.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return c54564198.tgfilter(chkc,e,tp) and chkc:IsLocation(LOCATION_GRAVE) end
	if chk==0 then return Duel.IsExistingTarget(c54564198.tgfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,e,tp) and Duel.GetMZoneCount(tp)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c54564198.tgfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c54564198.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,SUMMON_VALUE_MONSTER_REBORN,tp,tp,false,false,POS_FACEUP)
	end
end
