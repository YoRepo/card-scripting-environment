--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 这是菜单  (ID: 41773061)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：从卡组把2只卡名不同的「新式魔厨」怪兽给对方观看，对方从那之中选1只。那1只怪兽加入自己手卡，剩余回到卡组。那之后，可以从自己的卡组·墓地选这个效果加入手卡的怪兽种族的1张以下的卡加入手卡。
-- ●兽战士族：「鱼料理的食谱」
-- ●战士族：「肉料理的食谱」
--[[ __CARD_HEADER_END__ ]]

--Voici la Carte～メニューはこちら～
function c41773061.initial_effect(c)
	aux.AddCodeList(c,87778106,14166715)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND+CATEGORY_GRAVE_ACTION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCountLimit(1,41773061+EFFECT_COUNT_CODE_OATH)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c41773061.target)
	e1:SetOperation(c41773061.activate)
	c:RegisterEffect(e1)
end
function c41773061.filter(c)
	return c:IsSetCard(0x196) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c41773061.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c41773061.filter,tp,LOCATION_DECK,0,nil)
	if chk==0 then return g:GetClassCount(Card.GetCode)>1 end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c41773061.thfilter(c,code)
	return c:IsCode(code) and c:IsAbleToHand()
end
function c41773061.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c41773061.filter,tp,LOCATION_DECK,0,nil)
	if g:GetClassCount(Card.GetCode)<2 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local sg=g:SelectSubGroup(tp,aux.dncheck,false,2,2)
	Duel.ConfirmCards(1-tp,sg)
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_ATOHAND)
	local tc=sg:Select(1-tp,1,1,nil):GetFirst()
	local code=0
	if tc:IsRace(RACE_BEASTWARRIOR) then code=87778106 end
	if tc:IsRace(RACE_WARRIOR) then code=14166715 end
	local g2=Duel.GetMatchingGroup(aux.NecroValleyFilter(c41773061.thfilter),tp,LOCATION_DECK+LOCATION_GRAVE,0,nil,code)
	if Duel.SendtoHand(tc,nil,REASON_EFFECT)>0 and tc:IsRace(RACE_BEASTWARRIOR+RACE_WARRIOR)
		and #g2>0 and Duel.SelectYesNo(tp,aux.Stringid(41773061,1)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg2=g2:Select(tp,1,1,nil)
		Duel.SendtoHand(sg2,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg2)
	end
end
