--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 狱火机·亚得米勒  (ID: 88301393)
-- Type: Monster / Effect / SpecialSummon
-- Attribute: FIRE
-- Race: Fiend
-- Level 8
-- ATK 2800 | DEF 0
-- Setcode: 187
--
-- Effect Text:
-- 这张卡不能通常召唤。自己场上的效果怪兽的等级·阶级的合计是8以下时，把自己的手卡·墓地2只「狱火机」怪兽除外的场合才能从手卡·墓地特殊召唤。
-- ①：这张卡战斗破坏对方怪兽送去墓地时才能发动。这张卡只再1次可以继续攻击。
-- ②：自己·对方回合1次，把自己场上1只怪兽解放，以对方墓地1张卡为对象才能发动。那张卡除外。
--[[ __CARD_HEADER_END__ ]]

--インフェルノイド・アドラメレク
function c88301393.initial_effect(c)
	c:EnableReviveLimit()
	--special summon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e2:SetCondition(c88301393.spcon)
	e2:SetTarget(c88301393.sptg)
	e2:SetOperation(c88301393.spop)
	c:RegisterEffect(e2)
	--chain attack
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(88301393,0))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_DESTROYING)
	e3:SetCondition(c88301393.atcon)
	e3:SetOperation(c88301393.atop)
	c:RegisterEffect(e3)
	--remove
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(88301393,1))
	e4:SetCategory(CATEGORY_REMOVE)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetRange(LOCATION_MZONE)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetCountLimit(1)
	e4:SetCost(c88301393.rmcost)
	e4:SetTarget(c88301393.rmtg)
	e4:SetOperation(c88301393.rmop)
	c:RegisterEffect(e4)
end
function c88301393.spfilter(c)
	return c:IsSetCard(0xbb) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c88301393.sumfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_EFFECT)
end
function c88301393.lv_or_rk(c)
	if c:IsType(TYPE_XYZ) then return c:GetRank()
	else return c:GetLevel() end
end
function c88301393.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local sum=Duel.GetMatchingGroup(c88301393.sumfilter,tp,LOCATION_MZONE,0,nil):GetSum(c88301393.lv_or_rk)
	if sum>8 then return false end
	local loc=LOCATION_GRAVE+LOCATION_HAND
	if c:IsHasEffect(34822850) then loc=loc+LOCATION_MZONE end
	local g=Duel.GetMatchingGroup(c88301393.spfilter,tp,loc,0,c)
	return g:CheckSubGroup(aux.mzctcheck,2,2,tp)
end
function c88301393.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local loc=LOCATION_GRAVE+LOCATION_HAND
	if c:IsHasEffect(34822850) then loc=loc+LOCATION_MZONE end
	local g=Duel.GetMatchingGroup(c88301393.spfilter,tp,loc,0,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local sg=g:SelectSubGroup(tp,aux.mzctcheck,true,2,2,tp)
	if sg then
		sg:KeepAlive()
		e:SetLabelObject(sg)
		return true
	else return false end
end
function c88301393.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.Remove(g,POS_FACEUP,REASON_SPSUMMON)
	g:DeleteGroup()
end
function c88301393.atcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return bc:IsLocation(LOCATION_GRAVE) and bc:IsType(TYPE_MONSTER) and c:IsChainAttackable() and c:IsStatus(STATUS_OPPO_BATTLE)
end
function c88301393.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChainAttack()
end
function c88301393.rmcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,nil,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,nil,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c88301393.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(1-tp) and chkc:IsAbleToRemove() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToRemove,tp,0,LOCATION_GRAVE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,0,LOCATION_GRAVE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,1-tp,LOCATION_GRAVE)
end
function c88301393.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
