--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Timeater  (ID: 44913552)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level: 6
-- ATK 1900 | DEF 1700
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card destroys an opponent's monster by battle: Your opponent skips their next Main Phase 1.
--[[ __CARD_HEADER_END__ ]]

--タイム・イーター
function c44913552.initial_effect(c)
	--skip draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44913552,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLE_DESTROYING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetOperation(c44913552.skipop)
	c:RegisterEffect(e2)
end
function c44913552.skipop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(0,1)
	e1:SetCode(EFFECT_SKIP_M1)
	e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
	Duel.RegisterEffect(e1,tp)
end
