--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 毒之魔妖-束胫  (ID: 5325155)
-- Type: Monster / Effect / Tuner
-- Attribute: EARTH
-- Race: Zombie
-- Level 2
-- ATK 0 | DEF 2000
-- Setcode: 289
--
-- Effect Text:
-- ①：「毒之魔妖-束胫」在自己场上只能有1只表侧表示存在。
-- ②：这张卡在墓地存在，「毒之魔妖-束胫」以外的自己的「魔妖」怪兽被战斗或者对方的效果破坏的场合才能发动。这张卡特殊召唤。这个效果发动的回合，自己不是「魔妖」怪兽不能从额外卡组特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--毒の魔妖－束脛
function c5325155.initial_effect(c)
	c:SetUniqueOnField(1,0,5325155)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(5325155,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c5325155.spcon)
	e1:SetCost(c5325155.spcost)
	e1:SetTarget(c5325155.sptg)
	e1:SetOperation(c5325155.spop)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(5325155,ACTIVITY_SPSUMMON,c5325155.counterfilter)
end
function c5325155.counterfilter(c)
	return not c:IsSummonLocation(LOCATION_EXTRA) or c:IsSetCard(0x121)
end
function c5325155.cfilter(c,tp,rp)
	return c:IsReason(REASON_BATTLE+REASON_EFFECT) and c:IsSetCard(0x121) and not c:IsCode(5325155)
		and c:IsPreviousLocation(LOCATION_MZONE) and c:IsPreviousControler(tp)
		and (c:IsReason(REASON_BATTLE) or (rp==1-tp and c:IsReason(REASON_EFFECT)))
end
function c5325155.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c5325155.cfilter,1,nil,tp,rp)
end
function c5325155.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(5325155,tp,ACTIVITY_SPSUMMON)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c5325155.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c5325155.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c5325155.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c5325155.splimit(e,c,sump,sumtype,sumpos,targetp)
	return c:IsLocation(LOCATION_EXTRA) and not c:IsSetCard(0x121)
end
