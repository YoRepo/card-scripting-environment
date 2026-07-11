--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Superalloy Beast Raptinus  (ID: 64463828)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Dragon
-- Level: 8
-- ATK 2200 | DEF 2200
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 Gemini Monster + 1 Gemini Monster
-- All Gemini Monsters on the field are treated as Effect Monsters, and gain their effects.
--[[ __CARD_HEADER_END__ ]]

--超合魔獣ラプテノス
function c64463828.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsFusionType,TYPE_DUAL),2,true)
	--duel status
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_DUAL))
	e1:SetCode(EFFECT_DUAL_STATUS)
	c:RegisterEffect(e1)
end
