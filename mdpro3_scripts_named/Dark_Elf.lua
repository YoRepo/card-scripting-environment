--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 暗精灵  (ID: 21417692)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level 4
-- ATK 2000 | DEF 800
--
-- Effect Text:
-- 这张卡不支付1000基本分不能攻击。
--[[ __CARD_HEADER_END__ ]]

--ダーク・エルフ
function c21417692.initial_effect(c)
	--attack cost
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ATTACK_COST)
	e1:SetCost(c21417692.atcost)
	e1:SetOperation(c21417692.atop)
	c:RegisterEffect(e1)
end
function c21417692.atcost(e,c,tp)
	return Duel.CheckLPCost(tp,1000)
end
function c21417692.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.PayLPCost(tp,1000)
end
