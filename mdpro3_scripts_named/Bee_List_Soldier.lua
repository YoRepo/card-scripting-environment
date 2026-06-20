--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 小蜜蜂  (ID: 1474910)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Insect
-- Level 1
-- ATK 500 | DEF 400
--
-- Effect Text:
-- 把这张卡和自己场上表侧表示存在的「小蜜蜂」以外的1只昆虫族怪兽解放发动。从自己卡组抽2张卡。
--[[ __CARD_HEADER_END__ ]]

--ハチビー
function c1474910.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1474910,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c1474910.cost)
	e1:SetTarget(c1474910.target)
	e1:SetOperation(c1474910.operation)
	c:RegisterEffect(e1)
end
function c1474910.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_INSECT) and not c:IsCode(1474910)
end
function c1474910.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() and Duel.CheckReleaseGroup(tp,c1474910.cfilter,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c1474910.cfilter,1,1,nil)
	g:AddCard(e:GetHandler())
	Duel.Release(g,REASON_COST)
end
function c1474910.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c1474910.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
