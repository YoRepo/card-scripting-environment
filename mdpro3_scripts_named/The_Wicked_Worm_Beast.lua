--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: The Wicked Worm Beast  (ID: 6285791)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast
-- Level: 3
-- ATK 1400 | DEF 700
-- Setcode: 0x3e
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn, during your End Phase: Return this face-up card to the hand.
--[[ __CARD_HEADER_END__ ]]

--邪悪なるワーム・ビースト
function c6285791.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(6285791,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c6285791.retcon)
	e1:SetTarget(c6285791.rettg)
	e1:SetOperation(c6285791.retop)
	c:RegisterEffect(e1)
end
function c6285791.retcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c6285791.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c6285791.retop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		Duel.SendtoHand(c,nil,REASON_EFFECT)
	end
end
