--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 邪心英雄 黯星金魔  (ID: 13650422)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fiend
-- Level 4
-- ATK 2100 | DEF 800
-- Setcode: 24584
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：把这张卡从手卡丢弃才能发动。除「邪心英雄 黯星金魔」外的1张「暗黑融合」或者有那个卡名记述的卡从卡组加入手卡。
-- ②：自己场上没有融合怪兽存在的场合，这张卡不能攻击。
--[[ __CARD_HEADER_END__ ]]

--E-HERO アダスター・ゴールド
function c13650422.initial_effect(c)
	aux.AddCodeList(c,94820406)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,13650422)
	e1:SetCost(c13650422.cost)
	e1:SetTarget(c13650422.target)
	e1:SetOperation(c13650422.operation)
	c:RegisterEffect(e1)
	--atklimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	e2:SetCondition(c13650422.atkcon)
	c:RegisterEffect(e2)
end
function c13650422.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsDiscardable() end
	Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
end
function c13650422.filter(c)
	return aux.IsCodeOrListed(c,94820406) and not c:IsCode(13650422) and c:IsAbleToHand()
end
function c13650422.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c13650422.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c13650422.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c13650422.filter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c13650422.cfilter(c)
	return c:IsType(TYPE_FUSION) and c:IsFaceup()
end
function c13650422.atkcon(e)
	return not Duel.IsExistingMatchingCard(c13650422.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
