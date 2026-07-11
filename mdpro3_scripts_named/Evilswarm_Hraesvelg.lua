--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Evilswarm Hraesvelg  (ID: 35209994)
-- Type: Monster / Effect / Flip
-- Attribute: DARK
-- Race: Winged Beast
-- Level: 4
-- ATK 1150 | DEF 1850
-- Setcode: 0xa
-- Scope: OCG / TCG
--
-- Effect Text:
-- FLIP: Target 1 face-up card your opponent controls; return that target to the hand.
--[[ __CARD_HEADER_END__ ]]

--ヴェルズ・フレイス
function c35209994.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(35209994,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c35209994.target)
	e1:SetOperation(c35209994.operation)
	c:RegisterEffect(e1)
end
function c35209994.filter(c)
	return c:IsFaceup() and c:IsAbleToHand()
end
function c35209994.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsOnField() and c35209994.filter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c35209994.filter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c35209994.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
