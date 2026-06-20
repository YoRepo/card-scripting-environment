--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 神鸟的排击  (ID: 64002884)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 301
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：从手卡丢弃1只鸟兽族怪兽才能发动。对方的魔法与陷阱区域的卡全部回到持有者手卡。
-- ②：把墓地的这张卡除外才能发动。手卡1只鸟兽族怪兽给对方观看。这个回合，那只怪兽以及自己手卡的同名怪兽的等级下降1星。
--[[ __CARD_HEADER_END__ ]]

--神鳥の排撃
function c64002884.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(64002884,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,64002884+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c64002884.cost)
	e1:SetTarget(c64002884.target)
	e1:SetOperation(c64002884.activate)
	c:RegisterEffect(e1)
	--lvdown
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(64002884,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c64002884.lvtg)
	e2:SetOperation(c64002884.lvop)
	c:RegisterEffect(e2)
end
function c64002884.costfilter(c)
	return c:IsRace(RACE_WINDBEAST) and c:IsDiscardable()
end
function c64002884.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c64002884.costfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c64002884.costfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c64002884.thfilter(c)
	return c:GetSequence()<5 and c:IsAbleToHand()
end
function c64002884.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c64002884.thfilter,tp,0,LOCATION_SZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c64002884.thfilter,tp,0,LOCATION_SZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c64002884.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c64002884.thfilter,tp,0,LOCATION_SZONE,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
	end
end
function c64002884.cffilter(c)
	return c:IsRace(RACE_WINDBEAST) and c:IsLevelAbove(2) and not c:IsPublic()
end
function c64002884.lvtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c64002884.cffilter,tp,LOCATION_HAND,0,1,nil) end
end
function c64002884.lvop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=Duel.SelectMatchingCard(tp,c64002884.cffilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.ConfirmCards(1-tp,g)
	Duel.ShuffleHand(tp)
	local sg=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_HAND,0,nil,g:GetFirst():GetCode())
	local tc=sg:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(-1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TOFIELD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		tc=sg:GetNext()
	end
end
