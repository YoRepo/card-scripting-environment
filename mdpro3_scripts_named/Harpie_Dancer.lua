--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Harpie Dancer  (ID: 68815132)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Winged Beast
-- Level: 4
-- ATK 1200 | DEF 1000
-- Setcode: 0x64
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can target 1 WIND monster you control; return it to the hand, then you can Normal Summon 1 WIND
-- monster.
-- You can only use this effect of "Harpie Dancer" once per turn.
-- This card's name becomes "Harpie Lady" while on the field or in the GY.
--[[ __CARD_HEADER_END__ ]]

--ハーピィ・ダンサー
function c68815132.initial_effect(c)
	--return
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(68815132,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,68815132)
	e1:SetTarget(c68815132.target)
	e1:SetOperation(c68815132.operation)
	c:RegisterEffect(e1)
	--change name
	aux.EnableChangeCode(c,76812113,LOCATION_MZONE+LOCATION_GRAVE)
end
function c68815132.filter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WIND) and c:IsAbleToHand()
end
function c68815132.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c68815132.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c68815132.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c68815132.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c68815132.sumfilter(c)
	return c:IsAttribute(ATTRIBUTE_WIND) and c:IsSummonable(true,nil)
end
function c68815132.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SendtoHand(tc,nil,REASON_EFFECT)>0 and tc:IsLocation(LOCATION_HAND) then
		if Duel.IsExistingMatchingCard(c68815132.sumfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil)
			and Duel.SelectYesNo(tp,aux.Stringid(68815132,1)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
			local g=Duel.SelectMatchingCard(tp,c68815132.sumfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil)
			Duel.Summon(tp,g:GetFirst(),true,nil)
		end
	end
end
