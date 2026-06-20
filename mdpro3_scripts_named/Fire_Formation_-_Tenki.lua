--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 炎舞-「天玑」  (ID: 57103969)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 124
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：作为这张卡的发动时的效果处理，可以从卡组把1只4星以下的兽战士族怪兽加入手卡。
-- ②：只要这张卡在魔法与陷阱区域存在，自己场上的兽战士族怪兽的攻击力上升100。
--[[ __CARD_HEADER_END__ ]]

--炎舞－「天璣」
function c57103969.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,57103969+EFFECT_COUNT_CODE_OATH)
	e1:SetOperation(c57103969.activate)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_BEASTWARRIOR))
	e2:SetValue(100)
	c:RegisterEffect(e2)
end
function c57103969.filter(c)
	return c:IsLevelBelow(4) and c:IsRace(RACE_BEASTWARRIOR) and c:IsAbleToHand()
end
function c57103969.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c57103969.filter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(57103969,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
