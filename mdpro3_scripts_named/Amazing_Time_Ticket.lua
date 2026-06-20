--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 惊奇时段通行证  (ID: 70389815)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：支付800基本分才能发动。发动回合的以下效果适用。
-- ●自己回合：从卡组把1张「惊乐」卡加入手卡。
-- ●对方回合：从卡组选1张「游乐设施」陷阱卡在自己的魔法与陷阱区域盖放。这个效果盖放的卡在盖放的回合也能发动。
--[[ __CARD_HEADER_END__ ]]

--アメイジングタイムチケット
function c70389815.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_SSET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,70389815+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c70389815.cost)
	e1:SetTarget(c70389815.target)
	e1:SetOperation(c70389815.activate)
	c:RegisterEffect(e1)
end
function c70389815.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,800) end
	Duel.PayLPCost(tp,800)
end
function c70389815.thfilter(c)
	return c:IsSetCard(0x15b) and c:IsAbleToHand()
end
function c70389815.setfilter(c)
	return c:IsSetCard(0x15c) and c:IsType(TYPE_TRAP) and c:IsSSetable()
end
function c70389815.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if Duel.GetTurnPlayer()==tp then
		if chk==0 then return Duel.IsExistingMatchingCard(c70389815.thfilter,tp,LOCATION_DECK,0,1,nil) end
		e:SetCategory(CATEGORY_SEARCH)
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	else
		if chk==0 then return Duel.IsExistingMatchingCard(c70389815.setfilter,tp,LOCATION_DECK,0,1,nil) end
		e:SetCategory(CATEGORY_SSET)
	end
end
function c70389815.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetTurnPlayer()==tp then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c70389815.thfilter,tp,LOCATION_DECK,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
		local g=Duel.SelectMatchingCard(tp,c70389815.setfilter,tp,LOCATION_DECK,0,1,1,nil)
		local tc=g:GetFirst()
		if tc and Duel.SSet(tp,tc)~=0 then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetDescription(aux.Stringid(70389815,0))
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
			e1:SetCode(EFFECT_TRAP_ACT_IN_SET_TURN)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			tc:RegisterEffect(e1)
		end
	end
end
