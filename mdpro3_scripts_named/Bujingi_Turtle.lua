--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Bujingi Turtle  (ID: 5818294)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Beast
-- Level: 4
-- ATK 1700 | DEF 1200
-- Setcode: 0x88
-- Scope: OCG / TCG
--
-- Effect Text:
-- During either player's turn, when a card or effect is activated that targets a "Bujin" monster you
-- control (except during the Damage Step): You can banish this card from your Graveyard; negate that
-- effect.
--[[ __CARD_HEADER_END__ ]]

--武神器－ヘツカ
function c5818294.initial_effect(c)
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(5818294,0))
	e1:SetCategory(CATEGORY_DISABLE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c5818294.negcon)
	e1:SetCost(aux.bfgcost)
	e1:SetTarget(c5818294.negtg)
	e1:SetOperation(c5818294.negop)
	c:RegisterEffect(e1)
end
function c5818294.tfilter(c,tp)
	return c:IsLocation(LOCATION_MZONE) and c:IsControler(tp) and c:IsFaceup() and c:IsSetCard(0x88)
end
function c5818294.negcon(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return g and g:IsExists(c5818294.tfilter,1,nil,tp) and Duel.IsChainDisablable(ev)
end
function c5818294.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function c5818294.negop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
end
