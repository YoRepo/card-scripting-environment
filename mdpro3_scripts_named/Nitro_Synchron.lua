--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Nitro Synchron  (ID: 96182448)
-- Type: Monster / Effect / Tuner
-- Attribute: FIRE
-- Race: Machine
-- Level: 2
-- ATK 300 | DEF 100
-- Setcode: 0x1017
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is sent to the Graveyard for the Synchro Summon of a "Nitro" Synchro Monster: Draw 1
-- card.
--[[ __CARD_HEADER_END__ ]]

--ニトロ・シンクロン
function c96182448.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(96182448,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetCondition(c96182448.drcon)
	e1:SetTarget(c96182448.drtg)
	e1:SetOperation(c96182448.drop)
	c:RegisterEffect(e1)
end
function c96182448.drcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsLocation(LOCATION_GRAVE) and r==REASON_SYNCHRO and c:GetReasonCard():IsCode(18013090)
end
function c96182448.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c96182448.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
