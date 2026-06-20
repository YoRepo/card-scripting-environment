--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 魔制产卵床  (ID: 51324455)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上表侧表示存在的鱼族·海龙族·水族怪兽从游戏中除外时才能发动。从自己卡组把1只4星以下的鱼族·海龙族·水族怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--魔製産卵床
function c51324455.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_REMOVE)
	e1:SetCondition(c51324455.condition)
	e1:SetTarget(c51324455.target)
	e1:SetOperation(c51324455.activate)
	c:RegisterEffect(e1)
end
function c51324455.cfilter(c,tp)
	return c:IsFaceup() and c:IsPreviousLocation(LOCATION_MZONE) and c:IsPreviousPosition(POS_FACEUP)
		and c:IsPreviousControler(tp) and c:IsRace(RACE_FISH+RACE_SEASERPENT+RACE_AQUA)
end
function c51324455.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c51324455.cfilter,1,nil,tp)
end
function c51324455.filter(c)
	return c:IsLevelBelow(4) and c:IsRace(RACE_FISH+RACE_SEASERPENT+RACE_AQUA) and c:IsAbleToHand()
end
function c51324455.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c51324455.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c51324455.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c51324455.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
