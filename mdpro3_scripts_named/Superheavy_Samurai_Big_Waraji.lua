--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 超重武者 大草鞋-G  (ID: 36523152)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level 5
-- ATK 800 | DEF 1800
-- Setcode: 154
--
-- Effect Text:
-- ①：自己墓地没有魔法·陷阱卡存在的场合，这张卡可以从手卡特殊召唤。这个方法特殊召唤成功的回合，自己不是「超重武者」怪兽不能特殊召唤。
-- ②：机械族怪兽上级召唤的场合，这张卡可以作为2只的数量解放。
--[[ __CARD_HEADER_END__ ]]

--超重武者ビッグワラ－G
function c36523152.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c36523152.spcon)
	e1:SetOperation(c36523152.spop)
	c:RegisterEffect(e1)
	--double tribute
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DOUBLE_TRIBUTE)
	e2:SetValue(c36523152.condition)
	c:RegisterEffect(e2)
end
function c36523152.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and not Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_GRAVE,0,1,nil,TYPE_SPELL+TYPE_TRAP)
end
function c36523152.spop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c36523152.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c36523152.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsSetCard(0x9a)
end
function c36523152.condition(e,c)
	return c:IsRace(RACE_MACHINE)
end
