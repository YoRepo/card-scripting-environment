--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 暴君的暴力  (ID: 38318146)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 把自己场上存在的2只怪兽解放发动。只要这张卡在场上存在，对方若不从卡组把1张魔法卡送去墓地则不能把魔法卡发动。
--[[ __CARD_HEADER_END__ ]]

--暴君の暴力
function c38318146.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c38318146.cost)
	c:RegisterEffect(e1)
	--activate cost
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_ACTIVATE_COST)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(0,1)
	e2:SetCondition(c38318146.accon)
	e2:SetTarget(c38318146.actarget)
	e2:SetCost(c38318146.accost)
	e2:SetOperation(c38318146.acop)
	c:RegisterEffect(e2)
end
function c38318146.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,nil,2,nil) end
	local rg=Duel.SelectReleaseGroup(tp,nil,2,2,nil)
	Duel.Release(rg,REASON_COST)
end
function c38318146.accon(e)
	c38318146[0]=false
	return true
end
function c38318146.acfilter(c)
	return c:IsType(TYPE_SPELL) and c:IsAbleToGraveAsCost()
end
function c38318146.actarget(e,te,tp)
	return te:IsActiveType(TYPE_SPELL) and te:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c38318146.accost(e,te,tp)
	return Duel.IsExistingMatchingCard(c38318146.acfilter,tp,LOCATION_DECK,0,1,nil)
end
function c38318146.acop(e,tp,eg,ep,ev,re,r,rp)
	if c38318146[0] then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c38318146.acfilter,tp,LOCATION_DECK,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
	c38318146[0]=true
end
