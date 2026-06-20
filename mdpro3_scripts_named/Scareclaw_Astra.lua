--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 恐吓爪牙族·雷电恐惧兽  (ID: 83488497)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast
-- Level 3
-- ATK 0 | DEF 1300
-- Setcode: 378
--
-- Effect Text:
-- 这个卡名的①的方法的特殊召唤1回合只能有1次。
-- ①：这张卡可以从手卡往自己场上的「恐吓爪牙族」怪兽的相邻的或者相同纵列的自己的主要怪兽区域特殊召唤。
-- ②：只要自己场上有守备表示的「恐吓爪牙族」怪兽存在，额外怪兽区域的自己的「恐吓爪牙族」怪兽在同1次的战斗阶段中可以作出最多有那个种类数量的攻击。
--[[ __CARD_HEADER_END__ ]]

--スケアクロー・アストラ
local s,id,o=GetID()
function c83488497.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(s.hspcon)
	e1:SetValue(s.hspval)
	c:RegisterEffect(e1)
	--extra attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_EXTRA_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCondition(c83488497.exatkcon)
	e2:SetTarget(c83488497.exatktg)
	e2:SetValue(c83488497.exatkval)
	c:RegisterEffect(e2)
end
function s.cfilter(c)
	return c:IsSetCard(0x17a) and c:IsFaceup()
end
function s.getzone(tp)
	local zone=0
	local g=Duel.GetMatchingGroup(s.cfilter,tp,LOCATION_MZONE,0,nil)
	for tc in aux.Next(g) do
		local seq=tc:GetSequence()
		if seq==5 or seq==6 then
			zone=zone|(1<<aux.MZoneSequence(seq))
		else
			if seq>0 then zone=zone|(1<<(seq-1)) end
			if seq<4 then zone=zone|(1<<(seq+1)) end
		end
	end
	return zone
end
function s.hspcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local zone=s.getzone(tp)
	return Duel.GetLocationCount(tp,LOCATION_MZONE,tp,LOCATION_REASON_TOFIELD,zone)>0
end
function s.hspval(e,c)
	local tp=c:GetControler()
	return 0,s.getzone(tp)
end
function c83488497.deffilter(c)
	return c:IsDefensePos() and c:IsSetCard(0x17a) and c:IsFaceup()
end
function c83488497.exatkcon(e)
	local tp=e:GetHandlerPlayer()
	return Duel.IsExistingMatchingCard(c83488497.deffilter,tp,LOCATION_MZONE,0,1,nil)
end
function c83488497.exatktg(e,c)
	return c:IsSetCard(0x17a) and c:GetSequence()>=5
end
function c83488497.exatkval(e)
	local tp=e:GetHandlerPlayer()
	local g=Duel.GetMatchingGroup(c83488497.deffilter,tp,LOCATION_MZONE,0,nil)
	return g:GetClassCount(Card.GetCode)-1
end
