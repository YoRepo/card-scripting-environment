--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 闪刀起动-交闪  (ID: 63166095)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 277
--
-- Effect Text:
-- ①：自己的主要怪兽区域没有怪兽存在的场合才能发动。从卡组把「闪刀起动-交闪」以外的1张「闪刀」卡加入手卡。那之后，自己墓地有魔法卡3张以上存在的场合，自己可以抽1张。
--[[ __CARD_HEADER_END__ ]]

--閃刀起動－エンゲージ
function c63166095.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c63166095.condition)
	e1:SetTarget(c63166095.target)
	e1:SetOperation(c63166095.activate)
	c:RegisterEffect(e1)
end
function c63166095.cfilter(c)
	return c:GetSequence()<5
end
function c63166095.condition(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c63166095.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c63166095.filter(c)
	return c:IsSetCard(0x115) and c:IsAbleToHand() and not c:IsCode(63166095)
end
function c63166095.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c63166095.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	if Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_GRAVE,0,nil,TYPE_SPELL)>=3 then
		Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
	end
end
function c63166095.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c63166095.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
		if Duel.IsPlayerCanDraw(tp,1)
			and Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_GRAVE,0,nil,TYPE_SPELL)>=3
			and Duel.SelectYesNo(tp,aux.Stringid(63166095,0)) then
			Duel.BreakEffect()
			Duel.ShuffleDeck(tp)
			Duel.Draw(tp,1,REASON_EFFECT)
		end
	end
end
