--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Wattlemur  (ID: 45801022)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Thunder
-- Level: 2
-- ATK 800 | DEF 100
-- Setcode: 0xe
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card in its owner's possession is destroyed by your opponent's card: Your opponent cannot
-- conduct their Battle Phase during their next turn.
--[[ __CARD_HEADER_END__ ]]

--エレキツネザル
function c45801022.initial_effect(c)
	--bp limit
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(45801022,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetCondition(c45801022.condition)
	e1:SetOperation(c45801022.operation)
	c:RegisterEffect(e1)
end
function c45801022.condition(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and e:GetHandler():IsPreviousControler(tp)
end
function c45801022.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_BP)
	e1:SetTargetRange(0,1)
	e1:SetCondition(c45801022.con)
	e1:SetLabel(Duel.GetTurnCount())
	if Duel.GetTurnPlayer()==tp then
		e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN,1)
	else
		e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN,2)
	end
	Duel.RegisterEffect(e1,tp)
end
function c45801022.con(e)
	return Duel.GetTurnCount()~=e:GetLabel()
end
