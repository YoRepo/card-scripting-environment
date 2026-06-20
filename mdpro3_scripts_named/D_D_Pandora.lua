--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: DD 潘多拉  (ID: 32146097)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 5
-- ATK 1700 | DEF 2100
-- Setcode: 175
--
-- Effect Text:
-- ①：这张卡被战斗或者对方的效果破坏送去墓地时，自己场上没有卡存在的场合才能发动。自己从卡组抽2张。
--[[ __CARD_HEADER_END__ ]]

--DDパンドラ
function c32146097.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCondition(c32146097.drcon)
	e1:SetTarget(c32146097.drtg)
	e1:SetOperation(c32146097.drop)
	c:RegisterEffect(e1)
end
function c32146097.drcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return (c:IsReason(REASON_BATTLE)
		or rp==1-tp and c:IsReason(REASON_DESTROY) and c:IsPreviousControler(tp))
		and Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD,0)==0
end
function c32146097.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c32146097.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
