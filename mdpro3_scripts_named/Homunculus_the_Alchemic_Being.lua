--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Homunculus the Alchemic Being  (ID: 40410110)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Plant
-- Level: 4
-- ATK 1800 | DEF 1600
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn: You can change the Attribute of this card.
--[[ __CARD_HEADER_END__ ]]

--錬金生物 ホムンクルス
function c40410110.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(40410110,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetOperation(c40410110.attop)
	c:RegisterEffect(e1)
end
function c40410110.attop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTRIBUTE)
		local catt=c:GetAttribute()
		local att=Duel.AnnounceAttribute(tp,1,ATTRIBUTE_ALL&~catt)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_ATTRIBUTE)
		e1:SetValue(att)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
	end
end
