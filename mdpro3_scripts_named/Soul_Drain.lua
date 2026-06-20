--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 灵魂抽取  (ID: 73599290)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 支付1000基本分才能发动。只要这张卡在场上存在，从游戏中除外的怪兽的效果以及墓地存在的怪兽的效果不能发动。
--[[ __CARD_HEADER_END__ ]]

--ソウルドレイン
function c73599290.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c73599290.cost)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(1,1)
	e2:SetValue(c73599290.aclimit)
	c:RegisterEffect(e2)
end
function c73599290.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c73599290.aclimit(e,re,tp)
	local loc=re:GetActivateLocation()
	return (loc==LOCATION_GRAVE or loc==LOCATION_REMOVED) and re:IsActiveType(TYPE_MONSTER)
end
