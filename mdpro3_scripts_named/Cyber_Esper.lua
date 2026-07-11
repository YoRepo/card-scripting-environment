--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Cyber Esper  (ID: 91663373)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Machine
-- Level: 4
-- ATK 1200 | DEF 1800
-- Setcode: 0x93
-- Scope: OCG / TCG
--
-- Effect Text:
-- While this card is in face-up Attack Position, you can look at every card your opponent draws.
--[[ __CARD_HEADER_END__ ]]

--サイバー・エスパー
function c91663373.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(91663373,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_DRAW)
	e1:SetCondition(c91663373.cfcon)
	e1:SetOperation(c91663373.cfop)
	c:RegisterEffect(e1)
end
function c91663373.cfcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsAttackPos() and ep==1-tp
end
function c91663373.filter(c)
	return c:IsLocation(LOCATION_HAND) and not c:IsPublic()
end
function c91663373.cfop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) and e:GetHandler():IsPosition(POS_FACEUP_ATTACK) then
		local cg=eg:Filter(c91663373.filter,nil)
		Duel.ConfirmCards(tp,cg)
		Duel.ShuffleHand(1-tp)
	end
end
