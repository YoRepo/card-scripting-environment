--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 生命转换  (ID: 17178486)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 双方基本分有8000以上的相差的场合才能发动。双方基本分变成3000。
--[[ __CARD_HEADER_END__ ]]

--ライフチェンジャー
function c17178486.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c17178486.condition)
	e1:SetOperation(c17178486.activate)
	c:RegisterEffect(e1)
end
function c17178486.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)-Duel.GetLP(1-tp)>=8000 or Duel.GetLP(1-tp)-Duel.GetLP(tp)>=8000
end
function c17178486.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetLP(tp,3000)
	Duel.SetLP(1-tp,3000)
end
