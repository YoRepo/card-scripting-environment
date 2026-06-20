--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 我我我防御  (ID: 76972801)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 84
--
-- Effect Text:
-- 自己场上有名字带有「我我我」的怪兽2只以上存在的场合才能发动。这个回合，自己场上的怪兽不会被战斗以及卡的效果破坏。
--[[ __CARD_HEADER_END__ ]]

--ガガガガード
function c76972801.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c76972801.condition)
	e1:SetOperation(c76972801.activate)
	c:RegisterEffect(e1)
end
function c76972801.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x54)
end
function c76972801.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c76972801.cfilter,tp,LOCATION_MZONE,0,2,nil)
end
function c76972801.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetValue(1)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	Duel.RegisterEffect(e2,tp)
end
