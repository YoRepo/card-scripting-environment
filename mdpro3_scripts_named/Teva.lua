--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Teva  (ID: 16469012)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level: 5
-- ATK 2000 | DEF 1500
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is Tribute Summoned successfully, your opponent cannot declare an attack during
-- his/her next turn.
--[[ __CARD_HEADER_END__ ]]

--テーヴァ
function c16469012.initial_effect(c)
	--to deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(16469012,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c16469012.condition)
	e1:SetOperation(c16469012.operation)
	c:RegisterEffect(e1)
end
function c16469012.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_ADVANCE)
end
function c16469012.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetReset(RESET_PHASE+PHASE_END,2)
	Duel.RegisterEffect(e1,tp)
end
