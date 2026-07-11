--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Second Coin Toss  (ID: 36562627)
-- Type: Spell / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- When a coin toss is performed, you can choose to redo the coin toss.
-- (If the toss involved multiple coin flips, redo all of them.)
-- You can only use the effect of "Second Coin Toss" once per turn.
--[[ __CARD_HEADER_END__ ]]

--セカンド・チャンス
function c36562627.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--coin
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_TOSS_COIN_NEGATE)
	e2:SetCondition(c36562627.coincon)
	e2:SetOperation(c36562627.coinop)
	c:RegisterEffect(e2)
end
function c36562627.coincon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and Duel.GetFlagEffect(tp,36562627)==0
end
function c36562627.coinop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,36562627)~=0 then return end
	if Duel.SelectYesNo(tp,aux.Stringid(36562627,0)) then
		Duel.Hint(HINT_CARD,0,36562627)
		Duel.RegisterFlagEffect(tp,36562627,RESET_PHASE+PHASE_END,0,1)
		Duel.TossCoin(tp,ev)
	end
end
