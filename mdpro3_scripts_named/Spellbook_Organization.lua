--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 魔导书整理  (ID: 96677818)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 4206
--
-- Effect Text:
-- 翻开自己卡组最上面3张卡，将其按喜欢的顺序放回。对方不能确认这些卡。
--[[ __CARD_HEADER_END__ ]]

--魔導書整理
function c96677818.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c96677818.target)
	e1:SetOperation(c96677818.activate)
	c:RegisterEffect(e1)
end
function c96677818.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>2 end
end
function c96677818.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.SortDecktop(tp,tp,3)
end
