--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Aurkus, Lightsworn Druid  (ID: 7183277)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Beast-Warrior
-- Level: 3
-- ATK 1200 | DEF 1800
-- Setcode: 0x38
-- Scope: OCG / TCG
--
-- Effect Text:
-- Neither player can target "Lightsworn" monsters (anywhere) with card effects.
-- Once per turn, during your End Phase: Send the top 2 cards of your Deck to the GY.
--[[ __CARD_HEADER_END__ ]]

--ライトロード・ドルイド オルクス
function c7183277.initial_effect(c)
	--cannot be target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetProperty(EFFECT_FLAG_IGNORE_RANGE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c7183277.etarget)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--discard deck
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetDescription(aux.Stringid(7183277,0))
	e2:SetCategory(CATEGORY_DECKDES)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c7183277.discon)
	e2:SetTarget(c7183277.distg)
	e2:SetOperation(c7183277.disop)
	c:RegisterEffect(e2)
end
function c7183277.etarget(e,c)
	return c:IsSetCard(0x38) and c:IsType(TYPE_MONSTER)
end
function c7183277.discon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c7183277.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,2)
end
function c7183277.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardDeck(tp,2,REASON_EFFECT)
end
