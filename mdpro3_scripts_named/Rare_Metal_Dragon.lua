--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Rare Metal Dragon  (ID: 25236056)
-- Type: Monster / Effect / Special Summon
-- Attribute: DARK
-- Race: Dragon
-- Level: 4
-- ATK 2400 | DEF 1200
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card cannot be Normal Summoned or Set.
--[[ __CARD_HEADER_END__ ]]

--レアメタル・ドラゴン
function c25236056.initial_effect(c)
	--splimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c25236056.splimit)
	c:RegisterEffect(e1)
end
function c25236056.splimit(e,se,sp,st)
	return se:IsHasType(EFFECT_TYPE_ACTIONS)
end
