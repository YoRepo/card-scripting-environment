--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Dizzying Winds of Yosen Village  (ID: 62681049)
-- Type: Trap / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- Activate this card only if you control a Level 6 or higher "Yosenju" monster.
-- While you have a "Yosenju" card in your Pendulum Zone, if a monster would be returned from the field
-- to the hand by a card effect, shuffle it into the Deck instead, unless it is a "Yosenju" monster.
--[[ __CARD_HEADER_END__ ]]

--妖仙郷の眩暈風
function c62681049.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c62681049.condition)
	c:RegisterEffect(e1)
	--todeck
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EFFECT_TO_HAND_REDIRECT)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c62681049.tdtg)
	e2:SetCondition(c62681049.tdcon)
	e2:SetValue(LOCATION_DECKSHF)
	c:RegisterEffect(e2)
end
function c62681049.filter(c)
	return c:IsFaceup() and c:IsLevelAbove(6) and c:IsSetCard(0xb3)
end
function c62681049.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c62681049.filter,tp,LOCATION_MZONE,0,1,nil)
end
function c62681049.tdtg(e,c)
	return (c:IsFacedown() or not c:IsSetCard(0xb3)) and c:IsReason(REASON_EFFECT)
end
function c62681049.tdcon(e)
	return Duel.IsExistingMatchingCard(Card.IsSetCard,e:GetHandlerPlayer(),LOCATION_PZONE,0,1,nil,0xb3)
end
