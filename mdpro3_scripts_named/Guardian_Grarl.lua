--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 守护者·格拉尔  (ID: 47150851)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Dinosaur
-- Level 5
-- ATK 2500 | DEF 1000
-- Setcode: 82
--
-- Effect Text:
-- 当自己场上存在「重力之斧-咆哮」时才能召唤·反转召唤·特殊召唤。当手卡仅有这张卡1张时，这张卡可以从手卡直接特殊召唤上场。
--[[ __CARD_HEADER_END__ ]]

--ガーディアン・グラール
function c47150851.initial_effect(c)
	--sum limit
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetCondition(c47150851.sumcon)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(EFFECT_SPSUMMON_CONDITION)
	e3:SetValue(c47150851.sumlimit)
	c:RegisterEffect(e3)
	--spsummon
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_SPSUMMON_PROC)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e4:SetRange(LOCATION_HAND)
	e4:SetCondition(c47150851.spcon)
	c:RegisterEffect(e4)
end
function c47150851.cfilter(c)
	return c:IsFaceup() and c:IsCode(32022366)
end
function c47150851.sumcon(e)
	return not Duel.IsExistingMatchingCard(c47150851.cfilter,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,1,nil)
end
function c47150851.sumlimit(e,se,sp,st,pos,tp)
	return Duel.IsExistingMatchingCard(c47150851.cfilter,sp,LOCATION_ONFIELD,0,1,nil)
end
function c47150851.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)==1
		and Duel.IsExistingMatchingCard(c47150851.cfilter,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,1,nil)
end
