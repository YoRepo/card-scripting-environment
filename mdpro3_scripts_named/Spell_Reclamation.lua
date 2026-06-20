--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 魔法捕获  (ID: 76137276)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己把魔法卡发动时，丢弃1张手卡连锁发动。连锁发动的魔法卡被送去墓地时，那张卡回到手卡。
--[[ __CARD_HEADER_END__ ]]

--マジック・キャプチャー
function c76137276.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c76137276.condition)
	e1:SetCost(c76137276.cost)
	e1:SetOperation(c76137276.activate)
	c:RegisterEffect(e1)
end
function c76137276.condition(e,tp,eg,ep,ev,re,r,rp)
	return rp==tp and re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_SPELL)
end
function c76137276.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD,nil)
end
function c76137276.activate(e,tp,eg,ep,ev,re,r,rp)
	if re:GetHandler():IsRelateToEffect(re) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_TO_GRAVE)
		e1:SetOperation(c76137276.thop)
		e1:SetReset(RESET_EVENT+0x17a0000)
		re:GetHandler():RegisterEffect(e1)
	end
end
function c76137276.thop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsHasEffect(EFFECT_NECRO_VALLEY) then
		Duel.SendtoHand(e:GetHandler(),tp,REASON_EFFECT)
	end
end
