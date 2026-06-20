--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 魔玩具补缀  (ID: 34773082)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 173
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：从卡组把1张「融合」和1只「锋利小鬼」怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--魔玩具補綴
function c34773082.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,34773082+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c34773082.target)
	e1:SetOperation(c34773082.activate)
	c:RegisterEffect(e1)
end
function c34773082.filter1(c)
	return c:IsCode(24094653) and c:IsAbleToHand()
end
function c34773082.filter2(c)
	return c:IsSetCard(0xc3) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c34773082.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c34773082.filter1,tp,LOCATION_DECK,0,1,nil)
		and Duel.IsExistingMatchingCard(c34773082.filter2,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,2,tp,LOCATION_DECK)
end
function c34773082.activate(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(c34773082.filter1,tp,LOCATION_DECK,0,nil)
	local g2=Duel.GetMatchingGroup(c34773082.filter2,tp,LOCATION_DECK,0,nil)
	if g1:GetCount()>0 and g2:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg1=g1:Select(tp,1,1,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg2=g2:Select(tp,1,1,nil)
		sg1:Merge(sg2)
		Duel.SendtoHand(sg1,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg1)
	end
end
