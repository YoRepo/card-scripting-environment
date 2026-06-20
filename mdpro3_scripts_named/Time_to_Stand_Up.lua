--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 伟大之魂  (ID: 68490573)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：场上有龙族同调怪兽存在的场合才能发动。从卡组把「共鸣者」怪兽或龙族·1星怪兽合计最多2只特殊召唤。
-- ②：自己场上有10星以上的龙族·暗属性同调怪兽存在，怪兽的效果发动时，把墓地的这张卡除外才能发动。那个效果无效，自己场上1只同调怪兽的攻击力直到下个回合的结束时上升2000。
--[[ __CARD_HEADER_END__ ]]

--大いなる魂
function c68490573.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCountLimit(1,68490573)
	e1:SetCondition(c68490573.condition)
	e1:SetTarget(c68490573.target)
	e1:SetOperation(c68490573.activate)
	c:RegisterEffect(e1)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DISABLE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,68490574)
	e2:SetCondition(c68490573.discon)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c68490573.distg)
	e2:SetOperation(c68490573.disop)
	c:RegisterEffect(e2)
end
function c68490573.filter(c)
	return c:IsRace(RACE_DRAGON) and c:IsType(TYPE_SYNCHRO) and c:IsFaceup()
end
function c68490573.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c68490573.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c68490573.spfilter(c,e,tp)
	return (c:IsSetCard(0x57) or c:IsRace(RACE_DRAGON) and c:IsLevel(1)) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c68490573.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c68490573.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c68490573.activate(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	if ft>=2 then ft=2 end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c68490573.spfilter,tp,LOCATION_DECK,0,1,ft,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c68490573.disfilter(c)
	return c:IsRace(RACE_DRAGON) and c:IsAttribute(ATTRIBUTE_DARK) and c:IsType(TYPE_SYNCHRO) and c:IsLevelAbove(10) and c:IsFaceup()
end
function c68490573.discon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c68490573.disfilter,tp,LOCATION_MZONE,0,1,nil)
		and re:IsActiveType(TYPE_MONSTER) and Duel.IsChainDisablable(ev)
end
function c68490573.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function c68490573.atkfilter(c)
	return c:IsType(TYPE_SYNCHRO) and c:IsFaceup()
end
function c68490573.disop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c68490573.atkfilter,tp,LOCATION_MZONE,0,nil)
	if Duel.NegateEffect(ev) and g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(68490573,2))
		local tg=g:Select(tp,1,1,nil)
		Duel.HintSelection(tg)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(2000)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,2)
		tg:GetFirst():RegisterEffect(e1)
	end
end
