--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Combo Fighter  (ID: 8806072)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Warrior
-- Level: 4
-- ATK 1600 | DEF 800
-- Scope: OCG / TCG
--
-- Effect Text:
-- If a Chain (of 2 or more Links) occurred in your Main Phase 1, this card can attack twice during the
-- Battle Phase this turn.
--[[ __CARD_HEADER_END__ ]]

--コンボファイター
function c8806072.initial_effect(c)
	--chain
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetOperation(c8806072.chop)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EXTRA_ATTACK)
	e2:SetCondition(c8806072.atkcon)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
function c8806072.chop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetCurrentPhase()==PHASE_MAIN1 and Duel.GetTurnPlayer()==tp and Duel.GetCurrentChain()>1
		and e:GetHandler():GetFlagEffect(8806072)==0 then
		e:GetHandler():RegisterFlagEffect(8806072,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
	end
end
function c8806072.atkcon(e)
	return e:GetHandler():GetFlagEffect(8806072)~=0
end
