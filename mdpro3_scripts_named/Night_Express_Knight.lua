--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 深夜急行骑士  (ID: 51126152)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level 10
-- ATK 3000 | DEF 3000
--
-- Effect Text:
-- 这张卡不能从卡组特殊召唤。
-- ①：这张卡可以不用解放作召唤。
-- ②：这张卡的①的方法召唤的这张卡的原本攻击力变成0。
--[[ __CARD_HEADER_END__ ]]

--深夜急行騎士ナイト・エクスプレス・ナイト
function c51126152.initial_effect(c)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_DECK)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--summon with no tribute
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(51126152,0))
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SUMMON_PROC)
	e2:SetCondition(c51126152.ntcon)
	e2:SetOperation(c51126152.ntop)
	c:RegisterEffect(e2)
end
function c51126152.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:IsLevelAbove(5) and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c51126152.ntop(e,tp,eg,ep,ev,re,r,rp,c)
	--change base attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetValue(0)
	e1:SetReset(RESET_EVENT+0xff0000)
	c:RegisterEffect(e1)
end
