--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 魔星之忧流迦天狗  (ID: 49109013)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Beast
-- Level 4
-- ATK 1500 | DEF 400
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：只让自己场上的怪兽1只因对方的效果从场上离开时，把手卡·墓地的这张卡除外才能发动。那只怪兽在墓地存在的场合或者是表侧除外状态的场合，那只怪兽特殊召唤。那以外的场合，除外状态的这张卡特殊召唤。
-- ②：这张卡特殊召唤的场合才能发动。这张卡的攻击力直到下个回合的结束时上升1500。
--[[ __CARD_HEADER_END__ ]]

--魔星のウルカ
local s,id,o=GetID()
function s.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_LEAVE_FIELD)
	e1:SetRange(LOCATION_GRAVE+LOCATION_HAND)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.spcon)
	e1:SetCost(aux.bfgcost)
	e1:SetTarget(s.sptg)
	e1:SetOperation(s.spop)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCountLimit(1,id+o)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetOperation(s.atkop)
	c:RegisterEffect(e2)
end
function s.spcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return #eg==1 and tc:IsPreviousControler(tp) and tc:IsPreviousLocation(LOCATION_MZONE)
		and tc:GetReasonPlayer()==1-tp and tc:IsReason(REASON_EFFECT)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and tc:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	local c=e:GetHandler()
	c:CreateEffectRelation(e)
	Duel.SetTargetCard(tc)
	local g=Group.FromCards(c,tc)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsLocation(LOCATION_GRAVE+LOCATION_REMOVED) and tc:IsFaceupEx() then
		if aux.NecroValleyNegateCheck(tc) then return end
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	elseif c:IsRelateToEffect(e) and c:IsLocation(LOCATION_REMOVED) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function s.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToChain() or c:IsFacedown() then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END,2)
	e1:SetValue(1500)
	c:RegisterEffect(e1)
end
