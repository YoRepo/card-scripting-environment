--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Cockroach Knight  (ID: 33413638)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Insect
-- Level: 3
-- ATK 800 | DEF 900
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card has been sent to the Graveyard, it is returned to the top of the Deck.
--[[ __CARD_HEADER_END__ ]]

--コカローチ・ナイト
function c33413638.initial_effect(c)
	--to deck top
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33413638,0))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetTarget(c33413638.tdtg)
	e1:SetOperation(c33413638.tdop)
	c:RegisterEffect(e1)
end
function c33413638.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end
function c33413638.tdop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SendtoDeck(e:GetHandler(),nil,SEQ_DECKTOP,REASON_EFFECT)
	end
end
