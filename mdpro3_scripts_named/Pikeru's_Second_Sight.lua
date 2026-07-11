--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Pikeru's Second Sight  (ID: 58015506)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- Until your opponent's second End Phase, your opponent shows you all cards that they draw before
-- adding them to their hand.
--[[ __CARD_HEADER_END__ ]]

--ピケルの読心術
function c58015506.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c58015506.activate)
	c:RegisterEffect(e1)
end
function c58015506.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_DRAW)
	e1:SetOperation(c58015506.cfop)
	e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN,2)
	Duel.RegisterEffect(e1,tp)
end
function c58015506.cfop(e,tp,eg,ep,ev,re,r,rp)
	if ep==e:GetOwnerPlayer() then return end
	Duel.ConfirmCards(1-ep,eg)
end
