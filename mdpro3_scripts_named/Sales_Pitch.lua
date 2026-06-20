--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 广告标语  (ID: 2971446)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：对方的效果让对方用抽卡以外的方法从卡组把卡加入手卡的场合才能发动。自己从卡组选1张卡，给双方确认加入手卡。这个回合，自己不能作这个效果加入手卡的卡以及那些同名卡的效果的发动。
--[[ __CARD_HEADER_END__ ]]

--キャッチ・コピー
function c2971446.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_TO_HAND)
	e1:SetCountLimit(1,2971446+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c2971446.condition)
	e1:SetTarget(c2971446.target)
	e1:SetOperation(c2971446.activate)
	c:RegisterEffect(e1)
end
function c2971446.cfilter(c,tp)
	return c:IsControler(tp) and c:IsPreviousLocation(LOCATION_DECK) and c:IsReason(REASON_EFFECT) and not c:IsReason(REASON_DRAW)
end
function c2971446.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c2971446.cfilter,1,nil,1-tp) and rp==1-tp
end
function c2971446.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToHand,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c2971446.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToHand,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
		local tc=g:GetFirst()
		if tc:IsLocation(LOCATION_HAND) then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_FIELD)
			e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
			e1:SetCode(EFFECT_CANNOT_ACTIVATE)
			e1:SetTargetRange(1,0)
			e1:SetValue(c2971446.aclimit)
			e1:SetLabel(tc:GetCode())
			e1:SetReset(RESET_PHASE+PHASE_END)
			Duel.RegisterEffect(e1,tp)
		end
	end
end
function c2971446.aclimit(e,re,tp)
	return re:GetHandler():IsCode(e:GetLabel())
end
