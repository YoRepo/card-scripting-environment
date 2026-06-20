--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 生命力吸收魔术  (ID: 99517131)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 将场上所有里侧守备表示的怪兽全部变成表侧表示。此时反转效果不发动。之后场上每存在1只效果怪兽，自己回复400基本分。
--[[ __CARD_HEADER_END__ ]]

--生命力吸収魔術
function c99517131.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c99517131.target)
	e1:SetOperation(c99517131.activate)
	c:RegisterEffect(e1)
end
function c99517131.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_EFFECT)
end
function c99517131.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(nil,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local rec=Duel.GetMatchingGroupCount(c99517131.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)*400
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(rec)
	if rec>0 then Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,rec) end
end
function c99517131.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFacedown,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.ChangePosition(g,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK,POS_FACEUP_DEFENSE,POS_FACEUP_DEFENSE,true)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local rec=Duel.GetMatchingGroupCount(c99517131.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)*400
	Duel.Recover(p,rec,REASON_EFFECT)
end
