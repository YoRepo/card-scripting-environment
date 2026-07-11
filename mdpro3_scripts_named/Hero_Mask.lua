--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Hero Mask  (ID: 75141056)
-- Type: Spell
-- Scope: OCG / TCG
--
-- Effect Text:
-- Target 1 face-up monster you control; send 1 "Elemental HERO" monster from your Deck to the
-- Graveyard, and if you do, that target's name becomes the sent monster's name, until the End Phase.
--[[ __CARD_HEADER_END__ ]]

--ヒーロー・マスク
function c75141056.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c75141056.target)
	e1:SetOperation(c75141056.activate)
	c:RegisterEffect(e1)
end
function c75141056.tgfilter(c)
	return c:IsFaceup() and Duel.IsExistingMatchingCard(c75141056.cfilter,c:GetControler(),LOCATION_DECK,0,1,nil,c)
end
function c75141056.cfilter(c,tc)
	return c:IsSetCard(0x3008) and not c:IsCode(tc:GetCode()) and c:IsType(TYPE_MONSTER) and c:IsAbleToGrave()
end
function c75141056.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c75141056.tgfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c75141056.tgfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c75141056.tgfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c75141056.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c75141056.cfilter,tp,LOCATION_DECK,0,1,1,nil,tc)
	if g:GetCount()>0 then
		local gc=g:GetFirst()
		if Duel.SendtoGrave(gc,REASON_EFFECT)~=0 and gc:IsLocation(LOCATION_GRAVE) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CHANGE_CODE)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			e1:SetValue(gc:GetCode())
			tc:RegisterEffect(e1)
		end
	end
end
