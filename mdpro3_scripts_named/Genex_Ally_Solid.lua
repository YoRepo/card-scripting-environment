--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 盟军·次世代冷冻兵  (ID: 83500096)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level 2
-- ATK 500 | DEF 1200
-- Setcode: 2
--
-- Effect Text:
-- ①：1回合1次，把自己场上1只表侧表示的水属性「次世代」怪兽送去墓地才能发动。自己抽2张。
--[[ __CARD_HEADER_END__ ]]

--A・ジェネクス・ソリッド
function c83500096.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(83500096,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c83500096.drcost)
	e1:SetTarget(c83500096.drtg)
	e1:SetOperation(c83500096.drop)
	c:RegisterEffect(e1)
end
function c83500096.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x2) and c:IsAttribute(ATTRIBUTE_WATER) and c:IsAbleToGraveAsCost()
end
function c83500096.drcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c83500096.cfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c83500096.cfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c83500096.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c83500096.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
