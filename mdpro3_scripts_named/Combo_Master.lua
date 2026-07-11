--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Combo Master  (ID: 44800181)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Warrior
-- Level: 5
-- ATK 2200 | DEF 1500
-- Scope: OCG / TCG
--
-- Effect Text:
-- If a Chain (of 2 or more Links) occurred in your Main Phase 1, this card can attack twice during the
-- Battle Phase this turn.
--[[ __CARD_HEADER_END__ ]]

--コンボマスター
function c44800181.initial_effect(c)
	--chain
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetOperation(c44800181.chop)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EXTRA_ATTACK)
	e2:SetCondition(c44800181.atkcon)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
function c44800181.chop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetCurrentPhase()==PHASE_MAIN1 and Duel.GetTurnPlayer()==tp and Duel.GetCurrentChain()>1
		and e:GetHandler():GetFlagEffect(44800181)==0 then
		e:GetHandler():RegisterFlagEffect(44800181,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
	end
end
function c44800181.atkcon(e)
	return e:GetHandler():GetFlagEffect(44800181)~=0
end
