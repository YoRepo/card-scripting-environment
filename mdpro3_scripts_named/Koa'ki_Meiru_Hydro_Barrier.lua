--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 核成全护者  (ID: 31692182)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level 3
-- ATK 1000 | DEF 1900
-- Setcode: 29
--
-- Effect Text:
-- 从手卡让1张「核成兽的钢核」回到卡组最上面发动。直到下次的自己回合的准备阶段时，名字带有「核成」的怪兽以外的场上表侧表示存在的效果怪兽的效果无效化。
--[[ __CARD_HEADER_END__ ]]

--コアキメイル・フルバリア
function c31692182.initial_effect(c)
	aux.AddCodeList(c,36623431)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(31692182,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c31692182.cost)
	e1:SetOperation(c31692182.operation)
	c:RegisterEffect(e1)
end
function c31692182.cfilter(c)
	return c:IsCode(36623431) and c:IsAbleToDeckAsCost()
end
function c31692182.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c31692182.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c31692182.cfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoDeck(g,nil,SEQ_DECKTOP,REASON_COST)
end
function c31692182.filter(e,c)
	return c:IsType(TYPE_EFFECT) and not c:IsSetCard(0x1d)
end
function c31692182.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(c31692182.filter)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetReset(RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN)
	Duel.RegisterEffect(e1,tp)
end
