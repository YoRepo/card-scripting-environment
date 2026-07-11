--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Mermaid Knight  (ID: 24435369)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level: 4
-- ATK 1500 | DEF 700
-- Scope: OCG / TCG
--
-- Effect Text:
-- As long as "Umi" remains face-up on the field, this card can attack twice during the same Battle
-- Phase.
--[[ __CARD_HEADER_END__ ]]

--マーメイド・ナイト
function c24435369.initial_effect(c)
	aux.AddCodeList(c,22702055)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetCondition(c24435369.dircon)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
function c24435369.dircon(e)
	return Duel.IsEnvironment(22702055)
end
