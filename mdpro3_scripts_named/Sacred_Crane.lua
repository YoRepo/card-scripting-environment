--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Sacred Crane  (ID: 30914564)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Winged Beast
-- Level: 4
-- ATK 1600 | DEF 400
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is Special Summoned: Draw 1 card.
--[[ __CARD_HEADER_END__ ]]

--聖鳥クレイン
function c30914564.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(30914564,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetTarget(c30914564.target)
	e1:SetOperation(c30914564.operation)
	c:RegisterEffect(e1)
end
function c30914564.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c30914564.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
