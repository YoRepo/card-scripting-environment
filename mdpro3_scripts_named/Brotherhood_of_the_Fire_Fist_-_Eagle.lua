--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 炎星仙-鹫真人  (ID: 46241344)
-- Type: Monster / Effect / Link
-- Attribute: FIRE
-- Race: Beast-Warrior
-- ATK 1700 | LINK
-- Setcode: 121
--
-- Effect Text:
-- 兽战士族怪兽2只
-- 自己对「炎星仙-鹫真人」1回合只能有1次特殊召唤，那个②的效果1回合只能使用1次。
-- ①：只要这张卡在怪兽区域存在，自己把「炎星」怪兽的效果发动的场合，也能不把自己的手卡·场上的「炎星」卡以及「炎舞」卡送去墓地来发动。
-- ②：以自己的场上·墓地1张「炎舞」魔法·陷阱卡为对象才能发动。那张卡回到持有者手卡。那之后，从卡组把1只「炎星」怪兽送去墓地。
--[[ __CARD_HEADER_END__ ]]

--炎星仙－ワシンジン
function c46241344.initial_effect(c)
	c:SetSPSummonOnce(46241344)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkRace,RACE_BEASTWARRIOR),2,2)
	c:EnableReviveLimit()
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(46241344)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(1,0)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(46241344,1))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_DECKDES)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,46241344)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c46241344.thtg)
	e2:SetOperation(c46241344.thop)
	c:RegisterEffect(e2)
end
function c46241344.thfilter(c)
	return c:IsSetCard(0x7c) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
		and (c:IsFaceup() or c:IsLocation(LOCATION_GRAVE))
end
function c46241344.tgfilter(c)
	return c:IsSetCard(0x79) and c:IsType(TYPE_MONSTER) and c:IsAbleToGrave()
end
function c46241344.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_ONFIELD+LOCATION_GRAVE) and c46241344.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c46241344.thfilter,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,1,nil)
		and Duel.IsExistingMatchingCard(c46241344.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c46241344.thfilter,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c46241344.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SendtoHand(tc,nil,REASON_EFFECT)~=0 and tc:IsLocation(LOCATION_HAND) then
		local sg=Duel.GetMatchingGroup(c46241344.tgfilter,tp,LOCATION_DECK,0,nil)
		if sg:GetCount()>0 then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
			local tg=sg:Select(tp,1,1,nil)
			Duel.SendtoGrave(tg,REASON_EFFECT)
		end
	end
end
