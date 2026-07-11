--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Karakuri Cash Cache  (ID: 80204957)
-- Type: Spell
-- Setcode: 0x11
-- Scope: OCG / TCG
--
-- Effect Text:
-- Select 1 face-up "Karakuri" monster you control.
-- Add 1 Level 4 or lower "Karakuri" monster from your Deck to your hand and change the battle position
-- of the selected monster.
--[[ __CARD_HEADER_END__ ]]

--借カラクリ蔵
function c80204957.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_POSITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c80204957.target)
	e1:SetOperation(c80204957.activate)
	c:RegisterEffect(e1)
end
function c80204957.filter1(c)
	return c:IsLevelBelow(4) and c:IsSetCard(0x11) and c:IsAbleToHand()
end
function c80204957.filter2(c)
	return c:IsFaceup() and c:IsSetCard(0x11) and c:IsCanChangePosition()
end
function c80204957.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c80204957.filter2(chkc) end
	if chk==0 then return Duel.IsExistingMatchingCard(c80204957.filter1,tp,LOCATION_DECK,0,1,nil)
		and Duel.IsExistingTarget(c80204957.filter2,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,c80204957.filter2,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c80204957.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c80204957.filter1,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		local tc=Duel.GetFirstTarget()
		if tc:IsRelateToEffect(e) then
			Duel.ChangePosition(tc,POS_FACEUP_DEFENSE,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK)
		end
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
