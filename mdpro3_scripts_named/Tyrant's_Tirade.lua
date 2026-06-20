--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 暴君的暴言  (ID: 76721030)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 把自己场上存在的2只怪兽解放发动。只要这张卡在场上存在，双方不能把手卡以及场上发动的效果怪兽的效果发动。
--[[ __CARD_HEADER_END__ ]]

--暴君の暴言
function c76721030.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c76721030.cost)
	c:RegisterEffect(e1)
	--cannot trigger
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(1,1)
	e2:SetValue(c76721030.aclimit)
	c:RegisterEffect(e2)
end
function c76721030.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,nil,2,nil) end
	local rg=Duel.SelectReleaseGroup(tp,nil,2,2,nil)
	Duel.Release(rg,REASON_COST)
end
function c76721030.aclimit(e,re,tp)
	local loc=re:GetActivateLocation()
	return (loc==LOCATION_MZONE or loc==LOCATION_HAND) and re:IsActiveType(TYPE_MONSTER)
end
