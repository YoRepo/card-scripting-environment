--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 龙骑士 黑魔术少女  (ID: 43892408)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Dragon
-- Level 7
-- ATK 2600 | DEF 1700
-- Setcode: 12450
--
-- Effect Text:
-- 「黑魔术少女」＋龙族怪兽
-- 这张卡用以上记的卡为融合素材的融合召唤以及用「蒂迈欧之眼」的效果才能特殊召唤。
-- ①：自己·对方回合1次，把1张手卡送去墓地，以场上1张表侧表示卡为对象才能发动。那张表侧表示卡破坏。
--[[ __CARD_HEADER_END__ ]]

--竜騎士ブラック・マジシャン・ガール
function c43892408.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,38033121,aux.FilterBoolFunction(Card.IsRace,RACE_DRAGON),1,false,false)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c43892408.splimit)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(43892408,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c43892408.cost)
	e2:SetTarget(c43892408.target)
	e2:SetOperation(c43892408.activate)
	c:RegisterEffect(e2)
end
function c43892408.splimit(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION or se:GetHandler():IsCode(1784686)
end
function c43892408.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGraveAsCost,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsAbleToGraveAsCost,1,1,REASON_COST)
end
function c43892408.filter(c)
	return c:IsFaceup()
end
function c43892408.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c43892408.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c43892408.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c43892408.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c43892408.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
