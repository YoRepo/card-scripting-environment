--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 自爆开关  (ID: 57585212)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 当自己的基本分比对方少7000以上时这张卡才能发动。双方的基本分全都变成0。
--[[ __CARD_HEADER_END__ ]]

--自爆スイッチ
function c57585212.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c57585212.condition)
	e1:SetOperation(c57585212.activate)
	c:RegisterEffect(e1)
end
function c57585212.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)<=Duel.GetLP(1-tp)-7000
end
function c57585212.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetLP(tp,0)
	Duel.SetLP(1-tp,0)
end
