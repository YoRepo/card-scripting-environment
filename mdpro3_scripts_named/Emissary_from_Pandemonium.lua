--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 来自地狱的使者  (ID: 42685062)
-- Type: Monster / Effect / Tuner
-- Attribute: EARTH
-- Race: Fiend
-- Level 7
-- ATK 2600 | DEF 1800
--
-- Effect Text:
-- 这张卡不能特殊召唤。这张卡可以把1只怪兽解放作召唤。这个方法召唤的这张卡的等级变成5星，原本的攻击力·守备力变成一半数值。
--[[ __CARD_HEADER_END__ ]]

--地獄からの使い
function c42685062.initial_effect(c)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(42685062,0))
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SUMMON_PROC)
	e2:SetCondition(c42685062.sumcon)
	e2:SetOperation(c42685062.sumop)
	e2:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e2)
end
function c42685062.sumcon(e,c,minc)
	if c==nil then return true end
	return minc<=1 and Duel.CheckTribute(c,1)
end
function c42685062.sumop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectTribute(tp,c,1,1)
	c:SetMaterial(g)
	Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_LEVEL)
	e1:SetValue(5)
	e1:SetReset(RESET_EVENT+0xff0000)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_BASE_ATTACK)
	e2:SetValue(1300)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EFFECT_SET_BASE_DEFENSE)
	e3:SetValue(900)
	c:RegisterEffect(e3)
end
