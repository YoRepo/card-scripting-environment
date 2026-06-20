--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 银河的施舍  (ID: 20349913)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上有名字带有「银河」的超量怪兽存在的场合，丢弃1张手卡才能发动。从卡组抽2张卡。这张卡发动过的回合，对方受到的全部伤害变成一半。「银河的施舍」在1回合只能发动1张。
--[[ __CARD_HEADER_END__ ]]

--銀河の施し
function c20349913.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,20349913+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c20349913.condition)
	e1:SetCost(c20349913.cost)
	e1:SetTarget(c20349913.target)
	e1:SetOperation(c20349913.activate)
	c:RegisterEffect(e1)
end
function c20349913.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x7b) and c:IsType(TYPE_XYZ)
end
function c20349913.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c20349913.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c20349913.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD,nil)
end
function c20349913.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c20349913.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
	if e:IsHasType(EFFECT_TYPE_ACTIVATE) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CHANGE_DAMAGE)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetTargetRange(0,1)
		e1:SetValue(c20349913.damval)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
	end
end
function c20349913.damval(e,re,val,r,rp,rc)
	return math.floor(val/2)
end
