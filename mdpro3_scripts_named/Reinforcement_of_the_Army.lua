--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 增援  (ID: 32807846)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：从卡组把1只4星以下的战士族怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--増援
function c32807846.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c32807846.target)
	e1:SetOperation(c32807846.activate)
	c:RegisterEffect(e1)
end
function c32807846.filter(c)
	return c:IsLevelBelow(4) and c:IsRace(RACE_WARRIOR) and c:IsAbleToHand()
end
function c32807846.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c32807846.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c32807846.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c32807846.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
