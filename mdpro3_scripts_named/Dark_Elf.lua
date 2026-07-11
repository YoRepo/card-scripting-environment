--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Dark Elf  (ID: 21417692)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level: 4
-- ATK 2000 | DEF 800
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card requires a cost of 1000 of your own Life Points to attack.
--[[ __CARD_HEADER_END__ ]]

--ダーク・エルフ
function c21417692.initial_effect(c)
	--attack cost
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ATTACK_COST)
	e1:SetCost(c21417692.atcost)
	e1:SetOperation(c21417692.atop)
	c:RegisterEffect(e1)
end
function c21417692.atcost(e,c,tp)
	return Duel.CheckLPCost(tp,1000)
end
function c21417692.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.PayLPCost(tp,1000)
end
