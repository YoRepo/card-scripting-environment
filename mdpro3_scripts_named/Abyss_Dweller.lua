--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 深渊的潜伏者  (ID: 21044178)
-- Type: Monster / Effect / Xyz
-- Attribute: WATER
-- Race: Sea Serpent
-- Rank 4
-- ATK 1700 | DEF 1400
--
-- Effect Text:
-- 4星怪兽×2
-- ①：这张卡有水属性怪兽在作为超量素材的场合，自己场上的水属性怪兽的攻击力上升500。
-- ②：自己·对方回合1次，把这张卡1个超量素材取除才能发动。这个回合，对方不能把墓地的卡的效果发动。
--[[ __CARD_HEADER_END__ ]]

--深淵に潜む者
function c21044178.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,2)
	c:EnableReviveLimit()
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCondition(c21044178.atkcon)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsAttribute,ATTRIBUTE_WATER))
	e1:SetValue(500)
	c:RegisterEffect(e1)
	--activate limit
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(21044178,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(0,TIMING_DRAW_PHASE)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c21044178.cost)
	e2:SetTarget(c21044178.target)
	e2:SetOperation(c21044178.operation)
	c:RegisterEffect(e2)
end
function c21044178.atkcon(e)
	return e:GetHandler():GetOverlayGroup():IsExists(Card.IsAttribute,1,nil,ATTRIBUTE_WATER)
end
function c21044178.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c21044178.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,21044178)==0 end
end
function c21044178.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(0,1)
	e1:SetValue(c21044178.aclimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	Duel.RegisterFlagEffect(tp,21044178,RESET_PHASE+PHASE_END,0,0)
end
function c21044178.aclimit(e,re,tp)
	return re:GetActivateLocation()==LOCATION_GRAVE
end
