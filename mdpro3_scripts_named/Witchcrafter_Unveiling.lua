--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 魔女术的演示  (ID: 70226289)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 296
--
-- Effect Text:
-- 这个卡名的①②的效果1回合只能有1次使用其中任意1个。
-- ①：从手卡把1只「魔女术」怪兽特殊召唤。这个效果特殊召唤的回合，对方不能对应自己的魔法师族怪兽的效果的发动把魔法·陷阱·怪兽的效果发动。
-- ②：这张卡在墓地存在，自己场上有「魔女术」怪兽存在的场合，自己结束阶段才能发动。这张卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--ウィッチクラフト・デモンストレーション
function c70226289.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(70226289,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_ATTACK+TIMING_END_PHASE)
	e1:SetCountLimit(1,70226289)
	e1:SetTarget(c70226289.target)
	e1:SetOperation(c70226289.activate)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(70226289,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetCountLimit(1,70226289)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCondition(c70226289.thcon)
	e2:SetTarget(c70226289.thtg)
	e2:SetOperation(c70226289.thop)
	c:RegisterEffect(e2)
end
function c70226289.filter(c,e,tp)
	return c:IsSetCard(0x128) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
---dynamic target
function c70226289.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc,exc)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c70226289.filter,tp,LOCATION_HAND,0,1,exc,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c70226289.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c70226289.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 and Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)~=0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_CHAINING)
		e1:SetOperation(c70226289.chainop)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
	end
end
function c70226289.chainop(e,tp,eg,ep,ev,re,r,rp)
	local race=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_RACE)
	if re:IsActiveType(TYPE_MONSTER) and bit.band(race,RACE_SPELLCASTER)~=0 and ep==tp then
		Duel.SetChainLimit(c70226289.chainlm)
	end
end
function c70226289.chainlm(e,ep,tp)
	return tp==ep
end
function c70226289.rccfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x128)
end
function c70226289.thcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
		and Duel.IsExistingMatchingCard(c70226289.rccfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c70226289.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c70226289.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SendtoHand(c,nil,REASON_EFFECT)
	end
end
