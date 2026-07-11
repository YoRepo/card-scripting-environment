--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Lich Lord, King of the Underworld  (ID: 55818463)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Zombie
-- Level: 6
-- ATK 2400 | DEF 1200
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you Tribute Summon this card, the Tribute must be DARK.
-- If this card is Tributed by a card effect and sent to the GY: Add this card from your GY to your
-- hand.
--[[ __CARD_HEADER_END__ ]]

--死王リッチーロード
function c55818463.initial_effect(c)
	--tribute limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_TRIBUTE_LIMIT)
	e1:SetValue(c55818463.tlimit)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(55818463,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_RELEASE)
	e2:SetCondition(c55818463.retcon)
	e2:SetTarget(c55818463.rettg)
	e2:SetOperation(c55818463.retop)
	c:RegisterEffect(e2)
end
function c55818463.tlimit(e,c)
	return not c:IsAttribute(ATTRIBUTE_DARK)
end
function c55818463.retcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_EFFECT)
end
function c55818463.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c55818463.retop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SendtoHand(c,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,c)
	end
end
