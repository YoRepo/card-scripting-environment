--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 伤停补时  (ID: 72453068)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：对方基本分是4000以上的场合，自己基本分变成比对方少1000的数值。
--[[ __CARD_HEADER_END__ ]]

--ロスタイム
function c72453068.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,72453068+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c72453068.condition)
	e1:SetOperation(c72453068.activate)
	c:RegisterEffect(e1)
end
function c72453068.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(1-tp)>=4000 and Duel.GetLP(tp)~=Duel.GetLP(1-tp)-1000
end
function c72453068.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLP(1-tp)>=4000 and Duel.GetLP(tp)~=Duel.GetLP(1-tp)-1000 then
		Duel.SetLP(tp,Duel.GetLP(1-tp)-1000)
	end
end
