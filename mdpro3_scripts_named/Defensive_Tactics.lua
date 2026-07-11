--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Defensive Tactics  (ID: 28877100)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control a face-up "Gladiator Beast" monster: For the rest of this turn, monsters you control
-- cannot be destroyed by battle, and any Battle Damage you take is reduced to 0.
-- After this card resolves, put it on the bottom of your Deck.
--[[ __CARD_HEADER_END__ ]]

--ディフェンシブ・タクティクス
function c28877100.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_MAIN_END)
	e1:SetCondition(c28877100.condition)
	e1:SetOperation(c28877100.activate)
	c:RegisterEffect(e1)
end
function c28877100.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x1019)
end
function c28877100.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c28877100.filter,tp,LOCATION_MZONE,0,1,nil)
end
function c28877100.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetValue(1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetReset(RESET_PHASE+PHASE_END)
	e2:SetValue(1)
	Duel.RegisterEffect(e2,tp)
	if e:GetHandler():IsRelateToEffect(e) then
		e:GetHandler():CancelToGrave()
		Duel.SendtoDeck(e:GetHandler(),nil,SEQ_DECKBOTTOM,REASON_EFFECT)
	end
end
