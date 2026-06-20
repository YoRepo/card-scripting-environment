--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 不幸的美少女  (ID: 51275027)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 1
-- ATK 0 | DEF 100
--
-- Effect Text:
-- 这张卡被战斗破坏送去墓地，当时那个回合的战斗阶段结束。
--[[ __CARD_HEADER_END__ ]]

--薄幸の美少女
function c51275027.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(51275027,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c51275027.condition)
	e1:SetOperation(c51275027.operation)
	c:RegisterEffect(e1)
end
function c51275027.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c51275027.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.SkipPhase(Duel.GetTurnPlayer(),PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE_STEP,1)
end
