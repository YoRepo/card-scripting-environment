--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Barrier Statue of the Heavens  (ID: 46145256)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level: 4
-- ATK 1000 | DEF 1000
-- Scope: OCG / TCG
--
-- Effect Text:
-- Neither player can Special Summon monsters, except LIGHT monsters.
--[[ __CARD_HEADER_END__ ]]

--閃光の結界像
function c46145256.initial_effect(c)
	--disable spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,1)
	e1:SetTarget(c46145256.sumlimit)
	c:RegisterEffect(e1)
end
function c46145256.sumlimit(e,c,sump,sumtype,sumpos,targetp)
	return c:GetAttribute()~=ATTRIBUTE_LIGHT
end
