--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 荷鲁斯的荣光-伊姆塞特  (ID: 84941194)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level 8
-- ATK 3000 | DEF 1800
-- Setcode: 413
--
-- Effect Text:
-- 这个卡名的①的方法的特殊召唤1回合只能有1次，②③的效果1回合各能使用1次。
-- ①：自己场上有「王之棺」存在的场合，这张卡可以从墓地特殊召唤。
-- ②：从手卡把包含这张卡的2张卡送去墓地才能发动。从卡组把1张「王之棺」加入手卡。那之后，自己可以抽1张。
-- ③：这张卡在怪兽区域存在的状态，自己场上的其他卡因对方的效果从场上离开的场合才能发动。场上1张卡送去墓地。
--[[ __CARD_HEADER_END__ ]]

--ホルスの栄光－イムセティ
function c84941194.initial_effect(c)
	aux.AddCodeList(c,16528181)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,84941194+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c84941194.sprcon)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(84941194,0))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_HAND)
	e2:SetCountLimit(1,84941195)
	e2:SetCost(c84941194.tgcost)
	e2:SetTarget(c84941194.target)
	e2:SetOperation(c84941194.operation)
	c:RegisterEffect(e2)
	--Leave Field
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(84941194,1))
	e3:SetCategory(CATEGORY_TOGRAVE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,84941196)
	e3:SetCondition(c84941194.descon)
	e3:SetTarget(c84941194.destg)
	e3:SetOperation(c84941194.desop)
	c:RegisterEffect(e3)
end
function c84941194.sprfilter(c)
	return c:IsFaceup() and c:IsCode(16528181)
end
function c84941194.sprcon(e,c)
	if c==nil then return true end
	if c:IsHasEffect(EFFECT_NECRO_VALLEY) then return false end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c84941194.sprfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c84941194.costfilter(c)
	return c:IsAbleToGraveAsCost()
end
function c84941194.tgcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c84941194.costfilter,tp,LOCATION_HAND,0,1,c) and c:IsAbleToGraveAsCost() end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c84941194.costfilter,tp,LOCATION_HAND,0,1,1,c)
	g:AddCard(c)
	Duel.SendtoGrave(g,REASON_COST)
end
function c84941194.filter(c)
	return c:IsCode(16528181) and c:IsAbleToHand()
end
function c84941194.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c84941194.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c84941194.operation(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetFirstMatchingCard(c84941194.filter,tp,LOCATION_DECK,0,nil)
	if tg and Duel.SendtoHand(tg,nil,REASON_EFFECT)~=0 and Duel.ConfirmCards(1-tp,tg)~=0
		and Duel.IsPlayerCanDraw(tp,1) and Duel.SelectYesNo(tp,aux.Stringid(84941194,2)) then
			Duel.ShuffleDeck(tp)
			Duel.BreakEffect()
			Duel.Draw(tp,1,REASON_EFFECT)
	end
end
function c84941194.cfilter(c,tp)
	return c:IsPreviousControler(tp)
		and c:GetReasonPlayer()==1-tp and c:IsReason(REASON_EFFECT)
end
function c84941194.descon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c84941194.cfilter,1,nil,tp) and not eg:IsContains(e:GetHandler())
end
function c84941194.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_ONFIELD)
end
function c84941194.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToGrave,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
