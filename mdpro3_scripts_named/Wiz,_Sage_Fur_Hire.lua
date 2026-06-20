--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 空牙团的睿智 薇兹  (ID: 1527418)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Spellcaster
-- Level 7
-- ATK 1600 | DEF 2800
-- Setcode: 276
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：这张卡特殊召唤的场合才能发动。自己回复「空牙团的睿智 薇兹」以外的自己场上的「空牙团」怪兽种类×500基本分。
-- ②：对方把魔法·陷阱卡的效果发动时，从手卡丢弃1张「空牙团」卡才能发动。那个发动无效。
--[[ __CARD_HEADER_END__ ]]

--空牙団の叡智 ウィズ
function c1527418.initial_effect(c)
	--recover
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1527418,0))
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,1527418)
	e1:SetTarget(c1527418.rectg)
	e1:SetOperation(c1527418.recop)
	c:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(1527418,1))
	e2:SetCategory(CATEGORY_NEGATE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,1527419)
	e2:SetCondition(c1527418.negcon)
	e2:SetCost(c1527418.negcost)
	e2:SetTarget(c1527418.negtg)
	e2:SetOperation(c1527418.negop)
	c:RegisterEffect(e2)
end
function c1527418.recfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x114) and not c:IsCode(1527418)
end
function c1527418.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c1527418.recfilter,tp,LOCATION_MZONE,0,1,nil) end
	local g=Duel.GetMatchingGroup(c1527418.recfilter,tp,LOCATION_MZONE,0,nil)
	local rec=g:GetClassCount(Card.GetCode)*500
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,rec)
end
function c1527418.recop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c1527418.recfilter,tp,LOCATION_MZONE,0,nil)
	local rec=g:GetClassCount(Card.GetCode)*500
	Duel.Recover(tp,rec,REASON_EFFECT)
end
function c1527418.negcon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED)
		and ep~=tp and re:IsActiveType(TYPE_SPELL+TYPE_TRAP) and Duel.IsChainNegatable(ev)
end
function c1527418.cfilter(c,e,tp)
	if c:IsLocation(LOCATION_HAND) then
		return c:IsSetCard(0x114) and c:IsDiscardable()
	else
		return e:GetHandler():IsSetCard(0x114) and c:IsAbleToRemoveAsCost() and c:IsHasEffect(53557529,tp)
	end
end
function c1527418.negcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c1527418.cfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local g=Duel.SelectMatchingCard(tp,c1527418.cfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	local te=tc:IsHasEffect(53557529,tp)
	if te then
		te:UseCountLimit(tp)
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT+REASON_REPLACE)
	else
		Duel.SendtoGrave(tc,REASON_COST+REASON_DISCARD)
	end
end
function c1527418.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function c1527418.negop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
end
