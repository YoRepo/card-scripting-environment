--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: The Fabled Rubyruda  (ID: 94845226)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Beast
-- Level: 4
-- ATK 1100 | DEF 800
-- Setcode: 0x35
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this face-up card you control is targeted for an attack: You can discard 1 "Fabled" monster;
-- negate that attack.
--[[ __CARD_HEADER_END__ ]]

--魔轟神獣ルビィラーダ
function c94845226.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(94845226,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCost(c94845226.cost)
	e1:SetOperation(c94845226.op)
	c:RegisterEffect(e1)
end
function c94845226.cfilter(c)
	return c:IsSetCard(0x35) and c:IsType(TYPE_MONSTER) and c:IsDiscardable()
end
function c94845226.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c94845226.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c94845226.cfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c94845226.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
