--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 暴君的暴饮暴食  (ID: 48357738)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 把自己场上存在的1只怪兽解放发动。只要这张卡在场上存在，双方不能把6星以上的怪兽特殊召唤。自己手卡是3张以上的场合，这张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--暴君の暴飲暴食
function c48357738.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c48357738.cost)
	c:RegisterEffect(e1)
	--spsummon limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,1)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsLevelAbove,6))
	c:RegisterEffect(e2)
	--des
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EFFECT_SELF_DESTROY)
	e3:SetCondition(c48357738.descon)
	c:RegisterEffect(e3)
end
function c48357738.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,nil,1,nil) end
	local rg=Duel.SelectReleaseGroup(tp,nil,1,1,nil)
	Duel.Release(rg,REASON_COST)
end
function c48357738.descon(e)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_HAND,0)>=3
end
