--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 阿尔戈☆群星-热斗之帕耳忒  (ID: 21050476)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 4
-- ATK 1400 | DEF 1400
-- Setcode: 449
--
-- Effect Text:
-- 这个卡名的①③的效果1回合各能使用1次。
-- ①：自己·对方回合，把手卡的这张卡给对方观看才能发动。自己场上1张表侧表示的「阿尔戈☆群星」永续陷阱卡回到手卡，这张卡特殊召唤。
-- ②：这张卡的攻击力·守备力上升自己场上的其他的「阿尔戈☆群星」怪兽种类×700。
-- ③：把场上的这张卡除外才能发动。从手卡把1张永续陷阱卡盖放。这个效果盖放的卡在盖放的回合也能发动。
--[[ __CARD_HEADER_END__ ]]

--ARG☆S－熱闘のパルテ
local s,id,o=GetID()
function s.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,id)
	e1:SetCost(s.spcost)
	e1:SetTarget(s.sptg)
	e1:SetOperation(s.spop)
	c:RegisterEffect(e1)
	--buff
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(s.atkval)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e3)
	--set
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(id,2))
	e4:SetCategory(CATEGORY_SSET)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1,id+o)
	e4:SetCost(aux.bfgcost)
	e4:SetTarget(s.settg)
	e4:SetOperation(s.setop)
	c:RegisterEffect(e4)
end
function s.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsPublic() end
end
function s.spfilter(c,tp,chk)
	return c:IsSetCard(0x1c1) and c:IsAllTypes(TYPE_CONTINUOUS|TYPE_TRAP) and c:IsFaceup() and c:IsAbleToHand()
		and (Duel.GetMZoneCount(tp,c)>0 or not chk)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_ONFIELD,0,1,nil,tp,true)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,tp,LOCATION_HAND)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local rg=nil
	if Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_ONFIELD,0,1,nil,tp,true) then
		rg=Duel.SelectMatchingCard(tp,s.spfilter,tp,LOCATION_ONFIELD,0,1,1,nil,tp,true)
	else
		rg=Duel.SelectMatchingCard(tp,s.spfilter,tp,LOCATION_ONFIELD,0,1,1,nil,tp,false)
	end
	if rg and rg:GetCount()>0 then
		Duel.HintSelection(rg)
		if Duel.SendtoHand(rg,nil,REASON_EFFECT)~=0 and rg:FilterCount(Card.IsLocation,nil,LOCATION_HAND)>0
			and c:IsCanBeSpecialSummoned(e,0,tp,false,false) then
			Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
function s.atkval(e,c)
	local g=Duel.GetMatchingGroup(s.bfilter,c:GetControler(),LOCATION_MZONE,0,c)
	return g:GetClassCount(Card.GetCode)*700
end
function s.bfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x1c1)
end
function s.setfilter(c)
	return c:IsAllTypes(TYPE_TRAP+TYPE_CONTINUOUS) and c:IsSSetable()
end
function s.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.setfilter,tp,LOCATION_HAND,0,1,nil) end
end
function s.setop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,s.setfilter,tp,LOCATION_HAND,0,1,1,nil)
	local tc=g:GetFirst()
	if tc and Duel.SSet(tp,tc)~=0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetDescription(aux.Stringid(id,3))
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
		e1:SetCode(EFFECT_TRAP_ACT_IN_SET_TURN)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end
