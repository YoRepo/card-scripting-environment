--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 征服斗魂 重型电子人  (ID: 92895501)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level 7
-- ATK 2500 | DEF 1500
-- Setcode: 405
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次，同一连锁上不能发动。
-- ①：自己·对方的主要阶段，以机械族以外的自己场上1只「征服斗魂」怪兽为对象才能发动。那只怪兽回到手卡，这张卡从手卡特殊召唤。
-- ②：自己·对方回合，可以从以下选择1个，把那属性的手卡的怪兽各1只给对方观看发动。
-- ●暗：自己从卡组抽1张。
-- ●地·炎：给与对方1500伤害。
--[[ __CARD_HEADER_END__ ]]

--VS ヘヴィ・ボーガー
function c92895501.initial_effect(c)
	--return and spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(92895501,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,92895501)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_MAIN_END)
	e1:SetCondition(c92895501.spcon)
	e1:SetTarget(c92895501.sptg)
	e1:SetOperation(c92895501.spop)
	c:RegisterEffect(e1)
	--show dark for draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(92895501,1))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,92895502)
	e2:SetHintTiming(0,TIMING_END_PHASE)
	e2:SetCost(c92895501.drcost)
	e2:SetTarget(c92895501.drtg)
	e2:SetOperation(c92895501.drop)
	c:RegisterEffect(e2)
	--show earth and fire for damage
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(92895501,2))
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,92895502)
	e3:SetHintTiming(0,TIMING_END_PHASE)
	e3:SetCost(c92895501.dmgcost)
	e3:SetTarget(c92895501.dmgtg)
	e3:SetOperation(c92895501.dmgop)
	c:RegisterEffect(e3)
end
function c92895501.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2
end
function c92895501.spfilter(c,tp)
	return c:IsSetCard(0x195) and c:IsFaceup() and c:IsAbleToHand() and not c:IsRace(RACE_MACHINE)
		and Duel.GetMZoneCount(tp,c)>0
end
function c92895501.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c92895501.spfilter(chkc,tp) end
	local c=e:GetHandler()
	if chk==0 then return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.IsExistingTarget(c92895501.spfilter,tp,LOCATION_MZONE,0,1,nil,tp)
		and Duel.GetFlagEffect(tp,92895501)==0 end
	Duel.RegisterFlagEffect(tp,92895501,RESET_CHAIN,0,1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c92895501.spfilter,tp,LOCATION_MZONE,0,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c92895501.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToChain() and Duel.SendtoHand(tc,nil,REASON_EFFECT)>0
		and tc:IsLocation(LOCATION_HAND) and c:IsRelateToChain() then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c92895501.drcfilter(c)
	return c:IsAttribute(ATTRIBUTE_DARK) and not c:IsPublic()
end
function c92895501.drcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c92895501.drcfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=Duel.SelectMatchingCard(tp,c92895501.drcfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.ConfirmCards(1-tp,g)
	Duel.RaiseEvent(g,EVENT_CUSTOM+9091064,e,REASON_COST,tp,tp,0)
	Duel.ShuffleHand(tp)
end
function c92895501.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1)
		and Duel.GetFlagEffect(tp,92895501)==0 end
	Duel.RegisterFlagEffect(tp,92895501,RESET_CHAIN,0,1)
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c92895501.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c92895501.dmgcfilter(c)
	return c:IsAttribute(ATTRIBUTE_EARTH+ATTRIBUTE_FIRE) and not c:IsPublic()
end
function c92895501.dmgcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c92895501.dmgcfilter,tp,LOCATION_HAND,0,nil)
	if chk==0 then return g:CheckSubGroup(aux.gfcheck,2,2,Card.IsAttribute,ATTRIBUTE_EARTH,ATTRIBUTE_FIRE) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local sg=g:SelectSubGroup(tp,aux.gfcheck,false,2,2,Card.IsAttribute,ATTRIBUTE_EARTH,ATTRIBUTE_FIRE)
	Duel.ConfirmCards(1-tp,sg)
	Duel.RaiseEvent(sg,EVENT_CUSTOM+9091064,e,REASON_COST,tp,tp,0)
	Duel.ShuffleHand(tp)
end
function c92895501.dmgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,92895501)==0 end
	Duel.RegisterFlagEffect(tp,92895501,RESET_CHAIN,0,1)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(1500)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1500)
end
function c92895501.dmgop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
