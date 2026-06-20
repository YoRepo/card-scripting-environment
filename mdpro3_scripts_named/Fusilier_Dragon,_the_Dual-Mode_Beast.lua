--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:29
-- Card: 可变机兽 炮手龙  (ID: 51632798)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level 7
-- ATK 2800 | DEF 2000
--
-- Effect Text:
-- ①：这张卡可以不用解放作通常召唤。
-- ②：这张卡的①的方法通常召唤的这张卡的原本的攻击力·守备力变成一半。
--[[ __CARD_HEADER_END__ ]]

--可変機獣 ガンナードラゴン
function c51632798.initial_effect(c)
	--summon & set with no tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(51632798,0))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c51632798.ntcon)
	e1:SetOperation(c51632798.ntop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_PROC)
	c:RegisterEffect(e2)
end
function c51632798.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:IsLevelAbove(5) and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c51632798.ntop(e,tp,eg,ep,ev,re,r,rp,c)
	--change base attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(1400)
	e1:SetReset(RESET_EVENT+0xff0000)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_BASE_DEFENSE)
	e2:SetValue(1000)
	c:RegisterEffect(e2)
end
