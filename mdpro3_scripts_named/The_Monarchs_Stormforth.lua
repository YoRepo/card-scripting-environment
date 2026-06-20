--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 帝王的烈旋  (ID: 79844764)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 190
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张，这张卡发动的回合，自己不能从额外卡组把怪兽特殊召唤。
-- ①：这个回合，自己把怪兽上级召唤的场合只有1次，可以作为自己场上1只怪兽的代替而把对方场上1只怪兽解放。
--[[ __CARD_HEADER_END__ ]]

--帝王の烈旋
function c79844764.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,79844764+EFFECT_COUNT_CODE_OATH)
	e1:SetHintTiming(0,TIMING_MAIN_END)
	e1:SetCost(c79844764.cost)
	e1:SetOperation(c79844764.activate)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(79844764,ACTIVITY_SPSUMMON,c79844764.counterfilter)
end
function c79844764.counterfilter(c)
	return not c:IsSummonLocation(LOCATION_EXTRA)
end
function c79844764.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(79844764,tp,ACTIVITY_SPSUMMON)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c79844764.splimit)
	Duel.RegisterEffect(e1,tp)
end
function c79844764.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return c:IsLocation(LOCATION_EXTRA)
end
function c79844764.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_EXTRA_RELEASE_SUM)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e1:SetCountLimit(1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
