--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 便乘  (ID: 48539234)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 对方在抽卡阶段以外抽卡时才能发动。那之后，每次对方在抽卡阶段以外抽卡，从自己卡组抽2张卡。
--[[ __CARD_HEADER_END__ ]]

--便乗
function c48539234.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DRAW)
	e1:SetCondition(c48539234.condition)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_DRAW)
	e2:SetCondition(c48539234.condition)
	e2:SetOperation(c48539234.operation)
	c:RegisterEffect(e2)
end
function c48539234.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and Duel.GetCurrentPhase()~=PHASE_DRAW
end
function c48539234.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,48539234)
	Duel.Draw(tp,2,REASON_EFFECT)
end
