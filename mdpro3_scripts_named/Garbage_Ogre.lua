--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 垃圾食人魔  (ID: 18698739)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 3
-- ATK 800 | DEF 1300
--
-- Effect Text:
-- 自己的主要阶段时，把这张卡从手卡送去墓地才能发动。从卡组把1只「垃圾王」加入手卡。「垃圾食人魔」的效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--ガーベージ・オーガ
function c18698739.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(18698739,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,18698739)
	e1:SetCost(c18698739.cost)
	e1:SetTarget(c18698739.target)
	e1:SetOperation(c18698739.operation)
	c:RegisterEffect(e1)
end
function c18698739.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c18698739.filter(c)
	return c:IsCode(44682448) and c:IsAbleToHand()
end
function c18698739.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c18698739.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c18698739.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstMatchingCard(c18698739.filter,tp,LOCATION_DECK,0,nil)
	if tc then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
