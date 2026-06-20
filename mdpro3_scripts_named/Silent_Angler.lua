--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 寂静鮟鱇  (ID: 90303176)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Fish
-- Level 4
-- ATK 800 | DEF 1400
--
-- Effect Text:
-- ①：自己场上有水属性怪兽存在的场合，这张卡可以从手卡特殊召唤。这个方法特殊召唤过的回合，自己不能从手卡把怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--サイレント・アングラー
function c90303176.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c90303176.spcon)
	e1:SetOperation(c90303176.spop)
	c:RegisterEffect(e1)
end
function c90303176.filter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WATER)
end
function c90303176.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c90303176.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
function c90303176.spop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c90303176.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c90303176.splimit(e,c,sump,sumtype,sumpos,targetp)
	return c:IsLocation(LOCATION_HAND)
end
