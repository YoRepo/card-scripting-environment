--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 全弹发射  (ID: 70865988)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这张卡发动后，把手卡全部送去墓地。给与对方基本分送去墓地的卡数量×200数值的伤害。
--[[ __CARD_HEADER_END__ ]]

--全弾発射
function c70865988.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c70865988.target)
	e1:SetOperation(c70865988.activate)
	c:RegisterEffect(e1)
end
function c70865988.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>0 end
	Duel.SetTargetPlayer(1-tp)
	local dam=Duel.GetFieldGroupCount(1-tp,LOCATION_HAND,0)*200
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c70865988.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	if Duel.SendtoGrave(g,REASON_EFFECT)>0 then
		local og=Duel.GetOperatedGroup()
		local dam=og:FilterCount(Card.IsLocation,nil,LOCATION_GRAVE)*200
		local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
		Duel.Damage(p,dam,REASON_EFFECT)
	end
end
