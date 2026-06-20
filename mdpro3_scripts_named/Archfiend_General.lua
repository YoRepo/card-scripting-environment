--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 将军恶魔  (ID: 48675364)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 4
-- ATK 2100 | DEF 800
-- Setcode: 69
--
-- Effect Text:
-- 把这张卡从手卡丢弃去墓地。从卡组把1张「万魔殿-恶魔的巢窟-」加入手卡。场上没有「万魔殿-恶魔的巢窟-」存在的场合，场上的这张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--ジェネラルデーモン
function c48675364.initial_effect(c)
	aux.AddCodeList(c,94585852)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(48675364,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(c48675364.cost)
	e1:SetTarget(c48675364.target)
	e1:SetOperation(c48675364.operation)
	c:RegisterEffect(e1)
	--self destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_SELF_DESTROY)
	e2:SetCondition(c48675364.descon)
	c:RegisterEffect(e2)
end
function c48675364.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToGraveAsCost() and c:IsDiscardable() end
	Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
end
function c48675364.filter(c)
	return c:IsCode(94585852) and c:IsAbleToHand()
end
function c48675364.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c48675364.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c48675364.operation(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetFirstMatchingCard(c48675364.filter,tp,LOCATION_DECK,0,nil)
	if tg then
		Duel.SendtoHand(tg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tg)
	end
end
function c48675364.descon(e)
	return not Duel.IsEnvironment(94585852)
end
