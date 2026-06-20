--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 念力触发器  (ID: 55673611)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己基本分比对方低的场合才能发动。把自己墓地存在的2只念动力族怪兽从游戏中除外，从自己卡组抽2张卡。
--[[ __CARD_HEADER_END__ ]]

--サイコ・トリガー
function c55673611.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c55673611.condition)
	e1:SetTarget(c55673611.target)
	e1:SetOperation(c55673611.activate)
	c:RegisterEffect(e1)
end
function c55673611.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)<Duel.GetLP(1-tp)
end
function c55673611.filter(c)
	return c:IsRace(RACE_PSYCHO) and c:IsAbleToRemove()
end
function c55673611.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c55673611.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c55673611.filter,tp,LOCATION_GRAVE,0,2,nil) and Duel.IsPlayerCanDraw(tp,2) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c55673611.filter,tp,LOCATION_GRAVE,0,2,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,2,tp,LOCATION_GRAVE)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c55673611.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	if Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)==2 then
		Duel.Draw(tp,2,REASON_EFFECT)
	end
end
