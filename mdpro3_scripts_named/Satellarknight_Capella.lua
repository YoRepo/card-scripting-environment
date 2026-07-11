--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Satellarknight Capella  (ID: 86466163)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level: 4
-- ATK 1100 | DEF 2000
-- Setcode: 0x9c
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is Summoned: You can apply the effect below for the rest of this turn.
-- You can only use this effect of "Satellarknight Capella" once per turn (but if it resolves, you can
-- apply the effect multiple times).
-- ● You can treat Level 4 or lower "tellarknight" monsters you control as Level 5 when Xyz Summoning
-- using 3 or more monsters as Xyz Materials.
--[[ __CARD_HEADER_END__ ]]

--星因士 カペラ
function c86466163.initial_effect(c)
	Duel.EnableGlobalFlag(GLOBALFLAG_XMAT_COUNT_LIMIT)
	--xyzlv
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(86466163,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,86466163)
	e1:SetOperation(c86466163.operation)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	c86466163.star_knight_summon_effect=e1
end
function c86466163.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_XYZ_LEVEL)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c86466163.xyztg)
	e1:SetValue(c86466163.xyzlv)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c86466163.xyztg(e,c)
	return c:IsLevelBelow(4) and c:IsSetCard(0x9c)
end
function c86466163.xyzlv(e,c,rc)
	return 0x30050000|aux.GetCappedXyzLevel(c)
end
