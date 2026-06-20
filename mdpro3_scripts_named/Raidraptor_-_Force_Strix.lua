--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 急袭猛禽-武力林鸮  (ID: 73347079)
-- Type: Monster / Effect / Xyz
-- Attribute: DARK
-- Race: Winged Beast
-- Rank 4
-- ATK 100 | DEF 2000
-- Setcode: 186
--
-- Effect Text:
-- 4星怪兽×2
-- ①：这张卡的攻击力·守备力上升自己场上的其他的鸟兽族怪兽数量×500。
-- ②：1回合1次，把这张卡1个超量素材取除才能发动。从卡组把1只鸟兽族·暗属性·4星怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--RR－フォース・ストリクス
function c73347079.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,2)
	c:EnableReviveLimit()
	--atk/def
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c73347079.adval)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e2)
	--search
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCost(c73347079.thcost)
	e3:SetTarget(c73347079.thtg)
	e3:SetOperation(c73347079.thop)
	c:RegisterEffect(e3)
end
function c73347079.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_WINDBEAST)
end
function c73347079.adval(e,c)
	return Duel.GetMatchingGroupCount(c73347079.filter,c:GetControler(),LOCATION_MZONE,0,c)*500
end
function c73347079.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c73347079.thfilter(c)
	return c:IsLevel(4) and c:IsRace(RACE_WINDBEAST) and c:IsAttribute(ATTRIBUTE_DARK) and c:IsAbleToHand()
end
function c73347079.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c73347079.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c73347079.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c73347079.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
