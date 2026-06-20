--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 武神帝-须佐之男  (ID: 75840616)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Beast-Warrior
-- Rank 4
-- ATK 2400 | DEF 1600
-- Setcode: 136
--
-- Effect Text:
-- 4星「武神」怪兽×2
-- ①：「武神帝-须佐之男」在自己场上只能有1只表侧表示存在。
-- ②：这张卡可以向对方怪兽全部各作1次攻击。
-- ③：1回合1次，把这张卡1个超量素材取除才能发动。从卡组选1只「武神」怪兽加入手卡或送去墓地。
--[[ __CARD_HEADER_END__ ]]

--武神帝－スサノヲ
function c75840616.initial_effect(c)
	c:SetUniqueOnField(1,0,75840616)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x88),4,2)
	c:EnableReviveLimit()
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_DECKDES)
	e1:SetDescription(aux.Stringid(75840616,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c75840616.cost)
	e1:SetTarget(c75840616.target)
	e1:SetOperation(c75840616.operation)
	c:RegisterEffect(e1)
	--attack all
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_ATTACK_ALL)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
function c75840616.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c75840616.filter(c)
	return c:IsSetCard(0x88) and c:IsType(TYPE_MONSTER) and (c:IsAbleToHand() or c:IsAbleToGrave())
end
function c75840616.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75840616.filter,tp,LOCATION_DECK,0,1,nil) end
end
function c75840616.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_OPERATECARD)
	local g=Duel.SelectMatchingCard(tp,c75840616.filter,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	if tc and tc:IsAbleToHand() and (not tc:IsAbleToGrave() or Duel.SelectOption(tp,1190,1191)==0) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	else
		Duel.SendtoGrave(tc,REASON_EFFECT)
	end
end
