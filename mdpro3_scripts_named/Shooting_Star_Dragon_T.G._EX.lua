--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 流星龙·科技属扩张  (ID: 63180841)
-- Type: Monster / Effect / Synchro
-- Attribute: WIND
-- Race: Dragon
-- Level 10
-- ATK 3300 | DEF 2500
-- Setcode: 39
--
-- Effect Text:
-- 同调怪兽调整＋调整以外的同调怪兽1只以上
-- 这个卡名的②③的效果1回合各能使用1次。
-- ①：自己场上的怪兽为对象的怪兽的效果发动时，从自己墓地把1只调整除外才能发动。那个发动无效并破坏。
-- ②：对方怪兽的攻击宣言时才能发动。那次攻击无效。
-- ③：对方回合，这张卡在墓地存在的场合，把自己场上2只同调怪兽解放才能发动。这张卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--シューティング・スター・ドラゴン・TG－EX
function c63180841.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSynchroType,TYPE_SYNCHRO),aux.NonTuner(Card.IsSynchroType,TYPE_SYNCHRO),1)
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(63180841,0))
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c63180841.discon)
	e1:SetCost(c63180841.discost)
	e1:SetTarget(c63180841.distg)
	e1:SetOperation(c63180841.disop)
	c:RegisterEffect(e1)
	--disable attack
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(63180841,1))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,63180841)
	e2:SetCondition(c63180841.atkcon)
	e2:SetOperation(c63180841.atkop)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(63180841,2))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e3:SetCountLimit(1,63180842)
	e3:SetCondition(c63180841.spcon)
	e3:SetCost(c63180841.spcost)
	e3:SetTarget(c63180841.sptg)
	e3:SetOperation(c63180841.spop)
	c:RegisterEffect(e3)
end
c63180841.material_type=TYPE_SYNCHRO
function c63180841.tfilter(c,tp)
	return c:IsLocation(LOCATION_MZONE) and c:IsControler(tp)
end
function c63180841.disfilter(c)
	return c:IsType(TYPE_TUNER) and c:IsAbleToRemoveAsCost()
end
function c63180841.discon(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) then return false end
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) or not re:IsActiveType(TYPE_MONSTER) then return false end
	local tg=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return tg and tg:IsExists(c63180841.tfilter,1,nil,tp) and Duel.IsChainNegatable(ev)
end
function c63180841.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c63180841.disfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c63180841.disfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c63180841.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c63180841.disop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
function c63180841.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp)
end
function c63180841.atkop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
function c63180841.spfilter(c,tp)
	return c:IsType(TYPE_SYNCHRO) and (c:IsControler(tp) or c:IsFaceup())
end
function c63180841.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==1-tp
end
function c63180841.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetReleaseGroup(tp):Filter(c63180841.spfilter,nil,tp)
	if chk==0 then return g:CheckSubGroup(aux.mzctcheckrel,2,2,tp) end
	local rg=g:SelectSubGroup(tp,aux.mzctcheckrel,false,2,2,tp)
	aux.UseExtraReleaseCount(rg,tp)
	Duel.Release(rg,REASON_COST)
end
function c63180841.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c63180841.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
