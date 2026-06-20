--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 征服斗魂 普鲁同HG  (ID: 55688914)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Zombie
-- Level 6
-- ATK 0 | DEF 0
-- Setcode: 405
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次，同一连锁上不能发动。
-- ①：对方回合，自己的主要怪兽区域的怪兽不存在的场合或者只有「征服斗魂」怪兽的场合才能发动。这张卡从手卡特殊召唤。
-- ②：自己·对方回合，可以从以下选择1个，把那属性的手卡的怪兽各1只给对方观看发动。
-- ●炎：这张卡的守备力直到回合结束时上升3000。
-- ●暗·地：这张卡的攻击力直到回合结束时上升3000。
--[[ __CARD_HEADER_END__ ]]

--VS プルトンHG
function c55688914.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(55688914,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,55688914)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCondition(c55688914.spcon)
	e1:SetTarget(c55688914.sptg)
	e1:SetOperation(c55688914.spop)
	c:RegisterEffect(e1)
	--show fire for def up
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(55688914,1))
	e2:SetCategory(CATEGORY_DEFCHANGE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,55688915)
	e2:SetHintTiming(TIMING_DAMAGE_STEP)
	e2:SetCondition(aux.dscon)
	e2:SetCost(c55688914.defcost)
	e2:SetTarget(c55688914.deftg)
	e2:SetOperation(c55688914.defop)
	c:RegisterEffect(e2)
	--show earth and dark for atk up
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(55688914,2))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,55688915)
	e3:SetHintTiming(TIMING_DAMAGE_STEP)
	e3:SetCondition(aux.dscon)
	e3:SetCost(c55688914.atkcost)
	e3:SetTarget(c55688914.atktg)
	e3:SetOperation(c55688914.atkop)
	c:RegisterEffect(e3)
end
function c55688914.spcfilter1(c)
	return c:GetSequence()<5
end
function c55688914.spcfilter2(c)
	return c:GetSequence()<5 and c:IsSetCard(0x195) and c:IsFaceup()
end
function c55688914.spcon(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetTurnPlayer()~=1-tp then return false end
	local ct1=Duel.GetMatchingGroupCount(c55688914.spcfilter1,tp,LOCATION_MZONE,0,nil)
	local ct2=Duel.GetMatchingGroupCount(c55688914.spcfilter2,tp,LOCATION_MZONE,0,nil)
	return ct1==0 or ct1==ct2
end
function c55688914.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.GetFlagEffect(tp,55688914)==0 end
	Duel.RegisterFlagEffect(tp,55688914,RESET_CHAIN,0,1)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c55688914.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToChain() then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c55688914.defcfilter(c)
	return c:IsAttribute(ATTRIBUTE_FIRE) and not c:IsPublic()
end
function c55688914.defcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c55688914.defcfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=Duel.SelectMatchingCard(tp,c55688914.defcfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.ConfirmCards(1-tp,g)
	Duel.RaiseEvent(g,EVENT_CUSTOM+9091064,e,REASON_COST,tp,tp,0)
	Duel.ShuffleHand(tp)
end
function c55688914.deftg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,55688914)==0 end
	Duel.RegisterFlagEffect(tp,55688914,RESET_CHAIN,0,1)
end
function c55688914.defop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToChain() then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_DEFENSE)
	e1:SetValue(3000)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e1)
end
function c55688914.atkcfilter(c)
	return c:IsAttribute(ATTRIBUTE_EARTH+ATTRIBUTE_DARK) and not c:IsPublic()
end
function c55688914.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c55688914.atkcfilter,tp,LOCATION_HAND,0,nil)
	if chk==0 then return g:CheckSubGroup(aux.gfcheck,2,2,Card.IsAttribute,ATTRIBUTE_EARTH,ATTRIBUTE_DARK) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local sg=g:SelectSubGroup(tp,aux.gfcheck,false,2,2,Card.IsAttribute,ATTRIBUTE_EARTH,ATTRIBUTE_DARK)
	Duel.ConfirmCards(1-tp,sg)
	Duel.RaiseEvent(sg,EVENT_CUSTOM+9091064,e,REASON_COST,tp,tp,0)
	Duel.ShuffleHand(tp)
end
function c55688914.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,55688914)==0 end
	Duel.RegisterFlagEffect(tp,55688914,RESET_CHAIN,0,1)
end
function c55688914.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToChain() then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(3000)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e1)
end
