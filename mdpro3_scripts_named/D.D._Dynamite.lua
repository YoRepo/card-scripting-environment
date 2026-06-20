--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: D.D.炸药  (ID: 8628798)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 给与对方基本分对方除外的卡数×300的伤害。
--[[ __CARD_HEADER_END__ ]]

--D.D.ダイナマイト
function c8628798.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1c1)
	e1:SetTarget(c8628798.target)
	e1:SetOperation(c8628798.activate)
	c:RegisterEffect(e1)
end
function c8628798.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_REMOVED,1,nil) end
	Duel.SetTargetPlayer(1-tp)
	local dam=Duel.GetFieldGroupCount(1-tp,LOCATION_REMOVED,0)*300
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c8628798.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local dam=Duel.GetFieldGroupCount(1-tp,LOCATION_REMOVED,0)*300
	Duel.Damage(p,dam,REASON_EFFECT)
end
