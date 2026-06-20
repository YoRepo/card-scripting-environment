--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 化合兽 碳素蟹  (ID: 81599449)
-- Type: Monster / Effect / Gemini
-- Attribute: FIRE
-- Race: Aqua
-- Level 2
-- ATK 700 | DEF 1400
-- Setcode: 235
--
-- Effect Text:
-- ①：这张卡只要在场上·墓地存在，当作通常怪兽使用。
-- ②：可以把场上的当作通常怪兽使用的这张卡作为通常召唤作再1次召唤。那个场合这张卡变成当作效果怪兽使用并得到以下效果。
-- ●自己主要阶段才能发动。从卡组把1只二重怪兽送去墓地。那之后，从卡组把1只二重怪兽加入手卡。这个卡名的这个效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--化合獣カーボン・クラブ
function c81599449.initial_effect(c)
	aux.EnableDualAttribute(c)
	--to grave/search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(81599449,0))
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1,81599449)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(aux.IsDualState)
	e1:SetTarget(c81599449.tgtg)
	e1:SetOperation(c81599449.tgop)
	c:RegisterEffect(e1)
end
function c81599449.filter(c,tp)
	return c:IsType(TYPE_DUAL) and c:IsAbleToGrave()
		and Duel.IsExistingMatchingCard(c81599449.thfilter,tp,LOCATION_DECK,0,1,c)
end
function c81599449.tgfilter(c)
	return c:IsType(TYPE_DUAL) and c:IsAbleToGrave()
end
function c81599449.thfilter(c)
	return c:IsType(TYPE_DUAL) and c:IsAbleToHand()
end
function c81599449.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c81599449.filter,tp,LOCATION_DECK,0,1,nil,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c81599449.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c81599449.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 and Duel.SendtoGrave(g,REASON_EFFECT)~=0
		and g:GetFirst():IsLocation(LOCATION_GRAVE) then
		local sg=Duel.GetMatchingGroup(c81599449.thfilter,tp,LOCATION_DECK,0,nil)
		if sg:GetCount()>0 then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local tg=sg:Select(tp,1,1,nil)
			Duel.SendtoHand(tg,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,tg)
		end
	end
end
