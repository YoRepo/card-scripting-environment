--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 混沌贪欲  (ID: 97439308)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 207
--
-- Effect Text:
-- 当自己的卡有4张以上从游戏中除外，且自己的墓地里没有卡存在时这张卡才能发动。从自己的卡组抽2张卡。
--[[ __CARD_HEADER_END__ ]]

--カオス・グリード
function c97439308.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c97439308.condition)
	e1:SetTarget(c97439308.target)
	e1:SetOperation(c97439308.activate)
	c:RegisterEffect(e1)
end
function c97439308.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_REMOVED,0)>=4
		and Duel.GetFieldGroupCount(tp,LOCATION_GRAVE,0)==0
end
function c97439308.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c97439308.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
