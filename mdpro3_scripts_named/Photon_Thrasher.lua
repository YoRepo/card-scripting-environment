--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 光子斩击者  (ID: 65367484)
-- Type: Monster / Effect / SpecialSummon
-- Attribute: LIGHT
-- Race: Warrior
-- Level 4
-- ATK 2100 | DEF 0
-- Setcode: 85
--
-- Effect Text:
-- 这张卡不能通常召唤。自己场上没有怪兽存在的场合可以特殊召唤。
-- ①：只要自己场上有其他怪兽存在，这张卡不能攻击。
--[[ __CARD_HEADER_END__ ]]

--フォトン・スラッシャー
function c65367484.initial_effect(c)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c65367484.spcon)
	c:RegisterEffect(e1)
	--cannot attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	e2:SetCondition(c65367484.atcon)
	c:RegisterEffect(e2)
end
function c65367484.spcon(e,c)
	if c==nil then return true end
	return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_MZONE,0)==0
		and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c65367484.atcon(e)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_MZONE,0)>1
end
