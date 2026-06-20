--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 世界不灭  (ID: 32828635)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：等级合计直到变成仪式召唤的怪兽的等级以上为止，把自己场上的怪兽解放，从手卡把「破灭之女神 露茵」或「终焉之王 迪米斯」仪式召唤。
-- ②：让这个回合没有送去墓地的这张卡从墓地回到卡组才能发动。从卡组把1张「世界末日」加入手卡。那之后，可以从自己墓地把1只「破灭之女神 露茵」或「终焉之王 迪米斯」加入手卡。
--[[ __CARD_HEADER_END__ ]]

--エンドレス・オブ・ザ・ワールド
function c32828635.initial_effect(c)
	aux.AddCodeList(c,8198712,46427957,72426662)
	aux.AddRitualProcGreater2Code2(c,46427957,72426662,nil,nil,c32828635.mfilter)
	--salvage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(32828635,0))
	e2:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCondition(aux.exccon)
	e2:SetCost(c32828635.thcost)
	e2:SetTarget(c32828635.thtg)
	e2:SetOperation(c32828635.thop)
	c:RegisterEffect(e2)
end
function c32828635.mfilter(c)
	return not c:IsLocation(LOCATION_HAND)
end
function c32828635.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToDeckAsCost() end
	Duel.SendtoDeck(e:GetHandler(),nil,SEQ_DECKSHUFFLE,REASON_COST)
end
function c32828635.filter(c)
	return c:IsCode(8198712) and c:IsAbleToHand()
end
function c32828635.filter2(c)
	return c:IsCode(46427957,72426662) and c:IsAbleToHand()
end
function c32828635.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c32828635.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c32828635.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c32828635.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
		local mg=Duel.GetMatchingGroup(aux.NecroValleyFilter(c32828635.filter2),tp,LOCATION_GRAVE,0,nil)
		if mg:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(32828635,1)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local sg=mg:Select(tp,1,1,nil)
			Duel.SendtoHand(sg,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,sg)
		end
	end
end
