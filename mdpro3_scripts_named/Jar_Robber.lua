--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 盗壶者  (ID: 33784505)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 「强欲之壶」发动时才能发动。使「强欲之壶」的效果无效，从自己卡组抽1张卡。
--[[ __CARD_HEADER_END__ ]]

--壺盗み
function c33784505.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c33784505.condition)
	e1:SetTarget(c33784505.target)
	e1:SetOperation(c33784505.activate)
	c:RegisterEffect(e1)
end
function c33784505.condition(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:GetHandler():IsCode(55144522) and Duel.IsChainNegatable(ev)
end
function c33784505.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c33784505.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateEffect(ev) then
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
