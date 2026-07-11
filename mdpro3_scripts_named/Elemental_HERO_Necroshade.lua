--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Elemental HERO Necroshade  (ID: 89252153)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Warrior
-- Level: 5
-- ATK 1600 | DEF 1800
-- Setcode: 0x3008
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once, while this card is in the GY, you can Normal Summon 1 Level 5 or higher "Elemental HERO"
-- monster without Tributing.
--[[ __CARD_HEADER_END__ ]]

--E・HERO ネクロダークマン
function c89252153.initial_effect(c)
	--summon with no tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(89252153,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetTargetRange(LOCATION_HAND,0)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e1:SetCountLimit(1)
	e1:SetCondition(c89252153.ntcon)
	e1:SetTarget(c89252153.nttg)
	c:RegisterEffect(e1)
end
function c89252153.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c89252153.nttg(e,c)
	return c:IsLevelAbove(5) and c:IsSetCard(0x3008)
end
