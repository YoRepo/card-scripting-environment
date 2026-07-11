--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Scary Moth  (ID: 68087897)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Insect
-- Level: 6
-- ATK 1800 | DEF 2300
-- Scope: OCG / TCG
--
-- Effect Text:
-- Each player can only Special Summon a monster(s) once per turn.
--[[ __CARD_HEADER_END__ ]]

--スケイルモース
function c68087897.initial_effect(c)
	Duel.EnableGlobalFlag(GLOBALFLAG_SPSUMMON_COUNT)
	--spsummon count limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_COUNT_LIMIT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,1)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
