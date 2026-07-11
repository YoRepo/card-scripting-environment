--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Majestic Dragon  (ID: 21159309)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Dragon
-- Level: 1
-- ATK 0 | DEF 0
-- Setcode: 0x3f
-- Scope: OCG / TCG
--
-- Effect Text:
-- Cannot be used as Synchro Material, except for the Synchro Summon of a "Majestic" monster.
--[[ __CARD_HEADER_END__ ]]

--救世竜 セイヴァー・ドラゴン
function c21159309.initial_effect(c)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetValue(c21159309.synlimit)
	c:RegisterEffect(e2)
end
function c21159309.synlimit(e,c)
	if not c then return false end
	return not c:IsSetCard(0x3f)
end
