--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 自奏圣乐的主音  (ID: 26845680)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 283
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：从自己的手卡·场上（表侧表示）把1只「自奏圣乐」怪兽或「星遗物」怪兽送去墓地才能发动。自己抽2张。
--[[ __CARD_HEADER_END__ ]]

--オルフェゴール・プライム
function c26845680.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,26845680+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c26845680.cost)
	e1:SetTarget(c26845680.target)
	e1:SetOperation(c26845680.activate)
	c:RegisterEffect(e1)
end
function c26845680.costfilter(c)
	return c:IsSetCard(0xfe,0x11b) and c:IsType(TYPE_MONSTER) and (c:IsFaceup() or not c:IsLocation(LOCATION_MZONE)) and c:IsAbleToGraveAsCost()
end
function c26845680.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c26845680.costfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c26845680.costfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c26845680.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c26845680.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
