--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 马骨的对价  (ID: 18756904)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：把效果怪兽以外的自己场上1只表侧表示怪兽送去墓地才能发动。自己从卡组抽2张。
--[[ __CARD_HEADER_END__ ]]

--馬の骨の対価
function c18756904.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c18756904.cost)
	e1:SetTarget(c18756904.target)
	e1:SetOperation(c18756904.activate)
	c:RegisterEffect(e1)
end
function c18756904.filter(c)
	return c:IsFaceup() and not c:IsType(TYPE_EFFECT) and c:IsAbleToGraveAsCost()
end
function c18756904.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c18756904.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c18756904.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c18756904.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c18756904.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
