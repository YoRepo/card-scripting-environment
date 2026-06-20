--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 神秘之代行者 厄斯  (ID: 91188343)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Fairy
-- Level 2
-- ATK 1000 | DEF 800
-- Setcode: 68
--
-- Effect Text:
-- ①：这张卡召唤成功时才能发动。从卡组把「神秘之代行者 厄斯」以外的1只「代行者」怪兽加入手卡。场上有「天空的圣域」存在的场合，可以把加入手卡的怪兽改成1只「主宰者·许珀里翁」。
--[[ __CARD_HEADER_END__ ]]

--神秘の代行者 アース
function c91188343.initial_effect(c)
	aux.AddCodeList(c,56433456)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(91188343,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c91188343.tg)
	e1:SetOperation(c91188343.op)
	c:RegisterEffect(e1)
end
function c91188343.filter1(c)
	return c:IsSetCard(0x44) and not c:IsCode(91188343) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c91188343.filter2(c)
	return ((c:IsSetCard(0x44) and not c:IsCode(91188343) and c:IsType(TYPE_MONSTER)) or c:IsCode(55794644)) and c:IsAbleToHand()
end
function c91188343.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if not Duel.IsEnvironment(56433456) then
			return Duel.IsExistingMatchingCard(c91188343.filter1,tp,LOCATION_DECK,0,1,nil) end
		return Duel.IsExistingMatchingCard(c91188343.filter2,tp,LOCATION_DECK,0,1,nil)
	end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c91188343.op(e,tp,eg,ep,ev,re,r,rp)
	local g=nil
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	if not Duel.IsEnvironment(56433456) then
		g=Duel.SelectMatchingCard(tp,c91188343.filter1,tp,LOCATION_DECK,0,1,1,nil)
	else g=Duel.SelectMatchingCard(tp,c91188343.filter2,tp,LOCATION_DECK,0,1,1,nil) end
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
