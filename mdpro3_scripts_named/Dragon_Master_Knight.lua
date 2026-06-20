--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 究极龙骑士  (ID: 62873545)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Dragon
-- Level 12
-- ATK 5000 | DEF 5000
--
-- Effect Text:
-- 「混沌战士」＋「青眼究极龙」
-- 这张卡不用融合召唤不能特殊召唤。
-- ①：这张卡的攻击力上升自己场上的其他的龙族怪兽数量×500。
--[[ __CARD_HEADER_END__ ]]

--究極竜騎士
function c62873545.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,5405694,23995346,true,true)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.fuslimit)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(c62873545.atkval)
	c:RegisterEffect(e2)
end
function c62873545.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_DRAGON)
end
function c62873545.atkval(e,c)
	return Duel.GetMatchingGroupCount(c62873545.filter,c:GetControler(),LOCATION_MZONE,0,c)*500
end
