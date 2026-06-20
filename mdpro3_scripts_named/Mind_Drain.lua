--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 精神抽取  (ID: 68937720)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 支付1000基本分才能把这张卡发动。
-- ①：只要这张卡在魔法与陷阱区域存在，双方不能把手卡的怪兽的效果发动。
--[[ __CARD_HEADER_END__ ]]

--メンタルドレイン
function c68937720.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c68937720.cost)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(1,1)
	e2:SetValue(c68937720.aclimit)
	c:RegisterEffect(e2)
end
function c68937720.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c68937720.aclimit(e,re,tp)
	local rc=re:GetHandler()
	return rc:IsLocation(LOCATION_HAND) and re:IsActiveType(TYPE_MONSTER)
end
