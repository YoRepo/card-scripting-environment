--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 元素充能  (ID: 36586443)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上表侧表示存在的名字带有「元素英雄」的怪兽每有1只，自己回复1000基本分。
--[[ __CARD_HEADER_END__ ]]

--エレメンタル・チャージ
function c36586443.initial_effect(c)
	--recover
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c36586443.target)
	e1:SetOperation(c36586443.operation)
	c:RegisterEffect(e1)
end
function c36586443.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c36586443.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.SetTargetPlayer(tp)
	local rec=Duel.GetMatchingGroupCount(c36586443.filter,tp,LOCATION_MZONE,0,nil)*1000
	Duel.SetTargetParam(rec)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,rec)
end
function c36586443.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x3008)
end
function c36586443.operation(e,tp,eg,ep,ev,re,r,rp)
	local rec=Duel.GetMatchingGroupCount(c36586443.filter,tp,LOCATION_MZONE,0,nil)*1000
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.Recover(p,rec,REASON_EFFECT)
end
