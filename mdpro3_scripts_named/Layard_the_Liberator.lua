--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 救济之莱亚德  (ID: 67468948)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 4
-- ATK 1400 | DEF 1500
--
-- Effect Text:
-- ①：只要这张卡在怪兽区域存在，每次自己或者对方把反击陷阱卡发动，选除外的2只自己的天使族怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--救済のレイヤード
function c67468948.initial_effect(c)
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAIN_SOLVED)
	e1:SetRange(LOCATION_MZONE)
	e1:SetOperation(c67468948.drop)
	c:RegisterEffect(e1)
end
function c67468948.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_FAIRY) and c:IsAbleToHand()
end
function c67468948.drop(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsHasType(EFFECT_TYPE_ACTIVATE) or not re:IsActiveType(TYPE_COUNTER) then return end
	Duel.BreakEffect()
	local g=Duel.GetMatchingGroup(c67468948.filter,tp,LOCATION_REMOVED,0,nil)
	if g:GetCount()<2 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local sg=g:Select(tp,2,2,nil)
	Duel.SendtoHand(sg,nil,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,sg)
end
