--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 魔术栗子球  (ID: 31699677)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 1
-- ATK 300 | DEF 200
-- Setcode: 164
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：战斗或者对方的效果让自己受到伤害的回合的主要阶段以及战斗阶段，把这张卡从手卡送去墓地才能发动。从自己的卡组·墓地选1只「黑魔术师」或者「黑魔术少女」特殊召唤。这个效果在对方回合也能发动。
-- ②：自己场上的表侧表示的魔法师族怪兽被战斗或者对方的效果破坏的场合才能发动。墓地的这张卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--マジクリボー
function c31699677.initial_effect(c)
	aux.AddCodeList(c,46986414,38033121)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(31699677,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_MAIN_END+TIMING_BATTLE_START+TIMING_BATTLE_END)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,31699677)
	e1:SetCost(c31699677.spcost)
	e1:SetCondition(c31699677.spcon)
	e1:SetTarget(c31699677.sptg)
	e1:SetOperation(c31699677.spop)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(31699677,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,31699676)
	e2:SetCondition(c31699677.thcon)
	e2:SetTarget(c31699677.thtg)
	e2:SetOperation(c31699677.thop)
	c:RegisterEffect(e2)
	if not c31699677.global_check then
		c31699677.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DAMAGE)
		ge1:SetOperation(c31699677.checkop)
		Duel.RegisterEffect(ge1,0)
	end
end
function c31699677.checkop(e,tp,eg,ep,ev,re,r,rp)
	if (bit.band(r,REASON_EFFECT)~=0 and rp==1-ep) or bit.band(r,REASON_BATTLE)~=0 then
		Duel.RegisterFlagEffect(ep,31699677,RESET_PHASE+PHASE_END,0,1)
	end
end
function c31699677.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c31699677.spcon(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return (ph==PHASE_MAIN1 or (ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE) or ph==PHASE_MAIN2)
		and Duel.GetFlagEffect(tp,31699677)~=0
end
function c31699677.spfilter(c,e,tp)
	return c:IsCode(46986414,38033121) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c31699677.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c31699677.spfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c31699677.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c31699677.spfilter),tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c31699677.cfilter(c,tp)
	return c:IsPreviousPosition(POS_FACEUP) and c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_MZONE)
		and c:GetPreviousRaceOnField()&RACE_SPELLCASTER~=0 and (c:IsReason(REASON_BATTLE) or c:IsReason(REASON_EFFECT) and c:GetReasonPlayer()==1-tp)
end
function c31699677.thcon(e,tp,eg,ep,ev,re,r,rp)
	return not eg:IsContains(e:GetHandler()) and eg:IsExists(c31699677.cfilter,1,nil,tp)
end
function c31699677.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c31699677.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SendtoHand(c,nil,REASON_EFFECT)
	end
end
