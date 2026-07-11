--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Night Dragolich  (ID: 88724332)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Wyrm
-- Level: 4
-- ATK 1700 | DEF 0
-- Scope: OCG / TCG
--
-- Effect Text:
-- Change all non-Wyrm-Type Attack Position monsters that were Special Summoned from the Main or Extra
-- Deck to Defense Position.
-- All non-Wyrm-Type monsters that were Special Summoned from the Main or Extra Deck lose DEF equal to
-- their original DEF.
--[[ __CARD_HEADER_END__ ]]

--ナイト・ドラゴリッチ
function c88724332.initial_effect(c)
	--pos change
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SET_POSITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c88724332.target)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetValue(POS_FACEUP_DEFENSE)
	c:RegisterEffect(e1)
	--def
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c88724332.deftg)
	e2:SetValue(c88724332.defval)
	c:RegisterEffect(e2)
end
function c88724332.target(e,c)
	return c:IsFaceup() and not c:IsRace(RACE_WYRM)
		and c:IsSummonType(SUMMON_TYPE_SPECIAL)
		and c:IsSummonLocation(LOCATION_DECK+LOCATION_EXTRA)
end
function c88724332.deftg(e,c)
	return c:IsFaceup() and not c:IsRace(RACE_WYRM)
		and c:IsSummonType(SUMMON_TYPE_SPECIAL)
		and c:IsSummonLocation(LOCATION_DECK+LOCATION_EXTRA)
end
function c88724332.defval(e,c)
	return -c:GetBaseDefense()
end
