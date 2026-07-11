--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Tindangle Protector  (ID: 67744384)
-- Type: Monster / Effect / Flip
-- Attribute: DARK
-- Race: Fiend
-- Level: 3
-- ATK 800 | DEF 1600
-- Setcode: 0x10b
-- Scope: OCG / TCG
--
-- Effect Text:
-- FLIP: You can change up to 3 face-down Defense Position monsters you control to face-up Defense
-- Position, then if all those monsters are "Tindangle" monsters, you can add up to that many
-- "Tindangle" cards from your Deck to your hand.
-- You can only use this effect of "Tindangle Protector" once per turn.
--[[ __CARD_HEADER_END__ ]]

--ティンダングル・アポストル
function c67744384.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(67744384,0))
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,67744384)
	e1:SetTarget(c67744384.target)
	e1:SetOperation(c67744384.operation)
	c:RegisterEffect(e1)
end
function c67744384.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFacedown,tp,LOCATION_MZONE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_POSITION,nil,1,0,0)
end
function c67744384.thfilter(c)
	return c:IsSetCard(0x10b) and c:IsAbleToHand()
end
function c67744384.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectMatchingCard(tp,Card.IsFacedown,tp,LOCATION_MZONE,0,1,3,nil)
	if g:GetCount()>0 then
		local ct=Duel.ChangePosition(g,POS_FACEUP_DEFENSE)
		local og=Duel.GetOperatedGroup()
		if og:IsExists(Card.IsSetCard,ct,nil,0x10b) then
			local sg=Duel.GetMatchingGroup(c67744384.thfilter,tp,LOCATION_DECK,0,nil)
			if sg:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(67744384,1)) then
				Duel.BreakEffect()
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
				local tg=sg:Select(tp,1,ct,nil)
				Duel.SendtoHand(tg,tp,REASON_EFFECT)
				Duel.ConfirmCards(1-tp,tg)
			end
		end
	end
end
