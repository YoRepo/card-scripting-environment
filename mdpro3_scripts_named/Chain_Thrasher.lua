--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Chain Thrasher  (ID: 88190453)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Warrior
-- Level: 4
-- ATK 1000 | DEF 600
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can attack 1 additional time during the same Battle Phase for each "Chain Thrasher" in
-- your Graveyard.
--[[ __CARD_HEADER_END__ ]]

--チェイン・スラッシャー
function c88190453.initial_effect(c)
	--multiattack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetValue(c88190453.val)
	c:RegisterEffect(e1)
end
function c88190453.val(e,c)
	return Duel.GetMatchingGroupCount(Card.IsCode,e:GetHandlerPlayer(),LOCATION_GRAVE,0,nil,88190453)
end
