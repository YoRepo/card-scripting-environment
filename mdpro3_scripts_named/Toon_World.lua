--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 卡通世界  (ID: 15259703)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 98
--
-- Effect Text:
-- 支付1000基本分才能把这张卡发动。
--[[ __CARD_HEADER_END__ ]]

--トゥーン・ワールド
function c15259703.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c15259703.cost)
	c:RegisterEffect(e1)
end
function c15259703.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
