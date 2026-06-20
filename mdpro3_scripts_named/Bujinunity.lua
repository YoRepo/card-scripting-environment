--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 武神集结  (ID: 33611061)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 136
--
-- Effect Text:
-- 自己场上没有这张卡以外的卡存在的场合才能发动。自己墓地的名字带有「武神」的兽战士族怪兽全部回到卡组，自己手卡全部送去墓地。那之后，可以从卡组把最多3只卡名不同的名字带有「武神」的兽战士族怪兽加入手卡。
-- 「武神集结」在1回合只能发动1张。
--[[ __CARD_HEADER_END__ ]]

--武神集結
function c33611061.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_HANDES+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,33611061+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c33611061.condition)
	e1:SetTarget(c33611061.target)
	e1:SetOperation(c33611061.activate)
	c:RegisterEffect(e1)
end
function c33611061.condition(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(nil,tp,LOCATION_ONFIELD,0,1,e:GetHandler())
end
function c33611061.filter(c)
	return c:IsSetCard(0x88) and c:IsRace(RACE_BEASTWARRIOR) and c:IsAbleToDeck()
end
function c33611061.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c33611061.filter,tp,LOCATION_GRAVE,0,1,nil) end
	local g=Duel.GetMatchingGroup(c33611061.filter,tp,LOCATION_GRAVE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c33611061.thfilter(c)
	return c:IsSetCard(0x88) and c:IsRace(RACE_BEASTWARRIOR) and c:IsAbleToHand()
end
function c33611061.activate(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetMatchingGroup(c33611061.filter,tp,LOCATION_GRAVE,0,nil)
	if aux.NecroValleyNegateCheck(tg) then return end
	if tg:GetCount()>0 then
		Duel.SendtoDeck(tg,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
		local hg=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
		Duel.SendtoGrave(hg,REASON_EFFECT)
		Duel.BreakEffect()
		local g=Duel.GetMatchingGroup(c33611061.thfilter,tp,LOCATION_DECK,0,nil)
		if g:GetCount()==0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g1=g:SelectSubGroup(tp,aux.dncheck,false,1,3)
		Duel.SendtoHand(g1,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g1)
	end
end
