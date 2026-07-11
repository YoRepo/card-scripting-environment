--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Magician of Faith  (ID: 31560081)
-- Type: Monster / Effect / Flip
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level: 1
-- ATK 300 | DEF 400
-- Scope: OCG / TCG
--
-- Effect Text:
-- FLIP: Target 1 Spell in your GY; add that target to your hand.
--[[ __CARD_HEADER_END__ ]]

--聖なる魔術師
function c31560081.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(31560081,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c31560081.target)
	e1:SetOperation(c31560081.operation)
	c:RegisterEffect(e1)
end
function c31560081.filter(c)
	return c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c31560081.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c31560081.filter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c31560081.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c31560081.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
