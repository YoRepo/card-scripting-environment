--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Gem-Knight Seraphinite  (ID: 3113836)
-- Type: Monster / Effect / Fusion
-- Attribute: EARTH
-- Race: Fairy
-- Level: 5
-- ATK 2300 | DEF 1400
-- Setcode: 0x1047
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 "Gem-Knight" monster + 1 LIGHT monster
-- Must first be Fusion Summoned with the above Fusion Materials.
-- During your Main Phase, you can Normal Summon/Set 1 monster in addition to your Normal Summon/Set.
-- (You can only gain this effect once per turn.)
--[[ __CARD_HEADER_END__ ]]

--ジェムナイト・セラフィ
function c3113836.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x1047),aux.FilterBoolFunction(Card.IsFusionAttribute,ATTRIBUTE_LIGHT),false)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c3113836.splimit)
	c:RegisterEffect(e1)
	--extra summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(3113836,0))
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
	e2:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e2:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_EXTRA_SET_COUNT)
	c:RegisterEffect(e3)
end
function c3113836.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA) or bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
