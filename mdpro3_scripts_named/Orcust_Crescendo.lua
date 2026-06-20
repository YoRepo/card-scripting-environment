--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 自奏圣乐之阶  (ID: 703897)
-- Type: Trap / Flip
-- ATK 0 | DEF 0
-- Setcode: 283
--
-- Effect Text:
-- 这个卡名的①②的效果1回合只能有1次使用其中任意1个。
-- ①：自己场上有「自奏圣乐」连接怪兽存在，怪兽的效果·魔法·陷阱卡发动时才能发动。那个发动无效并除外。
-- ②：把墓地的这张卡除外才能发动（这个效果发动的回合，自己不是机械族·暗属性怪兽不能特殊召唤）。自己的卡组·除外状态的1只机械族·暗属性怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--オルフェゴール・クリマクス
function c703897.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCountLimit(1,703897)
	e1:SetCondition(c703897.condition)
	e1:SetTarget(aux.nbtg)
	e1:SetOperation(c703897.activate)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCountLimit(1,703897)
	e2:SetCost(c703897.thcost)
	e2:SetTarget(c703897.thtg)
	e2:SetOperation(c703897.thop)
	c:RegisterEffect(e2)
	Duel.AddCustomActivityCounter(703897,ACTIVITY_SPSUMMON,c703897.counterfilter)
end
function c703897.counterfilter(c)
	return c:IsRace(RACE_MACHINE) and c:IsAttribute(ATTRIBUTE_DARK)
end
function c703897.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x11b) and c:IsType(TYPE_LINK)
end
function c703897.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c703897.cfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsChainNegatable(ev) and (re:IsActiveType(TYPE_MONSTER) or re:IsHasType(EFFECT_TYPE_ACTIVATE))
end
function c703897.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Remove(eg,POS_FACEUP,REASON_EFFECT)
	end
end
function c703897.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(703897,tp,ACTIVITY_SPSUMMON)==0
		and aux.bfgcost(e,tp,eg,ep,ev,re,r,rp,0) end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c703897.splimit)
	Duel.RegisterEffect(e1,tp)
	aux.bfgcost(e,tp,eg,ep,ev,re,r,rp,1)
end
function c703897.splimit(e,c)
	return not (c:IsRace(RACE_MACHINE) and c:IsAttribute(ATTRIBUTE_DARK))
end
function c703897.thfilter(c)
	return c:IsRace(RACE_MACHINE) and c:IsAttribute(ATTRIBUTE_DARK) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
		and (not c:IsLocation(LOCATION_REMOVED) or c:IsFaceup())
end
function c703897.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c703897.thfilter,tp,LOCATION_DECK+LOCATION_REMOVED,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_REMOVED)
end
function c703897.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c703897.thfilter,tp,LOCATION_DECK+LOCATION_REMOVED,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
