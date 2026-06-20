--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 野兽战士 豹人  (ID: 16796157)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Beast-Warrior
-- Level 4
-- ATK 1600 | DEF 1000
--
-- Effect Text:
-- 把这张卡解放才能发动。从自己的卡组·墓地把1只「异次元超能人·星斗罗宾」加入手卡。
--[[ __CARD_HEADER_END__ ]]

--野獣戦士ピューマン
function c16796157.initial_effect(c)
	--salvage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(16796157,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c16796157.thcost)
	e1:SetTarget(c16796157.thtg)
	e1:SetOperation(c16796157.thop)
	c:RegisterEffect(e1)
end
function c16796157.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c16796157.filter(c)
	return c:IsCode(80208158) and c:IsAbleToHand()
end
function c16796157.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c16796157.filter,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE+LOCATION_DECK)
end
function c16796157.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c16796157.filter),tp,LOCATION_GRAVE+LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
