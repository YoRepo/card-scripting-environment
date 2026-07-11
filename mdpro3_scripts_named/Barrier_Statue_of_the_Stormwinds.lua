--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Barrier Statue of the Stormwinds  (ID: 73356503)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Winged Beast
-- Level: 4
-- ATK 1000 | DEF 1000
-- Scope: OCG / TCG
--
-- Effect Text:
-- Neither player can Special Summon monsters, except WIND monsters.
--[[ __CARD_HEADER_END__ ]]

--烈風の結界像
function c73356503.initial_effect(c)
	--disable spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,1)
	e1:SetTarget(c73356503.sumlimit)
	c:RegisterEffect(e1)
end
function c73356503.sumlimit(e,c,sump,sumtype,sumpos,targetp)
	return c:GetAttribute()~=ATTRIBUTE_WIND
end
