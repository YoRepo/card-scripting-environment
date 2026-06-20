--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 异次元竞技场  (ID: 31849106)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：这个回合，被送去墓地的怪兽不去墓地而除外。
--[[ __CARD_HEADER_END__ ]]

--異次元グランド
function c31849106.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c31849106.activate)
	c:RegisterEffect(e1)
end
function c31849106.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCode(EFFECT_TO_GRAVE_REDIRECT)
	e1:SetTarget(aux.DimensionalFissureTarget)
	e1:SetTargetRange(LOCATION_DECK,LOCATION_DECK)
	e1:SetValue(LOCATION_REMOVED)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
